import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:todo/model/user.dart';
import 'package:todo/model/user_token.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with HydratedMixin {
  final AuthRepository _authRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  late StreamSubscription<User> _tokenSubscription;

  AuthBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(UnknownAuthState()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    _authenticationStatusSubscription = _authRepository.status.listen(
      (status) => add(
        AuthStatusChanged(status),
      ),
    );

    _tokenSubscription = _authRepository.token.listen((user) {
      add(
        AuthAccessToken(
          accessToken: user.accessToken,
          refreshToken: user.refreshToken,
        ),
      );
    });
  }

  void _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(UnAuthenticatedState());
      case AuthenticationStatus.authenticated:
        final user = await _getUser();
        return emit(
          user != null
              ? AuthenticatedState(user: user)
              : UnAuthenticatedState(),
        );
      default:
        return emit(UnknownAuthState());
    }
  }

  Future<User?> _getUser() async {
    try {
      final user = await _authRepository.getUser();
      return User(
        userId: user.userId,
        address: user.address,
        petName: user.petName,
        photo: user.photo,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _tokenSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      final user = User.fromJson(json);
      if (user.userId != 0) {
        return AuthenticatedState(user: user);
      }
      return UnAuthenticatedState();
    } catch (e) {
      log('e $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthenticatedState) {
      return state.user.toJson();
    } else {
      return null;
    }
  }
}
