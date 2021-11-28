import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/bloc/auth/auth_bloc.dart';
import 'package:todo/logic/cubit/internet_cubit.dart';

import '../../resource/fake_response.dart';

class MockAuthRepositry extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

void main() {
  late AuthRepository authRepository;
  // User user = MockUser();

  setUpAll(() {
    authRepository = MockAuthRepositry();
    when(() => authRepository.status).thenAnswer((_) => const Stream.empty());
  });

  group("AuthBloc", () {
    test("initial state is AuthenticationStatus.unknown", () {
      final authBloc = AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      );
      expect(authBloc.state, UnknownAuthState());
      authBloc.close();
    });

    blocTest<AuthBloc, AuthState>(
      "emits [unauthenticated] when status is unauthenticated",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      setUp: () {
        // Pushing the response
        when(() => authRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.unauthenticated),
        );
      },
      expect: () => <AuthState>[
        UnAuthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [authenticated] when state is authenticated",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      setUp: () {
        when(() => authRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        when(() => authRepository.getUser())
            .thenAnswer((_) async => userFakeResp);
      },
      expect: () => <AuthState>[
        AuthenticatedState(
          user: userFakeResp,
          status: AuthenticationStatus.authenticated,
        ),
      ],
    );
  });

  group("AuthStatusChanged", () {
    blocTest<AuthBloc, AuthState>(
      "emits [authenticated] when status is authenticated",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      setUp: () {
        when(() => authRepository.status).thenAnswer(
          (_) => Stream.value(
            AuthenticationStatus.authenticated,
          ),
        );
        when(() => authRepository.getUser())
            .thenAnswer((_) async => userFakeResp);
      },
      act: (bloc) => bloc.add(
        AuthStatusChanged(AuthenticationStatus.authenticated),
      ),
      expect: () => [
        AuthenticatedState(
          user: userFakeResp,
          status: AuthenticationStatus.authenticated,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [unauthenticated] when status is unauthenticated",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      setUp: () {
        when(() => authRepository.status).thenAnswer(
          (_) => Stream.value(
            AuthenticationStatus.unauthenticated,
          ),
        );
      },
      act: (bloc) => bloc.add(
        AuthStatusChanged(AuthenticationStatus.unauthenticated),
        // AuthLogoutRequested(),
      ),
      expect: () => [
        UnAuthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [unauthenticated] when status is authenticated but getUser fails",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      setUp: () {
        when(() => authRepository.getUser()).thenThrow(UserNotFound());
      },
      act: (bloc) => bloc.add(
        AuthStatusChanged(AuthenticationStatus.authenticated),
        // AuthLogoutRequested(),
      ),
      expect: () => [
        UnAuthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [unauthenticated] when status is authenticated but getUser return null",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      setUp: () {
        when(() => authRepository.getUser()).thenAnswer(
          (_) async => Future.value(null),
        );
      },
      act: (bloc) => bloc.add(
        AuthStatusChanged(AuthenticationStatus.authenticated),
        // AuthLogoutRequested(),
      ),
      expect: () => [
        UnAuthenticatedState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      "emits [unknown] when status is unknown",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      setUp: () {
        when(() => authRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.unknown),
        );
      },
      act: (bloc) => bloc.add(
        AuthStatusChanged(AuthenticationStatus.unknown),
      ),
      expect: () => [
        UnknownAuthState(),
      ],
    );
  });

  group("AuthLogoutRequested", () {
    blocTest<AuthBloc, AuthState>(
      "call logout on authRespository "
      "when AuthLogoutRequested is added",
      build: () => AuthBloc(
        authRepository,
        InternetCubit(
          connectivity: Connectivity(),
        ),
      ),
      act: (bloc) => bloc.add(AuthLogoutRequested()),
      verify: (_) {
        verify(() => authRepository.doLogout()).called(1);
      },
    );
  });
}
