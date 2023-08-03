//

import 'package:dartz/dartz.dart';

import '../failures/login_failure.dart';

abstract class LoginRepository {
  Future<Either<HttpFailure, String>> login(
      {required String username, required String password});
}
