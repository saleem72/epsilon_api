//

import 'dart:convert';

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/data/dtos/add_new_voucher_response.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';

import '../../../../../core/data/dtos/get_currency_response.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class FinanceVoucherService {
  final ApiHelper apiHelper;
  final Safe safe;

  FinanceVoucherService({
    required this.apiHelper,
    required this.safe,
  });

  Future<List<CurrencyDTO>> getCurrency() async {
    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.getCurrency,
      headers: headers,
      printResult: false,
    );

    return _decodeResponse(response);
  }

  List<CurrencyDTO> _decodeResponse(http.Response response) {
    // if (response.statusCode < 200 || response.statusCode > 299) {
    //   throw const UnExpectedException();
    // }

    final str = response.body;

    final result = getCurrencyResponseFromJson(str);

    return result.data ?? [];
  }

  Future<NewVoucherDTO> createVoucher(Map<String, dynamic> entry) async {
    final token = safe.getToken() ?? '';
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
      // "Accept": "application/json",
    };

    final baseUrl = '${safe.getHost()}/api/';
    final urlString = baseUrl + ApiEndPoints.addEntry;
    final uri = Uri.parse(urlString);
    final body = jsonEncode(entry);
    final response = await http.post(uri, headers: headers, body: body);
    var temp = utf8.decode(response.bodyBytes);
    developer.log("🎲 ${temp.toString()}", name: "adding_voucher");

    // final response = await apiHelper.post(
    //   url: url,
    //   endPoint: ApiEndPoints.addEntry,
    //   headers: headers,
    //   body: entry,
    //   printResult: true,
    // );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = addNewVoucherResponseFromJson(response.body);
      return data.data!;
    } else {
      throw const ServerException();
    }
  }
}
