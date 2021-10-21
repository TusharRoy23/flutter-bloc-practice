import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository todoRepository;
  TodosBloc({required this.todoRepository}) : super(TodoLoadInProgress()) {
    on<TodosLoaded>(_onLoadTodos);
  }

  void _onLoadTodos(TodosLoaded event, Emitter<TodosState> emit) async {
    if (event is TodosLoaded) {
      try {
        final todos = await this.todoRepository.getTodo();
        final List<Todo> todo = todos.isNotEmpty
            ? todos
                .map(
                  (todo) => Todo(
                    id: todo.id,
                    title: todo.title,
                    completed: todo.completed,
                  ),
                )
                .toList()
            : [];
        emit(TodoLoadSuccess(todo));
      } catch (_) {
        TodosLoadFailure();
      }
    }
  }
}
