import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository_module/repository_module.dart';
import 'package:todo/logic/cubit/internet_cubit.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final InternetCubit internetCubit;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  // late StreamSubscription internetStreamSub;

  AuthBloc(AuthRepository authRepository, this.internetCubit)
      : _authRepository = authRepository,
        super(UnknownAuthState()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequest);
    // monitorInternetCubit();
    _authenticationStatusSubscription = _authRepository.status.listen(
      (status) {
        add(
          AuthStatusChanged(status),
        );
      },
    );
  }

  // StreamSubscription<InternetState> monitorInternetCubit() {
  //   return internetStreamSub = internetCubit.stream.listen(
  //     (internetState) {
  //       if (internetState is InternetConnected &&
  //           internetState.connectionType == ConnectionType.Wifi) {
  //       } else if (internetState is InternetConnected &&
  //           internetState.connectionType == ConnectionType.Mobile) {
  //       }
  //     },
  //   );
  // }

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
        username: user.username,
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
    // internetStreamSub.cancel();
    return super.close();
  }

  // @override
  // AuthState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     final user = User.fromJson(json);
  //     if (user.userId != 0) {
  //       return AuthenticatedState(user: user);
  //     }
  //     return UnAuthenticatedState();
  //   } catch (e) {
  //     log('e $e');
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(AuthState state) {
  //   if (state is AuthenticatedState) {
  //     return state.user.toJson();
  //   } else {
  //     return null;
  //   }
  // }
}
