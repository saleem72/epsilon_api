// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:http/http.dart' as http;
import '../dtos/customer_dto.dart';

class CustomerSearchService {
  final ApiHelper apiHelper;
  final Safe safe;

  CustomerSearchService({
    required this.apiHelper,
    required this.safe,
  });

  Future<List<CustomerDto>> searchCustomersByName(String searchTerm) async {
    // const endPoint = 'Clients/Customers';
    // {{host}}/Clients/Customers?cust=شركة&Guid={{guid}}
    final Map<String, String> params = {
      "cust": searchTerm,
      "Guid": safe.getToken() ?? '',
    };

    final response = await apiHelper.get(
      url: ApiEndPoints.baseURL,
      endPoint: ApiEndPoints.customersByName,
      params: params,
    );

    return _decodeResponse(response);
  }

  List<CustomerDto> _decodeResponse(http.Response response) {
    try {
      final str = response.body;
      final pure = str.replaceAll('"', '');
      if (pure == "Empty") {
        return [];
      }

      final result = customerDtoFromJson(str);

      return result;
    } catch (_) {
      throw const DecodingException();
    }
  }
}
