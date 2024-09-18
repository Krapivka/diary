part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarDateTap extends CalendarEvent {
  const CalendarDateTap(this.selectedDay);

  final DateTime selectedDay;

  @override
  List<Object> get props => [selectedDay];
}

class LoadTasksCalendar extends CalendarEvent {
  const LoadTasksCalendar();

  @override
  List<Object> get props => [];
}
