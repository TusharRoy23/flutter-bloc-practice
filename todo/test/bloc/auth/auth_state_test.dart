import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/auth/auth_bloc.dart';

class MockUser extends Mock implements User {}

void main() {
  group("AuthState", () {
    test("UnAuthenticatedState", () {
      expect(
        UnAuthenticatedState(status: AuthenticationStatus.unauthenticated),
        UnAuthenticatedState(),
      );
    });

    test("AuthenticatedState", () {
      User user = MockUser();
      expect(
        AuthenticatedState(user: user),
        AuthenticatedState(user: user),
      ); // actual, match
    });

    test("AuthTokenState", () {
      expect(
        AuthTokenState('', ''),
        AuthTokenState('', ''),
      );
    });

    test("AuthTokenState Object comparison", () {
      expect(
        AuthTokenState,
        AuthTokenState,
      );
    });
  });
}
