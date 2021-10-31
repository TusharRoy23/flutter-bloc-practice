import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository_module/repository_module.dart';
// import 'package:todo/model/user.dart';
import 'package:todo/model/user_token.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with HydratedMixin {
  final AuthRepository _authRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  AuthBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(UnknownAuthState()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequest);
    _authenticationStatusSubscription = _authRepository.status.listen(
      (status) {
        add(
          AuthStatusChanged(status),
        );
      },
    );
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

  void _onAuthLogoutRequest(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.doLogout();
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
