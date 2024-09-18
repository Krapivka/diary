part of 'todo_list_bloc.dart';

enum TasksListStatus {
  initial,
  loading,
  loaded,
  searchLoaded,
  failure,
  selectedTasksDeleted,
  changedCheck,
}

class TasksListState {
  const TasksListState({
    required this.taskListStatus,
    required this.listTaskModel,
    required this.selectedTaskId,
    required this.sortedListTaskModel,
  });

  final TasksListStatus taskListStatus;
  final List<TaskModel> listTaskModel;
  final List<int> selectedTaskId;
  final List<TaskModel> sortedListTaskModel;

  List<Object> get props =>
      [listTaskModel, selectedTaskId, sortedListTaskModel];

  TasksListState copyWith({
    TasksListStatus? taskListStatus,
    List<TaskModel>? listTaskModel,
    List<int>? selectedTaskId,
    List<TaskModel>? sortedListTaskModel,
  }) {
    return TasksListState(
      taskListStatus: taskListStatus ?? this.taskListStatus,
      listTaskModel: listTaskModel ?? this.listTaskModel,
      selectedTaskId: selectedTaskId ?? this.selectedTaskId,
      sortedListTaskModel: sortedListTaskModel ?? this.sortedListTaskModel,
    );
  }
}
