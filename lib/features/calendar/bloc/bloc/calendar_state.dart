part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  CalendarState({
    this.status = CalendarStatus.initial,
    tasks,
    tasksInSelectedDay,
    selectedDay,
    // ignore: prefer_collection_literals
  })  : tasks = tasks ?? LinkedHashMap<DateTime, List<TaskModel>>(),
        tasksInSelectedDay = tasksInSelectedDay ?? [],
        selectedDay = selectedDay ?? DateTime.now();

  final LinkedHashMap<DateTime, List<TaskModel>> tasks;
  final List<TaskModel> tasksInSelectedDay;
  final DateTime selectedDay;
  final CalendarStatus status;
  final DateTime today = DateTime.now();

  DateTime get firstDay => DateTime(today.year, 1, 1);

  DateTime get lastDay =>
      DateTime(today.year, 12, DateTime(today.year + 1, 1, 0).day);

  @override
  List<Object> get props => [status, tasks, tasksInSelectedDay];

  CalendarState copyWith({
    LinkedHashMap<DateTime, List<TaskModel>>? tasks,
    List<TaskModel>? tasksInSelectedDay,
    DateTime? selectedDay,
    CalendarStatus? status,
  }) {
    return CalendarState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      selectedDay: selectedDay ?? this.selectedDay,
      tasksInSelectedDay: tasksInSelectedDay ?? this.tasksInSelectedDay,
    );
  }
}
