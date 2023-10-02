//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/helpers/network_info/network_info.dart';
import 'package:epsilon_api/features/login_screen/domain/failures/login_failure.dart';
import 'package:epsilon_api/features/login_screen/domain/repository/login_repository.dart';

import '../../../../../core/errors/exceptions/app_exceptions.dart';
import '../data_source/i_login_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ILoginService service;
  final NetworkInfo networkInfo;
  LoginRepositoryImpl({
    required this.service,
    required this.networkInfo,
  });

  @override
  Future<Either<HttpFailure, String>> login(
      {required String username, required String password}) async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return Left(HttpFailure.connectionFailure());
      }
      final data = await service.login(username: username, password: password);
      return Right(data.token);
    } on InvalidUsernameOrPasswordException {
      return Left(HttpFailure.invalidUsernameOrPassword());
    } on ServerException {
      return Left(HttpFailure.invalidUsernameOrPassword());
    } catch (error) {
      final failure = mapError(error);
      return Left(failure);
    }
  }

  HttpFailure mapError(Object error) {
    if (error is ConnectionException) {
      return HttpFailure.connectionFailure();
    }

    if (error is TypeError) {
      return HttpFailure.decodingError();
    }

    if (error is BadResponseException) {}

    // bad response status code 400
    if (error is BadRequestException) {}

    // Status code
    if (error is UnauthorisedException) {
      return HttpFailure.unAuthorized();
    }
    if (error is NotExsitsRouteException) {}
    if (error is ServerException) {
      return HttpFailure.serverError();
    }

    if (error is ServerException) {
      return HttpFailure.invalidUsernameOrPassword();
    }

    // if (error is UnExpectedException) {}
    return HttpFailure.unExpected(message: error.toString());
  }
}
