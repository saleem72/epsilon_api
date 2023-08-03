// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';

import 'i_login_service.dart';

class LoginService implements ILoginService {
  final ApiHelper apiHelper;

  const LoginService({required this.apiHelper});
  @override
  Future<String> login(
      {required String username, required String password}) async {
    final Map<String, String> params = {
      "user": "مدير",
      "passerd": "",
    };

    final response = await apiHelper.get(
      url: ApiEndPoints.baseURL,
      endPoint: ApiEndPoints.login,
      params: params,
    );

    final result = response.body;

    final token = result.replaceAll('"', '');

    return token;

    // await Future.delayed(const Duration(seconds: 1));
    // if (username == 'aaaa' && password == 'aaaa') {
    //   return 'It is ok';
    // }
    // throw InvalidUsernameOrPasswordException();
  }
}

/*
const String baseURL = ApiEndPoints.baseURL;
    const String endPoint = ApiEndPoints.login;
    final params = LoginParams(email: username, password: password);

    final response = await apiHelper.post(
      url: baseURL,
      endPoint: endPoint,
      body: params.toMap(),
      printResult: true,
    );
    final loginDataResponse =
        CodersResponse<LoginDataDTO>.fromMap(response, (map) {
      return LoginDataDTO.fromMap(map);
    });

    final loginData = loginDataResponse.getData();
*/

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
