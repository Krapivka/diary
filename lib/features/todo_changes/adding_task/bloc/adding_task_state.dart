part of 'adding_task_bloc.dart';

enum AddingTaskStatus { initial, loading, validatorFailure, success, failure }

final currentDate = DateTime.now();

class AddingTaskState extends Equatable {
  AddingTaskState({
    this.title = '',
    this.description = '',
    this.status = AddingTaskStatus.initial,
    dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  final AddingTaskStatus status;
  final String description;
  final String title;
  final DateTime dateTime;

  @override
  List<Object> get props => [status, title, description, dateTime];

  AddingTaskState copyWith({
    AddingTaskStatus? status,
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isCompleted,
  }) {
    return AddingTaskState(
      description: description ?? this.description,
      status: status ?? this.status,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
