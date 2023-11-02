//

import 'package:http/http.dart' as http;
import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/data/dtos/compact_customer_dto.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';

class BaseService {
  final ApiHelper apiHelper;
  final Safe safe;

  BaseService({
    required this.apiHelper,
    required this.safe,
  });

  Future<List<CompactCustomer>?> fetchCustomers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return [];
  }

  Future<String> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'Hello world';
  }

  Future<DateTime> fetchCurrencies() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return DateTime.now().add(const Duration(hours: -3));
  }

  Future<List<CompactCustomerDTO>> searchCustomersByName(
      String searchTerm) async {
    final Map<String, String> params = {
      "cust": searchTerm,
    };

    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.customersByName,
      headers: headers,
      params: params,
      printResult: false,
    );

    return _decodeResponse(response);
  }

  List<CompactCustomerDTO> _decodeResponse(http.Response response) {
    // if (response.statusCode < 200 || response.statusCode > 299) {
    //   throw const UnExpectedException();
    // }

    final str = response.body;

    final result = searchCompactCustomerResponse(str);

    return result.data?.customers ?? [];
  }
}
