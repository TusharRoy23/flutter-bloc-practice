import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/todos/todos_bloc.dart';

import '../../resource/fake_response.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

class MockErrorHandlerRepository extends Mock
    implements ErrorHandlerRepository {}

void main() {
  late MockTodoRepository _todoRepository;
  late MockErrorHandlerRepository _errorHandlerRepository;
  late TodosBloc todosBloc;

  setUpAll(() {
    _todoRepository = MockTodoRepository();
    _errorHandlerRepository = MockErrorHandlerRepository();
    todosBloc = TodosBloc(_todoRepository, _errorHandlerRepository);
  });
  group("TodoBloc", () {
    test("initial state is TodoLoadInProgress", () {
      expect(todosBloc.state, TodoLoadInProgress());
    });

    blocTest<TodosBloc, TodosState>(
      "emits [TodoLoadSuccess] on load",
      build: () => todosBloc,
      setUp: () {
        when(() => _todoRepository.getTodo())
            .thenAnswer((_) async => fakeTodoResponse);
      },
      act: (bloc) => bloc.add(TodosLoadedEvent()),
      expect: () => [
        TodoLoadSuccess(fakeTodoResponse),
        // isA<TodoLoadSuccess>()
        //     .having((todo) => todo, "ID", TodoLoadSuccess(fakeTodoResponse)),
      ],
    );

    // blocTest<TodosBloc, TodosState>(
    //   "emits [TodoLoadSuccess] on create",
    //   build: () => todosBloc,
    //   setUp: () {
    //     when(() => _todoRepository.createTodo(fakeNewTodo))
    //         .thenAnswer((_) async => fakeTodoResponse[0]);
    //     when(() => _errorHandlerRepository.formStatus)
    //         .thenAnswer((_) => Stream.value(true));
    //     when(() => () {
    //           fakeTodoResponse.insert(0, fakeTodoResponse[0]);
    //         }).thenAnswer((_) => fakeTodoResponse);
    //   },
    //   act: (bloc) => bloc.add(TodoCreateEvent(fakeTodoResponse[0])),
    //   expect: () => [
    //     TodoLoadSuccess(fakeTodoResponse),
    //   ],
    // );
  });
}
