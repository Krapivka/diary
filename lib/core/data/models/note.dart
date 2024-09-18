import 'package:json_annotation/json_annotation.dart';

import 'package:diary/core/domain/enteties/note_entity.dart';

part "note.g.dart";

@JsonSerializable()
class NoteModel extends NoteEntity {
  const NoteModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dateTime,
    required super.color,
  });
  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
