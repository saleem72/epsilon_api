import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final String? _message;
  final String? _prefix;

  const AppException({String? message, String? prefix})
      : _message = message,
        _prefix = prefix;

  @override
  String toString() {
    return "${_prefix ?? ''}${_message ?? ''}";
  }

  String get message => _message ?? '';

  @override
  List<Object?> get props => [_message, _prefix];
}

///Exception occure when un expected error happned throw calling an api
class NoInternetException extends AppException {
  const NoInternetException([message])
      : super(
            message: message, prefix: "You are not connected to the internet");
}

///Exception occure when un expected error happned throw calling an api
class UnExpectedException extends AppException {
  const UnExpectedException([message])
      : super(message: message, prefix: "Error During Communication: ");
}

///Exception occure when fail to decode json to dart object
class DecodingException extends AppException {
  const DecodingException([message])
      : super(message: message, prefix: "Decoding error: ");
}

///Exception occure when api request throws SocketException or TimeOutException
class ConnectionException extends AppException {
  const ConnectionException([message])
      : super(message: message, prefix: "Connection Error: ");
}

///Exception occure when api request return invalid or empty data
class BadResponseException extends AppException {
  const BadResponseException([message])
      : super(message: message, prefix: "Invalid data: ");
}

///Exception occure when api request return 400 status code
class BadRequestException extends AppException {
  const BadRequestException([message])
      : super(message: message, prefix: "Invalid Request: ");
}

class ForbiddenException extends AppException {
  const ForbiddenException([message])
      : super(message: message, prefix: "Forbidden: ");
}

///Exception occure when api request return 401 or 403 status code
class UnauthorisedException extends AppException {
  const UnauthorisedException([message])
      : super(message: message, prefix: "Unauthorised: ");
}

///Exception occure when api request return 404 status code
class NotExsitsRouteException extends AppException {
  const NotExsitsRouteException([message])
      : super(message: message, prefix: "Not Exsits Route: ");
}

///Exception occure when api request return 500 status code
class ServerException extends AppException {
  const ServerException([message])
      : super(message: message, prefix: "Server Error: ");
}

class InvalidUsernameOrPasswordException extends AppException {}

class FailToConnectDB extends AppException {}

class FailToExecuteSQL extends AppException {}

class ProductNotFoundException extends AppException {
  const ProductNotFoundException({required String message})
      : super(message: message);
}

class DownloadsDirectoryNotFoundException extends AppException {}
