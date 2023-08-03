//

import 'app_user_dto.dart';

class LoginDataDTO {
  AppUserDTO user;
  String token;
  LoginDataDTO({
    required this.user,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toJson(),
      'token': token,
    };
  }

  factory LoginDataDTO.fromMap(Map<String, dynamic> map) {
    return LoginDataDTO(
      user: AppUserDTO.fromJson(map['user'] as Map<String, dynamic>),
      token: map['token'] as String,
    );
  }

  LoginDataDTO fromJson(Map<String, dynamic> m) {
    return LoginDataDTO.fromMap(m);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }
}
