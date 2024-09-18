part of 'update_task_bloc.dart';

enum UpdateTaskStatus {
  initial,
  loading,
  success,
  failure,
  validatorFailure,
}

final currentDate = DateTime.now();

class UpdateTaskState extends Equatable {
  UpdateTaskState({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.status = UpdateTaskStatus.initial,
    this.isCompleted = false,
    dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  UpdateTaskState.taskModel({required TaskModel task})
      : title = task.title,
        dateTime = task.dateTime,
        status = UpdateTaskStatus.initial,
        description = task.description ?? '',
        isCompleted = task.isCompleted,
        id = task.id;

  final UpdateTaskStatus status;
  final int id;
  final String description;
  final String title;
  final DateTime dateTime;
  final bool isCompleted;
  @override
  List<Object> get props =>
      [status, id, title, description, dateTime, isCompleted];

  UpdateTaskState copyWith(
      {UpdateTaskStatus? status,
      int? id,
      String? title,
      String? description,
      bool? isCompleted,
      DateTime? dateTime}) {
    return UpdateTaskState(
      id: id ?? this.id,
      description: description ?? this.description,
      status: status ?? this.status,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
