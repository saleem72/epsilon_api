//

import 'dtos/login_data_dto.dart';

abstract class ILoginService {
  Future<LoginDataDTO> login(
      {required String username, required String password});
}
