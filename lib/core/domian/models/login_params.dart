//

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });

  Map<String, String> toMap() {
    return <String, String>{
      'email': email,
      'password': password,
    };
  }
}
