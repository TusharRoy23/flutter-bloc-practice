import 'package:flutter_test/flutter_test.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/auth/auth_bloc.dart';

void main() {
  group("AuthEvent", () {
    test("AuthStatusChanged supports value comparison", () {
      expect(
        AuthStatusChanged(AuthenticationStatus.unauthenticated),
        AuthStatusChanged(AuthenticationStatus.unauthenticated),
      );
    });

    test("AuthLogoutRequested supports value comparison", () {
      expect(
        AuthLogoutRequested(),
        AuthLogoutRequested(),
      );
    });
  });
}
