part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NoteClearEvent extends NoteEvent {
  @override
  List<Object> get props => [];
}

class NoteLoadEvent extends NoteEvent {
  @override
  List<Object> get props => [];
}

class NoteChangedEvent extends NoteEvent {
  final String note;

  const NoteChangedEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class TitleChangedEvent extends NoteEvent {
  final String title;

  const TitleChangedEvent({required this.title});

  @override
  List<Object> get props => [title];
}

class ColorChangedEvent extends NoteEvent {
  final Color color;

  const ColorChangedEvent({required this.color});

  @override
  List<Object> get props => [color];
}

class NoteSaveEvent extends NoteEvent {
  const NoteSaveEvent();

  @override
  List<Object> get props => [];
}
