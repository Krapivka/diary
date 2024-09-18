part of 'note_bloc.dart';

enum NoteStatus { initial, loading, loaded, failure, saved, cleared }

class NoteState {
  NoteState({title, note, color, noteStatus, isUpdate})
      : noteStatus = noteStatus ?? NoteStatus.initial,
        isUpdate = isUpdate ?? false,
        title = title ?? "",
        note = note ?? "",
        color = color ?? const Color.fromARGB(220, 184, 184, 184);
  final bool isUpdate;
  final String title;
  final String note;
  final Color color;
  final NoteStatus noteStatus;
  List<Object> get props => [note];

  NoteState copyWith({
    bool? isUpdate,
    Color? color,
    String? title,
    String? note,
    NoteStatus? noteStatus,
  }) {
    return NoteState(
      isUpdate: isUpdate ?? this.isUpdate,
      color: color ?? this.color,
      title: title ?? this.title,
      note: note ?? this.note,
      noteStatus: noteStatus ?? this.noteStatus,
    );
  }
}
