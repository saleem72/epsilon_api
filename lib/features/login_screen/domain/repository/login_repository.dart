//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(
      {required String username, required String password});
}
