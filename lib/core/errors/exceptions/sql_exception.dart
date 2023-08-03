//

import 'package:equatable/equatable.dart';

class SQLException extends Equatable implements Exception {
  final String? _message;
  final String? _prefix;

  const SQLException({String? message, String? prefix})
      : _message = message,
        _prefix = prefix;

  @override
  String toString() {
    return "${_prefix ?? ''}${_message ?? ''}";
  }

  @override
  List<Object?> get props => [_message, _prefix];
}

class InvalidConnectionHostException extends SQLException {}

class InvalidConnectionPortException extends SQLException {}

class InvalidConnectionDatabaseException extends SQLException {}

class InvalidConnectionUsernameOrPasswordException extends SQLException {}

class SQLSyntaxException extends SQLException {
  const SQLSyntaxException([message]) : super(message: message, prefix: "");
}

class UnExpectedConnectionException extends SQLException {
  const UnExpectedConnectionException([message])
      : super(message: message, prefix: "");
}
