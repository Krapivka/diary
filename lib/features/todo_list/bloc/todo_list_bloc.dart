import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diary/core/services/notification/notification_service.dart';

import '../../settings/data/repository/abstract_settings_repository.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  TasksListBloc(this._taskRepository, this._settingsRepository)
      : super(
          const TasksListState(
            taskListStatus: TasksListStatus.initial,
            listTaskModel: [],
            selectedTaskId: [],
            sortedListTaskModel: [],
          ),
        ) {
    on<LoadTasksListEvent>(_onLoadTasksList);
    on<SearchTasksListEvent>(_onSearchTask);
    on<LongPressTaskCardEvent>(_onLongPressTaskCardEvent);
    on<TapTaskCardEvent>(_onTapTaskCardEvent);
    on<DeleteTaskTasksListEvent>(_onDeleteTask);
    on<ChangeTaskCompleteListEvent>(_onChangeTaskComplete);
  }
  final AbstractTaskRepository _taskRepository;
  final AbstractSettingsRepository _settingsRepository;

  _onLoadTasksList(
      LoadTasksListEvent event, Emitter<TasksListState> emit) async {
    emit(state.copyWith(taskListStatus: TasksListStatus.loading));
    final listTaskModel = await _taskRepository.getAllTasks();
    listTaskModel.fold(
      (failure) =>
          emit(state.copyWith(taskListStatus: TasksListStatus.failure)),
      (result) => emit(state.copyWith(
          taskListStatus: TasksListStatus.loaded,
          listTaskModel: sortTasksByNearestTask(result as List<TaskModel>))),
    );
  }

  _onSearchTask(
      SearchTasksListEvent event, Emitter<TasksListState> emit) async {
    emit(state.copyWith(taskListStatus: TasksListStatus.loading));
    final listTaskModel = await _taskRepository.getAllTasks();
    listTaskModel.fold(
        (failure) =>
            emit(state.copyWith(taskListStatus: TasksListStatus.failure)),
        (result) {
      if (result.isEmpty || event.query == '') {
        emit(state.copyWith(
            taskListStatus: TasksListStatus.loaded,
            listTaskModel: sortTasksByNearestTask(result as List<TaskModel>)));
      } else {
        final query = event.query;

        debugPrint("Search: ${event.query}");
        final sortedList = result
            .where((task) =>
                (task.title.toLowerCase().contains(query.toLowerCase()) ||
                    (task.description != null &&
                        task.description!
                            .toLowerCase()
                            .contains(query.toLowerCase()))))
            .toList();

        emit(
          state.copyWith(
              taskListStatus: TasksListStatus.searchLoaded,
              sortedListTaskModel:
                  sortTasksByNearestTask(sortedList as List<TaskModel>)),
        );
      }
    });
  }

  _onLongPressTaskCardEvent(
      LongPressTaskCardEvent event, Emitter<TasksListState> emit) {
    List<int> selectedTaskId = state.selectedTaskId;
    if (state.selectedTaskId.contains(event.id)) {
      selectedTaskId.remove(event.id);
    } else {
      selectedTaskId = [...state.selectedTaskId, event.id];
    }
    emit(state.copyWith(selectedTaskId: selectedTaskId));
    debugPrint("${state.selectedTaskId}");
  }

  _onTapTaskCardEvent(TapTaskCardEvent event, Emitter<TasksListState> emit) {
    List<int> selectedTaskId = state.selectedTaskId;

    if (state.selectedTaskId.isNotEmpty &&
        state.selectedTaskId.contains(event.id)) {
      selectedTaskId.remove(event.id);
    } else if (state.selectedTaskId.isNotEmpty) {
      selectedTaskId = [...state.selectedTaskId, event.id];
    }
    emit(state.copyWith(selectedTaskId: selectedTaskId));
    debugPrint("${state.selectedTaskId}");
  }

  _onDeleteTask(
      DeleteTaskTasksListEvent event, Emitter<TasksListState> emit) async {
    for (int id in state.selectedTaskId) {
      final delTask = await _taskRepository.deleteTask(id);
      delTask.fold(
          (failure) =>
              emit(state.copyWith(taskListStatus: TasksListStatus.failure)),
          (result) async {
        ///Cancel scheduling notifications

        await AwesomeNotifications().cancel(id);
        debugPrint("Delete Task with ID: $id");
      });
    }
    emit(state.copyWith(
        selectedTaskId: [],
        taskListStatus: TasksListStatus.selectedTasksDeleted));
    add(const LoadTasksListEvent());
  }

  _onChangeTaskComplete(
      ChangeTaskCompleteListEvent event, Emitter<TasksListState> emit) async {
    TaskModel task = TaskModel(
      id: event.task.id,
      description: event.task.description,
      title: event.task.title,
      dateTime: event.task.dateTime,
      isCompleted: !event.task.isCompleted,
    );
    final updateTask = await _taskRepository.updateTask(task);
    updateTask.fold(
        (failure) =>
            emit(state.copyWith(taskListStatus: TasksListStatus.failure)),
        (result) async {
      //cancel notification
      if (task.isCompleted) {
        await AwesomeNotifications().cancel(task.id);
      } else {
        //scheduling notification
        final notificationInterval =
            await _settingsRepository.getNotificationDayTime();
        notificationInterval.fold(
            (failure) =>
                emit(state.copyWith(taskListStatus: TasksListStatus.failure)),
            (result) async {
          final taskTime = event.task.dateTime;
          await NotificationService.scheduleTaskNotification(
              task: task,
              id: task.id,
              dateTime: taskTime,
              hourNotif: result.hour,
              minuteNotif: result.minute);
        });
      }
      add(const LoadTasksListEvent());
    });
  }
}

List<TaskModel> sortTasksByNearestTask(List<TaskModel> tasks) {
  DateTime today = DateTime.now();
  DateTime yesterday = today.subtract(const Duration(days: 1));

  tasks.sort((a, b) {
    DateTime aNextTask = DateTime(today.year, a.dateTime.month, a.dateTime.day);
    DateTime bNextTask = DateTime(today.year, b.dateTime.month, b.dateTime.day);
    if (aNextTask.isBefore(yesterday)) {
      aNextTask = aNextTask.add(const Duration(days: 365));
    }
    if (bNextTask.isBefore(yesterday)) {
      bNextTask = bNextTask.add(const Duration(days: 365));
    }
    int result = aNextTask.compareTo(bNextTask);
    if (result == 0) {
      result = a.id.compareTo(b.id);
    }
    return result;
  });
  return tasks;
}
