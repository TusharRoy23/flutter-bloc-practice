part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodoLoadInProgress extends TodosState {}

class TodoLoadSuccess extends TodosState {
  final List<Todo> todos;

  TodoLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class TodosLoadFailure extends TodosState {}

class TodosExceptionState extends TodosState {
  final List<dynamic> message;

  TodosExceptionState(this.message);
}
