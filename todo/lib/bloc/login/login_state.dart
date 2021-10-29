part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class DoLoginState extends LoginState {
  final String username;
  final String password;

  DoLoginState({this.username = '', this.password = ''});

  @override
  List<Object> get props => [username, password];
}
