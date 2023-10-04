// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final ValidationStatus? usernameStatus;
  final ValidationStatus? passwordStatus;
  final bool isValid;
  final Failure? failure;
  final bool loginSuccessfully;
  final String? token;
  final String username;
  final String password;
  final Company company;
  final String host;

  const LoginState({
    required this.isLoading,
    required this.usernameStatus,
    required this.passwordStatus,
    required this.isValid,
    required this.failure,
    required this.loginSuccessfully,
    required this.token,
    required this.username,
    required this.password,
    required this.company,
    required this.host,
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
        username,
        password,
        company,
        host,
      ];

  LoginState copyWith({
    bool? isLoading,
    ValidationStatus? usernameStatus,
    ValidationStatus? passwordStatus,
    bool? isValid,
    Failure? failure,
    bool? loginSuccessfully,
    String? token,
    String? username,
    String? password,
    Company? company,
    String? host,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      failure: failure ?? this.failure,
      loginSuccessfully: loginSuccessfully ?? this.loginSuccessfully,
      token: token,
      username: username ?? this.username,
      password: password ?? this.password,
      company: company ?? this.company,
      host: host ?? this.host,
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
      username: username,
      password: password,
      company: company,
      host: host,
      token: token,
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
      username: username,
      password: password,
      company: company,
      host: host,
      token: token,
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
      username: username,
      password: password,
      company: company,
      host: host,
      token: token,
    );
  }

  factory LoginState.initial(Safe safe) => LoginState(
        isLoading: false,
        usernameStatus: null,
        passwordStatus: null,
        isValid: false,
        failure: null,
        loginSuccessfully: false,
        token: null,
        username: '',
        password: '',
        company: safe.getCompany(),
        host: safe.getHost(),
      );
}
