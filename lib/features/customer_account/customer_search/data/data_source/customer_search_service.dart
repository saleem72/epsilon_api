// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/data/dtos/customer_dto.dart';

class CustomerSearchService {
  final ApiHelper apiHelper;
  final Safe safe;

  CustomerSearchService({
    required this.apiHelper,
    required this.safe,
  });

  Future<List<CustomerDTO>> searchCustomersByName(String searchTerm) async {
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

  List<CustomerDTO> _decodeResponse(http.Response response) {
    // if (response.statusCode < 200 || response.statusCode > 299) {
    //   throw const UnExpectedException();
    // }

    final str = response.body;

    final result = searchCustomerResponseFromJson(str);

    return result.data?.customers ?? [];
  }
}
