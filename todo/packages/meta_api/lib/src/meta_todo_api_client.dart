import 'dart:convert';

import 'package:exception_handler/exception_handler.dart';
import 'package:meta_api/src/base_api_client.dart';

import 'model/todo.dart';

class TodoRequestFailure implements Exception {}

class MetaTodoApiClient {
  final BaseApiClient _baseApiClient;

  MetaTodoApiClient({BaseApiClient? baseApiClient})
      : _baseApiClient = baseApiClient ?? BaseApiClient();

  Future<List?> fetchTodoList() async {
    try {
      var response = await _baseApiClient.get('todo/');
      final todoJson = response as List;
      return todoJson.toList();
    } catch (e) {
      throw TodoRequestFailure();
    }
  }

  Future<Todo> updateTodo({
    int id = 0,
    String title = "",
    String description = "",
  }) async {
    try {
      var response = await _baseApiClient.patch(
        'todo/$id/',
        jsonEncode(
          {
            'title': title,
            'description': description,
          },
        ),
      );

      Map<String, dynamic> todoMap = response!;
      Todo updatedTodo = Todo(
        id: todoMap['id'],
        title: todoMap['title'],
        description: todoMap['description'],
        createdDate: todoMap['createdDate'],
      );

      return Todo.fromJson(updatedTodo.toJson());
    } on PatchRequestException catch (e) {
      throw PatchRequestException(message: e.message);
    } on Exception catch (_) {
      throw Exception();
    }
  }

  Future<Todo> createTodo({
    String title = "",
    String description = "",
  }) async {
    try {
      var response = await _baseApiClient.post(
        'todo/',
        jsonEncode(
          {
            'title': title,
            'description': description,
          },
        ),
        true,
      );

      Map<String, dynamic> todoMap = response!;
      Todo newTodo = Todo(
        id: todoMap['id'],
        title: todoMap['title'],
        description: todoMap['description'],
        createdDate: todoMap['createdDate'],
      );

      return Todo.fromJson(newTodo.toJson());
    } on PostRequestException catch (e) {
      throw PostRequestException(message: e.message);
    } on Exception catch (_) {
      throw Exception();
    }
  }
}
