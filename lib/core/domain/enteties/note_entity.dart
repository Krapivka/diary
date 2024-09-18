import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  const NoteEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.color,
  });
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String color;

  @override
  List<Object?> get props => [id, title, description, dateTime, color];
}
