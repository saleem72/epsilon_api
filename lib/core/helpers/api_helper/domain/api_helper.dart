//
import 'package:http/http.dart' as http;

abstract class ApiHelper {
  Future<http.Response> get({
    required String url,
    required String endPoint,
    Map<String, String> headers,
    Map<String, String> params,
    bool printResult,
  });
  Future<http.Response> post({
    required String url,
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, String> headers,
    Map<String, String> params,
    required bool printResult,
  });
}
