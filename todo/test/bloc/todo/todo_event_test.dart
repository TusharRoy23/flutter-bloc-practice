import 'package:flutter_test/flutter_test.dart';
import 'package:todo/logic/bloc/todos/todos_bloc.dart';

import '../../resource/fake_response.dart';

void main() {
  group("TodosEvent", () {
    test("TodosLoadedEvent", () {
      expect(TodosLoadedEvent(), TodosLoadedEvent());
    });

    test("ErrorClearEvent", () {
      expect(ErrorClearEvent(), ErrorClearEvent());
    });

    test("TodoCreateEvent", () {
      expect(
        TodoCreateEvent(fakeTodoResponse[0]),
        TodoCreateEvent(fakeTodoResponse[0]),
      );
    });

    test("TodoUpdateEvent", () {
      expect(
        TodoUpdateEvent(fakeTodoResponse[0]),
        TodoUpdateEvent(fakeTodoResponse[0]),
      );
    });
  });
}
