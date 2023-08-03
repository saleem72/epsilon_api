// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final ValidationStatus? usernameStatus;
  final ValidationStatus? passwordStatus;
  final bool isValid;
  final HttpFailure? failure;
  final bool loginSuccessfully;
  final String? token;

  const LoginState({
    this.isLoading = false,
    this.usernameStatus,
    this.passwordStatus,
    this.isValid = false,
    this.failure,
    this.loginSuccessfully = false,
    this.token,
  });

  @override
  List<Object?> get props => [
        isLoading,
        usernameStatus,
        passwordStatus,
        isValid,
        failure,
        loginSuccessfully,
        token,
      ];

  LoginState copyWith({
    bool? isLoading,
    ValidationStatus? usernameStatus,
    ValidationStatus? passwordStatus,
    bool? isValid,
    HttpFailure? failure,
    bool? loginSuccessfully,
    String? token,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      failure: failure ?? this.failure,
      loginSuccessfully: loginSuccessfully ?? this.loginSuccessfully,
      token: token,
    );
  }

  LoginState clearFailure() {
    return LoginState(
      isLoading: isLoading,
      isValid: isValid,
      usernameStatus: usernameStatus,
      passwordStatus: passwordStatus,
      failure: null,
      loginSuccessfully: loginSuccessfully,
    );
  }

  LoginState clearUsernameError() {
    return LoginState(
      isLoading: isLoading,
      isValid: isValid,
      usernameStatus: null,
      passwordStatus: passwordStatus,
      failure: failure,
      loginSuccessfully: loginSuccessfully,
    );
  }

  LoginState clearPasswordError() {
    return LoginState(
      isLoading: isLoading,
      isValid: isValid,
      usernameStatus: usernameStatus,
      passwordStatus: null,
      failure: failure,
      loginSuccessfully: loginSuccessfully,
    );
  }
}
