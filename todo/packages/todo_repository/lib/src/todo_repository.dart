import 'package:meta_api/meta_api.dart';
import 'package:todo_repository/src/models/models.dart';

class TodoFailure implements Exception {}

class TodoRepository {
  final MetaTodoApiClient _todoApiClient;

  TodoRepository({MetaTodoApiClient? todoApiClient})
      : _todoApiClient = todoApiClient ?? MetaTodoApiClient();

  Future<List<Todo>> getTodo() async {
    try {
      final todolist = await _todoApiClient.fetchTodoList();
      return todolist.isNotEmpty
          ? todolist
              .map(
                (todo) => Todo(
                  id: todo['id'],
                  title: todo['title'],
                  completed: todo['completed'],
                ),
              )
              .toList()
          : [];
    } catch (e) {
      throw TodoFailure();
    }
  }
}
