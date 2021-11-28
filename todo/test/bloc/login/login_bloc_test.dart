import 'package:bloc_test/bloc_test.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/login/login_bloc.dart';

class MockAuthRepositry extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;

  setUpAll(() {
    authRepository = MockAuthRepositry();
  });

  group('LoginBloc', () {
    test('initial state is LoginInitialState', () {
      final loginBloc = LoginBloc(authRepository);
      expect(loginBloc.state, LoginInitialState());
    });

    group(
      'LoginSubmitted',
      () {
        blocTest<LoginBloc, LoginState>(
          'emits [DoLoginState, LoginLoadingState]',
          setUp: () {
            when(
              () => authRepository.doLogin(
                '',
                '',
              ),
            ).thenAnswer((_) => Future.value());
          },
          build: () => LoginBloc(authRepository),
          act: (bloc) {
            bloc
              ..add(LoginAuthValue(username: '', password: ''))
              ..add(LoginSubmitted());
          },
          expect: () => <LoginState>[
            DoLoginState(username: '', password: ''),
            LoginLoadingState(),
          ],
        );

        blocTest<LoginBloc, LoginState>(
          'emits [DoLoginState, LoginLoadingState, LoginExceptionState] when Login fail',
          build: () => LoginBloc(authRepository),
          setUp: () {
            when(
              () => authRepository.doLogin('', ''),
            ).thenThrow(
              // LoginExceptionState(['Login Failed']),
              PostRequestException(message: ['']),
            );
          },
          act: (bloc) {
            bloc
              ..add(LoginAuthValue(username: '', password: ''))
              ..add(LoginSubmitted());
          },
          expect: () => <LoginState>[
            DoLoginState(username: '', password: ''),
            LoginLoadingState(),
            LoginExceptionState(['']),
          ],
        );
      },
    );
  });
}
