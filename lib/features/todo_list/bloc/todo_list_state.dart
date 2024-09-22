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

enum TaskFilter {
  all,
  completed,
  uncompleted,
}

class TasksListState {
  const TasksListState({
    required this.taskListStatus,
    required this.listTaskModel,
    required this.selectedTaskId,
    required this.sortedListTaskModel,
    required this.taskFilter, // Новое поле для фильтра
  });

  final TasksListStatus taskListStatus;
  final List<TaskModel> listTaskModel;
  final List<int> selectedTaskId;
  final List<TaskModel> sortedListTaskModel;
  final TaskFilter taskFilter; // Хранит текущее состояние фильтра

  List<Object> get props =>
      [taskListStatus, listTaskModel, selectedTaskId, taskFilter];

  TasksListState copyWith({
    TasksListStatus? taskListStatus,
    List<TaskModel>? listTaskModel,
    List<int>? selectedTaskId,
    List<TaskModel>? sortedListTaskModel,
    TaskFilter? taskFilter, // Копируем фильтр
  }) {
    return TasksListState(
      taskListStatus: taskListStatus ?? this.taskListStatus,
      listTaskModel: listTaskModel ?? this.listTaskModel,
      selectedTaskId: selectedTaskId ?? this.selectedTaskId,
      sortedListTaskModel: sortedListTaskModel ?? this.sortedListTaskModel,
      taskFilter: taskFilter ?? this.taskFilter,
    );
  }
}
