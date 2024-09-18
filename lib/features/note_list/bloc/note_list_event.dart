part of 'note_list_bloc.dart';

sealed class NotesListEvent extends Equatable {
  const NotesListEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotesListEvent extends NotesListEvent {
  const LoadNotesListEvent({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class DeleteNoteNotesListEvent extends NotesListEvent {
  const DeleteNoteNotesListEvent();
  @override
  List<Object?> get props => [];
}

class ChangeNoteCompleteListEvent extends NotesListEvent {
  const ChangeNoteCompleteListEvent({required this.note});
  final NoteModel note;
  @override
  List<Object?> get props => [];
}

class SearchNotesListEvent extends NotesListEvent {
  const SearchNotesListEvent({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}

class LongPressNoteCardEvent extends NotesListEvent {
  const LongPressNoteCardEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}

class TapNoteCardEvent extends NotesListEvent {
  const TapNoteCardEvent({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}
