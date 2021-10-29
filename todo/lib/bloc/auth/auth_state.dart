part of 'auth_bloc.dart';

// class AuthState extends Equatable {
//   const AuthState._({
//     this.status = AuthenticationStatus.unknown,
//     this.user = User.empty,
//   });

//   const AuthState.unknown() : this._();

//   const AuthState.authenticated(User user)
//       : this._(
//           status: AuthenticationStatus.authenticated,
//           user: user,
//         );

//   const AuthState.unauthenticated()
//       : this._(status: AuthenticationStatus.unauthenticated);

//   final AuthenticationStatus status;
//   final User user;

//   @override
//   List<Object> get props => [status, user];
// }

abstract class AuthState extends Equatable {}

class UnAuthenticatedState extends AuthState {
  final AuthenticationStatus status;

  UnAuthenticatedState({
    this.status = AuthenticationStatus.unauthenticated,
  });

  @override
  List<Object?> get props => [status];
}

class UnknownAuthState extends AuthState {
  final AuthenticationStatus status;
  final User user;

  UnknownAuthState({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  @override
  List<Object?> get props => [status, user];
}

class AuthenticatedState extends AuthState {
  final AuthenticationStatus status;
  final User user;

  AuthenticatedState({
    this.status = AuthenticationStatus.authenticated,
    required this.user,
  });

  @override
  List<Object?> get props => [status, user];
}

class AuthTokenState extends Equatable {
  final String accessToken;
  final String refreshToken;

  AuthTokenState(this.accessToken, this.refreshToken);

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
