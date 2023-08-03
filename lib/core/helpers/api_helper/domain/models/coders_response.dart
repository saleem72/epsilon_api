//

import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';

class CodersResponse<T> {
  T? data;
  bool status;
  String? message;
  int code;
  String? whatsappMessage;
  CodersResponse({
    this.data,
    required this.status,
    this.message,
    required this.code,
    this.whatsappMessage,
  });

  factory CodersResponse.fromMap(
      Map<String, dynamic> map, Function(dynamic) dataMapper) {
    final data = map['data'];

    return CodersResponse<T>(
      data: data != null && (data is Map<String, dynamic>)
          ? dataMapper(map['data'])
          : null,
      status: map['status'] as bool,
      message: (map['message'] != null && (map['message'] is String))
          ? (map['message'])
          : null,
      code: map['code'] as int,
      whatsappMessage: map['whatsappMessage'] != null
          ? map['whatsappMessage'] as String
          : null,
    );
  }

  T getData() {
    if (code >= 200 && code < 300) {
      if (data != null) {
        return data!;
      } else {
        throw const BadResponseException();
      }
    }

    if (code >= 400 && code < 500) {
      if (code == 404 && message == 'email or password not correct') {
        throw InvalidUsernameOrPasswordException();
      }
    }

    throw UnExpectedException(message);
  }
}
