import 'package:diary/core/data/models/note.dart';
import 'package:diary/core/domain/enteties/note_entity.dart';
import 'package:diary/core/error/exception.dart';
import 'package:diary/core/error/failure.dart';
import 'package:diary/core/data/datasources/note_local_data_source.dart';
import 'package:diary/core/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

class NoteRepository implements AbstractNoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepository({required this.localDataSource});

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      final locationNote = await localDataSource.getNotesFromCache();
      return Right(locationNote);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> searchNote(String query) async {
    try {
      final locationNote = await localDataSource.getNotesFromCache();
      return Right(locationNote);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> addNote(NoteEntity note) async {
    try {
      NoteModel noteModel = NoteModel(
          id: note.id,
          title: note.title,
          description: note.description,
          dateTime: note.dateTime,
          color: note.color);
      return Right(await localDataSource.oneNoteToCache(noteModel));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<int> lastIndex() async {
    try {
      return await localDataSource.lastIndex();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(int id) async {
    try {
      return Right(await localDataSource.deleteNoteById(id));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteEntity note) async {
    try {
      NoteModel noteModel = NoteModel(
          id: note.id,
          title: note.title,
          description: note.description,
          dateTime: note.dateTime,
          color: note.color);

      return Right(await localDataSource.updateNote(noteModel));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }
}
