part of 'update_task_bloc.dart';

sealed class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class UpdateTaskTitleChanged extends UpdateTaskEvent {
  const UpdateTaskTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

// class UpdateTaskImageTap extends UpdateTaskEvent {
//   const UpdateTaskImageTap();

//   @override
//   List<Object> get props => [];
// }

class UpdateTaskDateTap extends UpdateTaskEvent {
  const UpdateTaskDateTap(this.birthdate);

  final DateTime birthdate;

  @override
  List<Object> get props => [birthdate];
}

class UpdateTaskDescriptionChanged extends UpdateTaskEvent {
  const UpdateTaskDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class UpdateTaskDelete extends UpdateTaskEvent {
  const UpdateTaskDelete(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

final class UpdateTaskSave extends UpdateTaskEvent {
  const UpdateTaskSave();
  @override
  List<Object> get props => [];
}
