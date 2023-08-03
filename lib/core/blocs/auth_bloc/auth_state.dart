part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];

  factory AuthState.empty() => _Empty();
  factory AuthState.home() => AuthHome();
  factory AuthState.login() => AuthLogin();
}

class _Empty extends AuthState {}

class AuthHome extends AuthState {}

class AuthLogin extends AuthState {}
