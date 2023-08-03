// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

  factory AuthEvent.checkAuthStatus() => _CheckAuthStatus();
  factory AuthEvent.authorized({required String token}) =>
      _Authorized(token: token);
  factory AuthEvent.logout() => _Logout();
}

class _CheckAuthStatus extends AuthEvent {}

class _Authorized extends AuthEvent {
  final String token;
  const _Authorized({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}

class _Logout extends AuthEvent {}
