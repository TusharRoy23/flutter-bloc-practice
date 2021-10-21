import 'package:meta_todo_api/meta_todo_api.dart' hide Todo;

class TodoFailure implements Exception {}

class TodoRepository {
  final MetaTodoApiClient _todoApiClient;

  TodoRepository({MetaTodoApiClient? todoApiClient})
      : _todoApiClient = todoApiClient ?? MetaTodoApiClient();

  Future<List> getTodo() async {
    try {
      final todolist = await _todoApiClient.fetchTodoList();
      return todolist.isNotEmpty ? todolist.toList() : [];
    } catch (e) {
      throw TodoFailure();
    }
  }
}
