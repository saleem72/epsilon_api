import 'package:epsilon_api/features/login_screen/domain/models/validation_status.dart';
import 'package:epsilon_api/features/login_screen/domain/usecases/validate_password.dart';
import 'package:epsilon_api/features/login_screen/domain/usecases/validate_username.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/failures/login_failure.dart';
import '../../domain/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  final ValidateUsername usernameValidator;
  final ValidatePassword passwordValidator;

  String username = '';
  String password = '';

  LoginBloc({
    required this.repository,
    required this.usernameValidator,
    required this.passwordValidator,
  }) : super(const LoginState()) {
    on<LoginClearUsernameError>(_onClearUsernameError);
    on<LoginClearPasswordError>(_onClearPasswordError);
    on<LoginPasswordHasChanged>(_onPasswordHasChanged);
    on<LoginUsernameHasChanged>(_onUsernameHasChanged);
    on<LoginClearFailure>(_onClearFailure);
    on<LoginUsernameLostFocus>(_onUsernameLostFocus);
    on<LoginPasswordLostFocus>(_onPasswordLostFocus);
    on<LoginExecute>(_onExecute);
  }
  _onClearUsernameError(
      LoginClearUsernameError event, Emitter<LoginState> emit) {
    emit(state.clearUsernameError());
  }

  _onClearPasswordError(
      LoginClearPasswordError event, Emitter<LoginState> emit) {
    emit(state.clearPasswordError());
  }

  _onPasswordHasChanged(
      LoginPasswordHasChanged event, Emitter<LoginState> emit) {
    password = event.password;
    emit(state.copyWith(isValid: _isFromValid()));
  }

  _onUsernameHasChanged(
      LoginUsernameHasChanged event, Emitter<LoginState> emit) {
    username = event.username;

    emit(state.copyWith(isValid: _isFromValid()));
  }

  _onClearFailure(LoginClearFailure event, Emitter<LoginState> emit) {
    emit(state.clearFailure());
  }

  _onExecute(LoginExecute event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final either =
        await repository.login(username: username, password: password);
    either.fold(
      (failure) {
        emit(state.copyWith(failure: failure, isLoading: false));
      },
      (token) {
        emit(state.copyWith(
            isLoading: false, loginSuccessfully: true, token: token));
      },
    );
  }

  _onUsernameLostFocus(LoginUsernameLostFocus event, Emitter<LoginState> emit) {
    final usernameStatus = usernameValidator(username);
    if (usernameStatus != ValidationStatus.valid) {
      emit(state.copyWith(usernameStatus: usernameStatus, isValid: false));
      return;
    }

    final passwordStatus = passwordValidator(password);
    if (passwordStatus == ValidationStatus.valid) {
      emit(state.copyWith(isValid: true));
    } else {
      emit(state.copyWith(isValid: false));
    }
  }

  _onPasswordLostFocus(LoginPasswordLostFocus event, Emitter<LoginState> emit) {
    final passwordStatus = passwordValidator(password);
    if (passwordStatus != ValidationStatus.valid) {
      emit(state.copyWith(passwordStatus: passwordStatus, isValid: false));
      return;
    }

    final usernameStatus = usernameValidator(username);

    if (usernameStatus == ValidationStatus.valid) {
      emit(state.copyWith(isValid: true));
    } else {
      emit(state.copyWith(isValid: false));
    }
  }

  _isFromValid() {
    final passwordStatus = passwordValidator(password);
    final usernameStatus = usernameValidator(username);
    return passwordStatus == ValidationStatus.valid &&
        usernameStatus == ValidationStatus.valid;
  }
}
