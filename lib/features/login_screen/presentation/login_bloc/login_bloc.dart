import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:epsilon_api/features/login_screen/domain/models/company.dart';
import 'package:epsilon_api/features/login_screen/domain/models/validation_status.dart';
import 'package:epsilon_api/features/login_screen/domain/usecases/validate_password.dart';
import 'package:epsilon_api/features/login_screen/domain/usecases/validate_username.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  final ValidateUsername usernameValidator;
  final ValidatePassword passwordValidator;
  final Safe safe;

  LoginBloc({
    required this.repository,
    required this.usernameValidator,
    required this.passwordValidator,
    required this.safe,
  }) : super(LoginState.initial(safe)) {
    on<LoginClearUsernameError>(_onClearUsernameError);
    on<LoginClearPasswordError>(_onClearPasswordError);
    on<LoginPasswordHasChanged>(_onPasswordHasChanged);
    on<LoginUsernameHasChanged>(_onUsernameHasChanged);
    on<LoginClearFailure>(_onClearFailure);
    on<LoginUsernameLostFocus>(_onUsernameLostFocus);
    on<LoginPasswordLostFocus>(_onPasswordLostFocus);
    on<LoginExecute>(_onExecute);
    on<LoginHostHasChanged>(_onLoginHostHasChanged);
    on<LoginCompanyHasChanged>(_onLoginCompanyHasChanged);
  }

  _onLoginHostHasChanged(
      LoginHostHasChanged event, Emitter<LoginState> emit) async {
    // host = event.host;
    safe.setHost(event.host);
    emit(state.copyWith(
      host: event.host,
      isValid: _isFromValid(username: state.username, host: event.host),
    ));
  }

  _onLoginCompanyHasChanged(
      LoginCompanyHasChanged event, Emitter<LoginState> emit) {
    // company = event.company;
    safe.setCompany(event.company);
    emit(state.copyWith(
        company: event.company,
        isValid: _isFromValid(username: state.username, host: state.host)));
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
    // password = event.password;
    emit(state.copyWith(
        password: event.password,
        isValid: _isFromValid(username: state.username, host: state.host)));
  }

  _onUsernameHasChanged(
      LoginUsernameHasChanged event, Emitter<LoginState> emit) {
    // username = event.username;

    emit(state.copyWith(
        username: event.username,
        isValid: _isFromValid(username: event.username, host: state.host)));
  }

  _onClearFailure(LoginClearFailure event, Emitter<LoginState> emit) {
    emit(state.clearFailure());
  }

  _onExecute(LoginExecute event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final either = await repository.login(
        username: state.username, password: state.password);
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
    // final usernameStatus = usernameValidator(username);
    // if (usernameStatus != ValidationStatus.valid) {
    //   emit(state.copyWith(usernameStatus: usernameStatus, isValid: false));
    //   return;
    // }

    // final passwordStatus = passwordValidator(password);
    // if (passwordStatus == ValidationStatus.valid) {
    //   emit(state.copyWith(isValid: true));
    // } else {
    //   emit(state.copyWith(isValid: false));
    // }
  }

  _onPasswordLostFocus(LoginPasswordLostFocus event, Emitter<LoginState> emit) {
    // final passwordStatus = passwordValidator(password);
    // if (passwordStatus != ValidationStatus.valid) {
    //   emit(state.copyWith(passwordStatus: passwordStatus, isValid: false));
    //   return;
    // }

    // final usernameStatus = usernameValidator(username);

    // if (usernameStatus == ValidationStatus.valid) {
    //   emit(state.copyWith(isValid: true));
    // } else {
    //   emit(state.copyWith(isValid: false));
    // }
  }

  _isFromValid({required String username, required String host}) {
    const passwordStatus =
        true; // password.isNotEmpty; // passwordValidator(password);
    final usernameStatus = username.isNotEmpty;
    // usernameValidator(username);
    // return passwordStatus == ValidationStatus.valid &&
    //     usernameStatus == ValidationStatus.valid;

    return passwordStatus && usernameStatus && host.isNotEmpty;
  }
}
