import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:repository_module/repository_module.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository _todoRepository;
  final ErrorHandlerRepository _errorHandlerRepository;

  TodosBloc(TodoRepository todoRepository,
      ErrorHandlerRepository errorHandlerRepository)
      : _todoRepository = todoRepository,
        _errorHandlerRepository = errorHandlerRepository,
        super(TodoLoadInProgress()) {
    on<TodosLoadedEvent>(_onLoadTodos);
    on<TodoUpdateEvent>(_onTodoUpdate);
    on<TodoCreateEvent>(_createTodo);
    on<ErrorClearEvent>(_clearTodoError);
  }

  void _onLoadTodos(TodosLoadedEvent event, Emitter<TodosState> emit) async {
    if (event is TodosLoadedEvent) {
      try {
        final todos = await this._todoRepository.getTodo();
        final List<Todo> todo = todos.isNotEmpty
            ? todos
                .map(
                  (todo) => Todo(
                    id: todo.id,
                    title: todo.title,
                    description: todo.description,
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

  void _onTodoUpdate(
    TodoUpdateEvent event,
    Emitter<TodosState> emit,
  ) async {
    if (state is TodoLoadSuccess) {
      try {
        final updatedTodo = await this._todoRepository.updateTodo(
              Todo(
                id: event.todo.id,
                title: event.todo.title,
                description: event.todo.description,
              ),
            );
        if (!updatedTodo!.id.isNegative) {
          final List<Todo> updateTodos = (state as TodoLoadSuccess)
              .todos
              .map((todo) => todo.id == event.todo.id ? updatedTodo : todo)
              .toList();
          emit(TodoLoadSuccess(updateTodos));
        }
      } on PatchRequestException catch (e) {
        throw PatchRequestException(message: e.message);
      }
    }
  }

  void _createTodo(
    TodoCreateEvent event,
    Emitter<TodosState> emit,
  ) async {
    if (state is TodoLoadSuccess) {
      try {
        final List<Todo> todos = (state as TodoLoadSuccess).todos.toList();
        final newTodo = await this._todoRepository.createTodo(
              Todo(
                title: event.todo.title,
                description: event.todo.description,
              ),
            );
        if (!newTodo!.id.isNegative) {
          _errorHandlerRepository.setFormStatus();
          todos.add(
            Todo(
              id: newTodo.id,
              title: newTodo.title,
              description: newTodo.description,
            ),
          );
          emit(TodoLoadSuccess(todos));
        }
      } on PostRequestException catch (e) {
        _errorHandlerRepository.setErrorMessage(e.message);
        throw PostRequestException(message: e.message);
      }
    }
  }

  void _clearTodoError(ErrorClearEvent event, Emitter<TodosState> emit) {
    _errorHandlerRepository.clearErrorMessage();
  }
}
