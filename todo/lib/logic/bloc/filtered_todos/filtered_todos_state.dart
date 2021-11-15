part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredTodosLoadSuccess(
    this.filteredTodos,
    this.activeFilter,
  );

  Map<String, dynamic> toMap() {
    return {
      // 'filteredTodos': filteredTodos,
      'activeFilter': activeFilter.index,
    };
  }

  factory FilteredTodosLoadSuccess.fromMap(Map<String, dynamic> map) {
    return FilteredTodosLoadSuccess(
      // map['filteredTodos'],
      [],
      map['activeFilter'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory FilteredTodosLoadSuccess.fromJson(String source) =>
  //     FilteredTodosLoadSuccess.fromMap(json.decode(source));

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}
