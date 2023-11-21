//

import 'package:epsilon_api/core/data/dtos/get_invoice_movement_response.dart';
import 'package:epsilon_api/core/data/dtos/search_invoices_request.dart';
import 'package:http/http.dart' as http;
import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/data/dtos/compact_customer_dto.dart';
import 'package:epsilon_api/core/data/dtos/invoice_types_response.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';

class InvoicesMovementService {
  final ApiHelper apiHelper;
  final Safe safe;

  const InvoicesMovementService({
    required this.apiHelper,
    required this.safe,
  });

  Future<List<CompactCustomerDTO>?> fetchCustomers() async {
    final Map<String, String> params = {
      "cust": '',
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

    return _decodeCustomersResponse(response);
  }

  Future<List<InvoiceTypeDTO>> fetchInvoiceTypes() async {
    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.invoiceTypes,
      headers: headers,
      printResult: false,
    );

    return _decodeInvoiceTypesResponse(response);
  }

  List<InvoiceTypeDTO> _decodeInvoiceTypesResponse(http.Response response) {
    final str = response.body;

    final result = invoiceTypesResponseFromJson(str);

    return result.data?.salesAndReturnTypes ?? [];
  }

  List<CompactCustomerDTO> _decodeCustomersResponse(http.Response response) {
    final str = response.body;

    final result = searchCompactCustomerResponse(str);

    return result.data?.customers ?? [];
  }

  Future<List<SearchedInvoiceDTO>> searchForInvoices(
      SearchInvoicesRequest request) async {
    final Map<String, String> params = request.toMap();
    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.invoiceMovement,
      headers: headers,
      params: params,
      printResult: false,
    );

    return _decodeSearchInvoicesResponse(response);
    // SearchedInvoiceDTO
  }

  List<SearchedInvoiceDTO> _decodeSearchInvoicesResponse(
      http.Response response) {
    final str = response.body;

    final result = getInvoiceMovementResponseFromJson(str);

    return result.data ?? [];
  }
}
