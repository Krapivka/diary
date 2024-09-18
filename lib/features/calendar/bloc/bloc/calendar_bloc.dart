import 'dart:collection';

import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final AbstractTaskRepository _taskRepository;

  CalendarBloc(this._taskRepository) : super(CalendarState()) {
    on<LoadTasksCalendar>(_onLoadTasksCalendar);
    on<CalendarDateTap>(_onCalendarDateTap);
  }

  void _onLoadTasksCalendar(
      LoadTasksCalendar event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(status: CalendarStatus.loading));
    final listTaskModel = await _taskRepository.getAllTasks();

    listTaskModel
        .fold((failure) => emit(state.copyWith(status: CalendarStatus.failure)),
            (result) {
      Map<DateTime, List<TaskModel>> taskSource = {};

      for (var task in result as List<TaskModel>) {
        var dateKey = DateTime(
            DateTime.now().year, task.dateTime.month, task.dateTime.day);
        taskSource.putIfAbsent(dateKey, () => []);
        taskSource[dateKey]!.add(task);
      }

      final tasks = LinkedHashMap<DateTime, List<TaskModel>>(
        equals: isSameDay,
        hashCode: getHashCode,
      )..addAll(taskSource);

      emit(state.copyWith(status: CalendarStatus.success, tasks: tasks));
    });
  }

  void _onCalendarDateTap(
      CalendarDateTap event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(status: CalendarStatus.loading));
    final List<TaskModel> tasksInSelectedDay =
        state.tasks[event.selectedDay] ?? [];

    emit(state.copyWith(
        status: CalendarStatus.success,
        tasksInSelectedDay: tasksInSelectedDay,
        selectedDay: event.selectedDay));
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
