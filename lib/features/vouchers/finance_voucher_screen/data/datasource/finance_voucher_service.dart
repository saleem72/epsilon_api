//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';

import 'dtos/get_currency_response.dart';
import 'package:http/http.dart' as http;

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
}
