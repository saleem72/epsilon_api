// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:convert';

/*
  {
  "StatusCode": 200,
  "Message": "Data retrieved successfully",
  "Data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIyYjZjZTRkOC02YmRmLTQwZDYtOWYzMy00NjdlMmQyYjY5N2YiLCJndWlkIjoiNjg4NzI3MDMtYmQ2Ny00NWI4LThhNmYtNzFmMDc5OGEwZDc4IiwiZXhwIjoxNjk1ODk4OTk5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjQ0MzQ1LyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDQzNDUvIn0.Go_6H6o43xxiSH2x3yBf8KbvmqKx87uEqjWXI9pXE78"
}
*/

class LoginDataDTO {
  int statusCode;
  String token;
  String? message;
  LoginDataDTO({required this.statusCode, required this.token, this.message});

  factory LoginDataDTO.fromMap(Map<String, dynamic> map) {
    return LoginDataDTO(
      statusCode: map['StatusCode'] as int,
      token: map['Data'] as String,
      message: map['Message'] != null ? map['Message'] as String : null,
    );
  }

  factory LoginDataDTO.fromJson(String source) =>
      LoginDataDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
