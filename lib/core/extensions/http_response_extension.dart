//

import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:http/http.dart' as http;

extension HandleHTTPResponse on http.Response {
  String handleResponse() {
    if (statusCode == 401) {
      throw const UnauthorisedException();
    }
    if (statusCode >= 500) {
      throw const ServerException();
    }
    return body;
  }
}
