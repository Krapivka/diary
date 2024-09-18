part of 'note_list_bloc.dart';

enum NotesListStatus {
  initial,
  loading,
  loaded,
  searchLoaded,
  failure,
  selectedNotesDeleted,
  changedCheck,
}

class NotesListState {
  const NotesListState({
    required this.noteListStatus,
    required this.listNoteModel,
    required this.selectedNoteId,
    required this.sortedListNoteModel,
  });

  final NotesListStatus noteListStatus;
  final List<NoteModel> listNoteModel;
  final List<int> selectedNoteId;
  final List<NoteModel> sortedListNoteModel;

  List<Object> get props =>
      [listNoteModel, selectedNoteId, sortedListNoteModel];

  NotesListState copyWith({
    NotesListStatus? noteListStatus,
    List<NoteModel>? listNoteModel,
    List<int>? selectedNoteId,
    List<NoteModel>? sortedListNoteModel,
  }) {
    return NotesListState(
      noteListStatus: noteListStatus ?? this.noteListStatus,
      listNoteModel: listNoteModel ?? this.listNoteModel,
      selectedNoteId: selectedNoteId ?? this.selectedNoteId,
      sortedListNoteModel: sortedListNoteModel ?? this.sortedListNoteModel,
    );
  }
}
