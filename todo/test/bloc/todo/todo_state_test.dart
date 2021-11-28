import 'package:flutter_test/flutter_test.dart';
import 'package:todo/logic/bloc/todos/todos_bloc.dart';

import '../../resource/fake_response.dart';

void main() {
  group("TodosState", () {
    test("TodoLoadInProgress", () {
      expect(TodoLoadInProgress(), TodoLoadInProgress());
    });

    test("TodosLoadFailure", () {
      expect(TodosLoadFailure(), TodosLoadFailure());
    });

    test("TodosExceptionState", () {
      expect(TodosExceptionState([]), TodosExceptionState([]));
    });

    test("TodoLoadSuccess", () {
      expect(
        TodoLoadSuccess(fakeTodoResponse),
        TodoLoadSuccess(fakeTodoResponse),
      );
    });
  });
}
