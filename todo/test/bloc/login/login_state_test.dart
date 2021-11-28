import 'package:flutter_test/flutter_test.dart';
import 'package:todo/logic/bloc/login/login_bloc.dart';

void main() {
  group('LoginState', () {
    test('supports value comparison', () {
      expect(LoginInitialState(), LoginInitialState());
    });

    test('object comparison', () {
      expect(
        DoLoginState(username: 'tushar@gm.com', password: 'tushar24'),
        DoLoginState(username: 'tushar@gm.com', password: 'tushar24'),
      );
    });
  });
}
