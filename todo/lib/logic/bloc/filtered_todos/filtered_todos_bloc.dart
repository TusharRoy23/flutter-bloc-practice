import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/constants/enums.dart';
import 'package:todo/logic/bloc/todos/todos_bloc.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc? todosBloc;
  late StreamSubscription todosSubscription;

  FilteredTodosBloc({this.todosBloc})
      : super(
          todosBloc?.state is TodoLoadSuccess
              ? FilteredTodosLoadSuccess(
                  (todosBloc?.state as TodoLoadSuccess).todos,
                  VisibilityFilter.desc,
                )
              : FilteredTodosLoadInProgress(),
        ) {
    on<TodosUpdated>(_filteredTodos);
    on<FilterUpdated>(_doFilterTodos);

    todosSubscription = todosBloc!.stream.listen(
      (state) {
        if (state is TodoLoadSuccess) {
          add(TodosUpdated((todosBloc?.state as TodoLoadSuccess).todos));
        }
      },
    );
  }

  void _filteredTodos(TodosUpdated event, Emitter<FilteredTodosState> emit) {
    final visibilityFilter = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).activeFilter
        : VisibilityFilter.desc;
    emit(
      FilteredTodosLoadSuccess(
        _sortTodo(
          (todosBloc?.state as TodoLoadSuccess).todos,
          visibilityFilter,
        ),
        visibilityFilter,
      ),
    );
  }

  void _doFilterTodos(FilterUpdated event, Emitter<FilteredTodosState> emit) {
    if (todosBloc?.state is TodoLoadSuccess) {
      emit(
        FilteredTodosLoadSuccess(
          _sortTodo(
            (todosBloc?.state as TodoLoadSuccess).todos,
            event.filter,
          ),
          event.filter,
        ),
      );
    }
  }

  List<Todo> _sortTodo(List<Todo> todos, VisibilityFilter filter) {
    todos.sort((firstObj, secondObj) => filter == VisibilityFilter.asc
        ? firstObj.id.compareTo(secondObj.id)
        : secondObj.id.compareTo(firstObj.id));
    return todos;
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }

  // @override
  // FilteredTodosState? fromJson(Map<String, dynamic> json) {
  //   if (state is FilteredTodosLoadSuccess) {
  //     return FilteredTodosLoadSuccess.fromMap(json);
  //   }
  //   return null;
  // }

  // @override
  // Map<String, dynamic>? toJson(FilteredTodosState state) {
  //   if (state is FilteredTodosLoadSuccess) {
  //     return state.toMap();
  //   }
  //   return null;
  // }
}
