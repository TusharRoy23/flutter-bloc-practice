import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository todoRepository;
  TodosBloc({required this.todoRepository}) : super(TodoLoadInProgress()) {
    log('on Loaded COnt');
    on<TodosEvent>(_onLoadTodos);
  }

  void _onLoadTodos(TodosEvent event, Emitter<TodosState> emit) async {
    log('on Loaded');
    if (event is TodosLoaded) {
      try {
        final todos = await this.todoRepository.getTodo();
        print('todos: $todos');
        emit(
          TodoLoadSuccess(),
        );
      } catch (_) {
        TodosLoadFailure();
      }
    }
  }
}
