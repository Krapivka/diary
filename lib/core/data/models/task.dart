import 'package:json_annotation/json_annotation.dart';

import 'package:diary/core/domain/enteties/task_entity.dart';

part "task.g.dart";

@JsonSerializable()
class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.title,
    super.description,
    required super.dateTime,
    required super.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
