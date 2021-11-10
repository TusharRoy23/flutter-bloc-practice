import 'dart:async';

import 'package:exception_handler/exception_handler.dart';
import 'package:meta_api/meta_api.dart';

import '../repository_module.dart';

class TodoFailure implements Exception {}

class TodoRepository {
  final MetaTodoApiClient _todoApiClient;

  TodoRepository({
    MetaTodoApiClient? todoApiClient,
  }) : _todoApiClient = todoApiClient ?? MetaTodoApiClient();

  Future<List<Todo>> getTodo() async {
    try {
      final todolist = await _todoApiClient.fetchTodoList();
      return todolist!.isNotEmpty
          ? todolist
              .map(
                (todo) => Todo(
                  id: todo['id'],
                  title: todo['title'],
                  description: todo['description'],
                  createdDate: todo['createdDate'],
                ),
              )
              .toList()
          : [];
    } on GetRequestException catch (e) {
      throw GetRequestException(message: e.message);
    }
  }

  Future<Todo?> updateTodo(Todo todo) async {
    try {
      final updatedTodo = await _todoApiClient.updateTodo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
      );
      if (!updatedTodo.id.isNegative) {
        return Todo(
          id: updatedTodo.id,
          title: updatedTodo.title,
          description: updatedTodo.description,
          createdDate: updatedTodo.createdDate,
        );
      }
      return null;
    } on PatchRequestException catch (e) {
      throw PatchRequestException(message: e.message);
    }
  }

  Future<Todo?> createTodo(Todo todo) async {
    try {
      final newTodo = await _todoApiClient.createTodo(
        title: todo.title,
        description: todo.description,
      );
      if (!newTodo.id.isNegative) {
        return Todo(
          id: newTodo.id,
          title: newTodo.title,
          description: newTodo.description,
          createdDate: newTodo.createdDate,
        );
      }
      return null;
    } on PostRequestException catch (e) {
      throw PostRequestException(message: e.message);
    }
  }
}
