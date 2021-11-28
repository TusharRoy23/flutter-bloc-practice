import 'package:flutter_test/flutter_test.dart';
import 'package:todo/logic/bloc/login/login_bloc.dart';

void main() {
  group("LoginEvent", () {
    test("LoginAuthValue Event", () {
      expect(
        LoginAuthValue(username: 'tushar@gm.com', password: 'tushar24'),
        LoginAuthValue(username: 'tushar@gm.com', password: 'tushar24'),
      );
    });

    test("LoginSubmitted Event", () {
      expect(LoginSubmitted(), LoginSubmitted());
    });
  });
}
