//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/login_screen/domain/repository/login_repository.dart';

import '../data_source/i_login_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ILoginService service;
  LoginRepositoryImpl({
    required this.service,
  });

  @override
  Future<Either<Failure, String>> login(
      {required String username, required String password}) async {
    try {
      final data = await service.login(username: username, password: password);
      return right(data.token);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
