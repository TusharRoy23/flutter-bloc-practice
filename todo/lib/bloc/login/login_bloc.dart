import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repository_module/repository_module.dart';

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
      }
    } catch (e) {
      throw LoginException();
    }
  }
}
