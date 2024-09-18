import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/domain/enteties/task_entity.dart';
import 'package:diary/core/error/exception.dart';
import 'package:diary/core/error/failure.dart';
import 'package:diary/core/data/datasources/task_local_data_source.dart';
import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

class TaskRepository implements AbstractTaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepository({required this.localDataSource});

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final locationTask = await localDataSource.getTasksFromCache();
      return Right(locationTask);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> searchTask(String query) async {
    try {
      final locationTask = await localDataSource.getTasksFromCache();
      return Right(locationTask);
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      return Right(await localDataSource.oneTaskToCache(task as TaskModel));
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
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      return Right(await localDataSource.deleteTaskById(id));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskModel task) async {
    try {
      return Right(await localDataSource.updateTask(task));
    } catch (e) {
      return Left(CacheFailure(e));
    }
  }
}
