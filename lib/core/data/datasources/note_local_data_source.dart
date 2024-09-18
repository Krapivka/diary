import 'dart:convert';
import 'package:diary/core/data/models/note.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getNotesFromCache();
  Future<void> notesToCache(List<NoteModel> notes);
  Future<void> oneNoteToCache(NoteModel note);
  Future<void> deleteNoteById(int id);
  Future<void> updateNote(NoteModel note);
  Future<int> lastIndex();
}

// ignore: constant_identifier_names
const CACHED_NOTES_LIST = 'CACHED_NOTE_LIST';
// ignore: constant_identifier_names
const LAST_INDEX = 'LAST_NOTE_INDEX';

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  NoteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<NoteModel>> getNotesFromCache() {
    final jsonNoteList =
        sharedPreferences.getStringList(CACHED_NOTES_LIST) ?? [];
    return Future.value(jsonNoteList
        .map((note) => NoteModel.fromJson(json.decode(note)))
        .toList());
  }

  @override
  Future<void> notesToCache(List<NoteModel> notes) async {
    final List<String> jsonNoteList =
        notes.map((note) => json.encode(note.toJson())).toList();
    await sharedPreferences.setStringList(CACHED_NOTES_LIST, jsonNoteList);
    final int countUsers = sharedPreferences.getInt(LAST_INDEX) ?? 0;
    await sharedPreferences.setInt(LAST_INDEX, countUsers + 1);
    debugPrint('Notes to write Cache: ${jsonNoteList.length}');
  }

  @override
  Future<void> oneNoteToCache(NoteModel note) async {
    final listNoteModel = await getNotesFromCache();
    listNoteModel.add(note);
    await notesToCache(listNoteModel);
    debugPrint('Note to write Cache: $listNoteModel');
  }

  @override
  Future<int> lastIndex() async {
    final ind = sharedPreferences.getInt(LAST_INDEX) ?? 0;
    return ind;
  }

  @override
  Future<void> deleteNoteById(int id) async {
    final listNoteModel = await getNotesFromCache();
    final index = listNoteModel.indexWhere((element) => element.id == id);
    listNoteModel.removeAt(index);
    await notesToCache(listNoteModel);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final listNoteModel = await getNotesFromCache();
    final index = listNoteModel.indexWhere((element) => element.id == note.id);
    listNoteModel.removeAt(index);
    await notesToCache(listNoteModel);
    await oneNoteToCache(note);
  }
}
