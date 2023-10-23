// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';

import '../../../../core/data/dtos/login_data_dto.dart';
import 'i_login_service.dart';

class LoginService implements ILoginService {
  final ApiHelper apiHelper;
  final Safe safe;

  const LoginService({
    required this.apiHelper,
    required this.safe,
  });
  @override
  Future<LoginDataDTO> login(
      {required String username, required String password}) async {
    Map<String, String> params = {
      "user": username,
      "password": password,
      // "host": Uri.encodeFull(safe.getHost()),
    };

    final url = '${safe.getHost()}/api/';
    const endPoint = ApiEndPoints.login;

    final response = await apiHelper.get(
      url: url, // ApiEndPoints.baseURL,
      endPoint: endPoint,
      params: params,
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw InvalidUsernameOrPasswordException();
    }

    final result = LoginDataDTO.fromJson(response.body);

    return result;
  }
}
