import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginException implements Exception {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(LoginInitialState()) {
    on<LoginSubmitted>(_tryLogin);
    on<LoginAuthValue>(_setAuthValue);
  }

  void _setAuthValue(LoginAuthValue event, Emitter<LoginState> emit) async {
    emit(
      DoLoginState(username: event.username, password: event.password),
    );
  }

  void _tryLogin(LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      var currentState = state;
      if (currentState is DoLoginState) {
        LoginLoadingState();
        await _authRepository.doLogin(
          currentState.username,
          currentState.password,
        );
        LoginInitialState();
      }
    } catch (e) {
      throw LoginException();
    }
  }

  // @override
  // LoginState? fromJson(Map<String, dynamic> json) {
  //   // TODO: implement fromJson
  //   throw UnimplementedError();
  // }

  // @override
  // Map<String, dynamic>? toJson(LoginState state) {
  //   // TODO: implement toJson
  //   throw UnimplementedError();
  // }
}
