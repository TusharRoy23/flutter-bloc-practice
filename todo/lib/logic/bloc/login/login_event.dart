part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAuthValue extends LoginEvent {
  final String username;
  final String password;

  LoginAuthValue({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
