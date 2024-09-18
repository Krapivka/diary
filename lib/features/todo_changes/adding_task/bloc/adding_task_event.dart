part of 'adding_task_bloc.dart';

sealed class AddingTaskEvent extends Equatable {
  const AddingTaskEvent();

  @override
  List<Object> get props => [];
}

class AddingTaskTitleChanged extends AddingTaskEvent {
  const AddingTaskTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class AddingTaskDescriptionChanged extends AddingTaskEvent {
  const AddingTaskDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

// class AddingTaskImageTap extends AddingTaskEvent {
//   const AddingTaskImageTap();

//   @override
//   List<Object> get props => [];
// }

class AddingTaskDateChanged extends AddingTaskEvent {
  const AddingTaskDateChanged(this.dateTime);

  final DateTime? dateTime;

  @override
  List<Object> get props => [];
}

final class AddingTaskSubmitted extends AddingTaskEvent {
  const AddingTaskSubmitted();
}
