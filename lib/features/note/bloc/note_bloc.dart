import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:diary/core/domain/enteties/note_entity.dart';
import 'package:diary/core/domain/repositories/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final AbstractNoteRepository _noteRepository;
  final NoteEntity? noteEntity;

  NoteBloc(this._noteRepository, this.noteEntity) : super(NoteState()) {
    on<NoteClearEvent>(_onNoteClear);
    on<NoteLoadEvent>(_onNoteLoadEvent);
    on<NoteChangedEvent>(_onNoteChanged);
    on<TitleChangedEvent>(_onTitleChanged);
    on<ColorChangedEvent>(_onColorChanged);
    on<NoteSaveEvent>(_onNoteSave);
  }

  Future<void> _onNoteLoadEvent(
      NoteLoadEvent event, Emitter<NoteState> emit) async {
    if (noteEntity != null) {
      emit(state.copyWith(
        isUpdate: true,
        title: noteEntity!.title,
        note: noteEntity!.description,
        color: Color(int.parse(noteEntity!.color)),
      ));
    }
    emit(state.copyWith(noteStatus: NoteStatus.loading));
    emit(state.copyWith(noteStatus: NoteStatus.loaded));
  }

  Future<void> _onNoteClear(
      NoteClearEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(noteStatus: NoteStatus.loading));
    if (noteEntity != null) {
      final clearNote = await _noteRepository.deleteNote(noteEntity!.id);
      clearNote.fold(
          (failure) => emit(state.copyWith(noteStatus: NoteStatus.failure)),
          (result) {
        emit(state.copyWith(noteStatus: NoteStatus.cleared));
        add(NoteLoadEvent());
      });
    }
  }

  void _onColorChanged(ColorChangedEvent event, Emitter<NoteState> emit) {
    debugPrint("Color: ${event.color.toString()}");

    emit(state.copyWith(color: event.color));
  }

  void _onTitleChanged(TitleChangedEvent event, Emitter<NoteState> emit) {
    debugPrint("Note's title: ${event.title}");
    emit(state.copyWith(title: event.title));
  }

  void _onNoteChanged(NoteChangedEvent event, Emitter<NoteState> emit) {
    debugPrint("Note's desc: ${event.note}");
    emit(state.copyWith(note: event.note));
  }

  Future<void> _onNoteSave(NoteSaveEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(noteStatus: NoteStatus.loading));
    final note = NoteEntity(
        id: noteEntity != null
            ? noteEntity!.id
            : await _noteRepository.lastIndex(),
        title: state.title,
        description: state.note,
        dateTime: DateTime.now(),
        color: state.color.value.toString());
    if (noteEntity != null) {
      final clearNote = await _noteRepository.updateNote(note);
      clearNote.fold(
          (failure) => emit(state.copyWith(noteStatus: NoteStatus.failure)),
          (result) {
        debugPrint("Update: ${state.note}");
        emit(state.copyWith(noteStatus: NoteStatus.saved));
      });
    } else {
      final clearNote = await _noteRepository.addNote(note);
      clearNote.fold(
          (failure) => emit(state.copyWith(noteStatus: NoteStatus.failure)),
          (result) {
        debugPrint("Save: ${state.note}");
        emit(state.copyWith(noteStatus: NoteStatus.saved));
      });
    }
  }
}
