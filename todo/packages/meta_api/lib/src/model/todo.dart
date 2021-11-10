import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  final int id;
  final String title;
  final String description;
  final String createdDate;

  Todo({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.createdDate = '',
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
