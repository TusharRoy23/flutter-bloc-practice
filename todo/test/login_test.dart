import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/login/login_bloc.dart';

import 'mock_login_repository.dart';

void main() {
  group('Login Test', () {
    // MockLoginRepository mockLoginRepository = MockLoginRepository();
    AuthRepository authRepository = AuthRepository();
    LoginBloc loginBloc = LoginBloc(authRepository);

    // setUp(() {
    //   EquatableConfig.stringify = true;
    //   mockLoginRepository = MockLoginRepository();
    //   loginBloc = LoginBloc(mockLoginRepository);
    // });

    blocTest<LoginBloc, LoginState>(
      'emits [MyState] when MyEvent is added.',
      build: () => loginBloc,
      act: (bloc) => [
        bloc.add(
          LoginAuthValue(username: 'tushar@gm.com', password: 'Tushar24&'),
        ),
        bloc.add(
          LoginSubmitted(),
        ),
      ],
      expect: () => [LoginLoadingState()],
    );

    tearDown(() {
      loginBloc.close();
    });
  });
}
