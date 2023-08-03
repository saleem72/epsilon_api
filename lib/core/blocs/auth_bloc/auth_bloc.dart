//

import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Safe safe;
  AuthBloc({required this.safe}) : super(AuthState.empty()) {
    on<_CheckAuthStatus>(_onCheckAuthStatus);
    on<_Authorized>(_onAuthorized);
    on<_Logout>(_onLogout);
  }
  _onAuthorized(_Authorized event, Emitter<AuthState> emit) {
    safe.setToken(event.token);
    emit(AuthState.home());
  }

  _onCheckAuthStatus(_CheckAuthStatus event, Emitter<AuthState> emit) {
    final option = safe.getAuthStatus();
    switch (option) {
      case AuthOption.home:
        emit(AuthState.home());
        break;
      case AuthOption.none:
      case AuthOption.login:
        emit(AuthState.login());
        break;
    }
  }

  _onLogout(_Logout event, Emitter<AuthState> emit) {
    safe.clearToken();
    emit(AuthState.login());
  }
}
