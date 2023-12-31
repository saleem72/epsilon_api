//

import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/errors/failure.dart';

extension ObjectToException on Object {
  Failure toFailure() {
    developer.log('🔥', name: 'error', error: this);
    if (this is NoInternetException) {
      return const NoInternetFailure();
    }
    if (this is ConnectionException) {
      return const ConnectionFailure();
    }
    if (this is SocketException) {
      return const ConnectionFailure();
    }
    if (this is TimeoutException) {
      return const ConnectionFailure();
    }
    if (this is FormatException) {
      return const DecodingFailure();
    }
    if (this is TypeError) {
      return const DecodingFailure();
    }
    if (this is UnauthorisedException) {
      return const UnAuthorizedFailure();
    }
    if (this is ForbiddenException) {
      return const UnAuthorizedFailure();
    }
    if (this is ServerException) {
      return const ServerFailure();
    }
    if (this is ProductNotFoundException) {
      return ProductNotFoundFailure(
          message: (this as ProductNotFoundException).message);
    }
    if (this is DownloadsDirectoryNotFoundException) {
      return const DownloadsDirectoryNotFoundFailure();
    }
    return UnExpectedFailure(message: toString());
  }
}
