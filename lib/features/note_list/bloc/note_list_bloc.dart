import 'dart:async';
import 'package:diary/core/data/models/note.dart';
import 'package:diary/core/domain/enteties/note_entity.dart';
import 'package:diary/core/domain/repositories/note_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  NotesListBloc(
    this._noteRepository,
  ) : super(
          const NotesListState(
            noteListStatus: NotesListStatus.initial,
            listNoteModel: [],
            selectedNoteId: [],
            sortedListNoteModel: [],
          ),
        ) {
    on<LoadNotesListEvent>(_onLoadNotesList);
    on<SearchNotesListEvent>(_onSearchNote);
    on<LongPressNoteCardEvent>(_onLongPressNoteCardEvent);
    on<TapNoteCardEvent>(_onTapNoteCardEvent);
    on<DeleteNoteNotesListEvent>(_onDeleteNote);
    on<ChangeNoteCompleteListEvent>(_onChangeNoteComplete);
  }
  final AbstractNoteRepository _noteRepository;

  _onLoadNotesList(
      LoadNotesListEvent event, Emitter<NotesListState> emit) async {
    emit(state.copyWith(noteListStatus: NotesListStatus.loading));
    final listNoteModel = await _noteRepository.getAllNotes();
    listNoteModel.fold(
      (failure) =>
          emit(state.copyWith(noteListStatus: NotesListStatus.failure)),
      (result) => emit(state.copyWith(
          noteListStatus: NotesListStatus.loaded,
          listNoteModel: sortByDate(result as List<NoteModel>))),
    );
  }

  _onSearchNote(
      SearchNotesListEvent event, Emitter<NotesListState> emit) async {
    emit(state.copyWith(noteListStatus: NotesListStatus.loading));
    final listNoteModel = await _noteRepository.getAllNotes();
    listNoteModel.fold(
        (failure) =>
            emit(state.copyWith(noteListStatus: NotesListStatus.failure)),
        (result) {
      if (result.isEmpty || event.query == '') {
        emit(state.copyWith(
            noteListStatus: NotesListStatus.loaded,
            listNoteModel: sortByDate(result as List<NoteModel>)));
      } else {
        final query = event.query;

        debugPrint("Search: ${event.query}");
        final sortedList = result
            .where((note) =>
                (note.title.toLowerCase().contains(query.toLowerCase())) ||
                note.description.toLowerCase().contains(query.toLowerCase()))
            .toList();

        emit(
          state.copyWith(
              noteListStatus: NotesListStatus.searchLoaded,
              sortedListNoteModel: sortByDate(sortedList as List<NoteModel>)),
        );
      }
    });
  }

  _onLongPressNoteCardEvent(
      LongPressNoteCardEvent event, Emitter<NotesListState> emit) {
    List<int> selectedNoteId = state.selectedNoteId;
    if (state.selectedNoteId.contains(event.id)) {
      selectedNoteId.remove(event.id);
    } else {
      selectedNoteId = [...state.selectedNoteId, event.id];
    }
    emit(state.copyWith(selectedNoteId: selectedNoteId));
    debugPrint("${state.selectedNoteId}");
  }

  _onTapNoteCardEvent(TapNoteCardEvent event, Emitter<NotesListState> emit) {
    List<int> selectedNoteId = state.selectedNoteId;

    if (state.selectedNoteId.isNotEmpty &&
        state.selectedNoteId.contains(event.id)) {
      selectedNoteId.remove(event.id);
    } else if (state.selectedNoteId.isNotEmpty) {
      selectedNoteId = [...state.selectedNoteId, event.id];
    }
    emit(state.copyWith(selectedNoteId: selectedNoteId));
    debugPrint("${state.selectedNoteId}");
  }

  _onDeleteNote(
      DeleteNoteNotesListEvent event, Emitter<NotesListState> emit) async {
    for (int id in state.selectedNoteId) {
      final delNote = await _noteRepository.deleteNote(id);
      delNote.fold(
          (failure) =>
              emit(state.copyWith(noteListStatus: NotesListStatus.failure)),
          (result) async {
        emit(state.copyWith(
            selectedNoteId: [],
            noteListStatus: NotesListStatus.selectedNotesDeleted));
        debugPrint("Delete Note with ID: $id");
      });
    }

    add(const LoadNotesListEvent());
  }

  _onChangeNoteComplete(
      ChangeNoteCompleteListEvent event, Emitter<NotesListState> emit) async {
    NoteEntity note = NoteEntity(
      id: event.note.id,
      description: event.note.description,
      title: event.note.title,
      dateTime: event.note.dateTime,
      color: "",
    );
    final updateNote = await _noteRepository.updateNote(note);
    updateNote.fold(
        (failure) =>
            emit(state.copyWith(noteListStatus: NotesListStatus.failure)),
        (result) async {
      add(const LoadNotesListEvent());
    });
  }
}

List<NoteModel> sortByDate(List<NoteModel> notes) {
  notes.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  return notes;
}
