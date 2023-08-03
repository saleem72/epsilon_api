part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginClearUsernameError extends LoginEvent {}

class LoginUsernameLostFocus extends LoginEvent {}

class LoginClearPasswordError extends LoginEvent {}

class LoginPasswordLostFocus extends LoginEvent {}

class LoginPasswordHasChanged extends LoginEvent {
  final String password;

  const LoginPasswordHasChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginUsernameHasChanged extends LoginEvent {
  final String username;

  const LoginUsernameHasChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class LoginClearFailure extends LoginEvent {}

class LoginExecute extends LoginEvent {}
