import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/services/notification/notification_service.dart';
import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:diary/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc(this._taskRepository, task, this._settingsRepository)
      : super(UpdateTaskState.taskModel(task: task)) {
    on<UpdateTaskDelete>(_onDeleteTap);
    on<UpdateTaskTitleChanged>(_onNameChanged);
    on<UpdateTaskDateTap>(_onDateTap);
    on<UpdateTaskDescriptionChanged>(_onDescriptionChanged);
    on<UpdateTaskSave>(_onSave);
  }

  final AbstractTaskRepository _taskRepository;
  final AbstractSettingsRepository _settingsRepository;
  void _onNameChanged(
      UpdateTaskTitleChanged event, Emitter<UpdateTaskState> emit) {
    debugPrint("Name: ${event.title}");
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
      UpdateTaskDescriptionChanged event, Emitter<UpdateTaskState> emit) {
    debugPrint("Description: ${event.description}");
    emit(state.copyWith(description: event.description));
  }

  void _onDeleteTap(
      UpdateTaskDelete event, Emitter<UpdateTaskState> emit) async {
    final delTask = await _taskRepository.deleteTask(event.id);
    delTask.fold(
        (failure) => emit(state.copyWith(status: UpdateTaskStatus.failure)),
        (result) async {
      ///Cancel scheduling notifications

      await AwesomeNotifications().cancel(event.id);
      debugPrint("Delete Task with ID: ${event.id}");
    });

    emit(state.copyWith(status: UpdateTaskStatus.success));
  }

  void _onDateTap(UpdateTaskDateTap event, Emitter<UpdateTaskState> emit) {
    debugPrint("Date: ${event.birthdate}");
    emit(state.copyWith(dateTime: event.birthdate));
    debugPrint("Date: ${state.dateTime}");
  }

  void _onSave(UpdateTaskSave event, Emitter<UpdateTaskState> emit) async {
    emit(state.copyWith(status: UpdateTaskStatus.loading));

    try {
      if (state.title != '') {
        TaskModel task = TaskModel(
            id: state.id,
            description: state.description,
            title: state.title,
            dateTime: state.dateTime,
            isCompleted: state.isCompleted);

        final updateTask = await _taskRepository.updateTask(task);
        updateTask.fold(
            (failure) => emit(state.copyWith(status: UpdateTaskStatus.failure)),
            (result) async {
          //cancel notification
          await AwesomeNotifications().cancel(task.id).then((value) =>
              debugPrint("Notification with ID ${task.id} canceled"));
          //scheduling notification
          if (!task.isCompleted) {
            final notificationInterval =
                await _settingsRepository.getNotificationDayTime();
            notificationInterval.fold(
                (failure) =>
                    emit(state.copyWith(status: UpdateTaskStatus.failure)),
                (result) async {
              final taskTime = state.dateTime;
              await NotificationService.scheduleTaskNotification(
                  task: task,
                  id: task.id,
                  dateTime: taskTime,
                  hourNotif: result.hour,
                  minuteNotif: result.minute);
            });
          }
        });
        debugPrint("Update Task with id: ${task.id}");
        emit(state.copyWith(status: UpdateTaskStatus.success));
      } else {
        emit(state.copyWith(status: UpdateTaskStatus.validatorFailure));
        emit(state.copyWith(status: UpdateTaskStatus.initial));
      }
    } catch (e) {
      emit(state.copyWith(status: UpdateTaskStatus.failure));
    } finally {}
  }
}
