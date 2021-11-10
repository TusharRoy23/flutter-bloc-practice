part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosLoadedEvent extends TodosEvent {}

class TodoUpdateEvent extends TodosEvent {
  final Todo todo;

  const TodoUpdateEvent(this.todo);
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoUpdate { todo: $todo }';
}

class TodoCreateEvent extends TodosEvent {
  final Todo todo;

  const TodoCreateEvent(this.todo);
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoAdded { todo: $todo }';
}

class ErrorClearEvent extends TodosEvent {}
