// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

abstract class HttpFailure extends Equatable {
  const HttpFailure();
  factory HttpFailure.noInternet() => HttpNoInternetFailure();
  factory HttpFailure.connectionFailure() => HttpConnectionFailure();
  factory HttpFailure.unAuthorized() => HttpUnAuthorizedFailure();
  factory HttpFailure.serverError() => HttpServerFailure();
  factory HttpFailure.decodingError() => HttpDecodingFailure();
  factory HttpFailure.invalidUsernameOrPassword() =>
      InvalidUsernameOrPasswordFailure();
  factory HttpFailure.unExpected({required String message}) =>
      HttpUnExpectedFailure(message: message);

  @override
  List<Object?> get props => [];
}

class HttpNoInternetFailure extends HttpFailure {}

class HttpConnectionFailure extends HttpFailure {}

class HttpUnAuthorizedFailure extends HttpFailure {}

class HttpServerFailure extends HttpFailure {}

class HttpDecodingFailure extends HttpFailure {}

class InvalidUsernameOrPasswordFailure extends HttpFailure {}

class HttpUnExpectedFailure extends HttpFailure {
  final String message;

  const HttpUnExpectedFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
