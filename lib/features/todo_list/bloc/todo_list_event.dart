part of 'todo_list_bloc.dart';

sealed class TasksListEvent extends Equatable {
  const TasksListEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksListEvent extends TasksListEvent {
  const LoadTasksListEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class DeleteTaskTasksListEvent extends TasksListEvent {
  const DeleteTaskTasksListEvent();
  @override
  List<Object?> get props => [];
}

class ChangeTaskCompleteListEvent extends TasksListEvent {
  const ChangeTaskCompleteListEvent({required this.task});
  final TaskModel task;
  @override
  List<Object?> get props => [];
}

class SearchTasksListEvent extends TasksListEvent {
  const SearchTasksListEvent({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}

class LongPressTaskCardEvent extends TasksListEvent {
  const LongPressTaskCardEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}

class TapTaskCardEvent extends TasksListEvent {
  const TapTaskCardEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}

class ChangeFilterEvent extends TasksListEvent {
  const ChangeFilterEvent({required this.filter});
  final TaskFilter filter;

  @override
  List<Object?> get props => [filter];
}
