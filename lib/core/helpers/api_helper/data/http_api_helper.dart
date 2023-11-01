//
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/network_info/network_info.dart';
import 'package:http/http.dart' as http;

class HttpApiHelper implements ApiHelper {
  final http.Client client;
  final NetworkInfo networkInfo;

  HttpApiHelper({
    required this.client,
    required this.networkInfo,
  });

  @override
  Future<http.Response> get({
    required String url,
    required String endPoint,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    bool printResult = false,
  }) async {
    Future<http.Response> request;
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw const NoInternetException();
      }
      final uri = Uri.parse(url + endPoint).replace(queryParameters: params);

      if (headers != null) {
        request = client.get(uri, headers: headers);
      } else {
        request = client.get(uri);
      }
      final response = await request;
      if (printResult) {
        _printResponse(response);
      }
      return _returnResponse(response);
    } catch (e) {
      throw _rethrowExceptions(e);
    }
  }

  @override
  Future<http.Response> post({
    required String url,
    required String endPoint,
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? params,
    bool printResult = false,
  }) async {
    Future<http.Response> request;
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw const NoInternetException();
      }
      final uri = Uri.parse(url + endPoint).replace(queryParameters: params);
      if (headers != null) {
        request = client.post(uri, headers: headers, body: body);
      } else {
        request = client.post(uri, body: body);
      }

      final response = await request;
      if (printResult) {
        _printResponse(response);
      }
      return _returnResponse(response);
    } catch (e) {
      throw _rethrowExceptions(e);
    }
  }

  Exception _rethrowExceptions(error) {
    if (error is SocketException) {
      return const ConnectionException('No Internet connection');
    }
    if (error is TimeoutException) {
      return const ConnectionException('No Internet connection');
    }
    if (error is FormatException) {
      return const DecodingException('Fail to decode data');
    }
    if (error is TypeError) {
      return const DecodingException('Fail to decode data');
    }
    if (error is BadRequestException) {
      return error;
    }
    if (error is BadResponseException) {
      return error;
    }
    if (error is UnauthorisedException) {
      return error;
    }
    if (error is ForbiddenException) {
      return error;
    }
    if (error is ServerException) {
      return error;
    }
    if (error is NotExsitsRouteException) {
      return error;
    }
    if (error is ProductNotFoundException) {
      return error;
    }

    return UnExpectedException(error.toString());
  }

  http.Response _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 204:
        throw const ProductNotFoundException(message: 'Not Result Found');
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());
      case 500:
        throw const ServerException('');
      default:
        return response;
    }
  }

  _printResponse(http.Response response) {
    var temp = utf8.decode(response.bodyBytes);
    developer.log("🎲 ${temp.toString()}", name: 'api.call');
  }
}
