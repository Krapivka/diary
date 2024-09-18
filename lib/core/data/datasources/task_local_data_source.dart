import 'dart:convert';
import 'package:diary/core/data/models/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasksFromCache();
  Future<void> tasksToCache(List<TaskModel> tasks);
  Future<void> oneTaskToCache(TaskModel task);
  Future<void> deleteTaskById(int id);
  Future<void> updateTask(TaskModel task);
  Future<int> lastIndex();
}

// ignore: constant_identifier_names
const CACHED_TASKS_LIST = 'CACHED_TASK_LIST';
// ignore: constant_identifier_names
const LAST_INDEX = 'LAST_INDEX';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TaskModel>> getTasksFromCache() {
    final jsonTaskList =
        sharedPreferences.getStringList(CACHED_TASKS_LIST) ?? [];
    return Future.value(jsonTaskList
        .map((task) => TaskModel.fromJson(json.decode(task)))
        .toList());
  }

  @override
  Future<void> tasksToCache(List<TaskModel> tasks) async {
    final List<String> jsonTaskList =
        tasks.map((task) => json.encode(task.toJson())).toList();
    await sharedPreferences.setStringList(CACHED_TASKS_LIST, jsonTaskList);
    final int countUsers = sharedPreferences.getInt(LAST_INDEX) ?? 0;
    await sharedPreferences.setInt(LAST_INDEX, countUsers + 1);
    debugPrint('Tasks to write Cache: ${jsonTaskList.length}');
  }

  @override
  Future<void> oneTaskToCache(TaskModel task) async {
    final listTaskModel = await getTasksFromCache();
    listTaskModel.add(task);
    await tasksToCache(listTaskModel);
    debugPrint('Task to write Cache: $listTaskModel');
  }

  @override
  Future<int> lastIndex() async {
    final ind = sharedPreferences.getInt(LAST_INDEX) ?? 0;
    return ind;
  }

  @override
  Future<void> deleteTaskById(int id) async {
    final listTaskModel = await getTasksFromCache();
    final index = listTaskModel.indexWhere((element) => element.id == id);
    listTaskModel.removeAt(index);
    await tasksToCache(listTaskModel);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final listTaskModel = await getTasksFromCache();
    final index = listTaskModel.indexWhere((element) => element.id == task.id);
    listTaskModel.removeAt(index);
    await tasksToCache(listTaskModel);
    await oneTaskToCache(task);
  }
}
