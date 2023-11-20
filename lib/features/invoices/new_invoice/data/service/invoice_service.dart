//
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:epsilon_api/core/data/dtos/compact_product_dto.dart';
import 'package:epsilon_api/core/data/dtos/get_price_by_unit_response.dart';
import 'package:epsilon_api/core/data/dtos/invoice_types_response.dart';
import 'package:epsilon_api/core/data/dtos/new_invoice_dto.dart';
import 'package:epsilon_api/core/data/dtos/product_units_response.dart';
import 'package:epsilon_api/core/domian/models/new_invoice.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/data/dtos/compact_customer_dto.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';

class InvoiceService {
  final ApiHelper apiHelper;
  final Safe safe;

  InvoiceService({
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

  Future<List<CompactProductDTO>> fetchProducts() async {
    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.getProducts,
      headers: headers,
      printResult: false,
    );

    return _decodeProductsResponse(response);
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

  Future<List<ProductUnitDTO>> fetchProductUnits(int productId) async {
    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final Map<String, String> params = {
      "ProuductId": productId.toString(),
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.productUnits,
      headers: headers,
      params: params,
      printResult: false,
    );

    return _decodeUnitsResponse(response);
  }

  Future<double?> fetchPrice({
    required int typeId,
    required int itemId,
    required int unitId,
  }) async {
    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final Map<String, String> params = {
      "typeId": typeId.toString(),
      "itemId": itemId.toString(),
      "unitId": unitId.toString(),
    };

    final url = '${safe.getHost()}/api/';

    final response = await apiHelper.get(
      url: url,
      endPoint: ApiEndPoints.getPriceByUnit,
      headers: headers,
      params: params,
      printResult: false,
    );

    final str = response.body;

    final result = getPriceByUnitResponseFromJson(str);

    return result.data?.price;
  }

  List<InvoiceTypeDTO> _decodeInvoiceTypesResponse(http.Response response) {
    final str = response.body;

    final result = invoiceTypesResponseFromJson(str);

    return result.data?.salesAndReturnTypes ?? [];
  }

  List<CompactProductDTO> _decodeProductsResponse(http.Response response) {
    final str = response.body;

    final result = fetchCompactProductResponse(str);

    return result.data?.products ?? [];
  }

  List<CompactCustomerDTO> _decodeCustomersResponse(http.Response response) {
    final str = response.body;

    final result = searchCompactCustomerResponse(str);

    return result.data?.customers ?? [];
  }

  List<ProductUnitDTO> _decodeUnitsResponse(http.Response response) {
    final str = response.body;

    final result = productUnitsResponseFromJson(str);

    return result.data?.units ?? [];
  }

  Future<int> createInvoice(NewInvoice invoice) async {
    final token = safe.getToken() ?? '';
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
      // "Accept": "application/json",
    };

    // POST /api/

    final baseUrl = '${safe.getHost()}/api/';
    final urlString = baseUrl + ApiEndPoints.addInvoice;
    final uri = Uri.parse(urlString);
    final body = jsonEncode(invoice.toMap());
    final response = await http.post(uri, headers: headers, body: body);
    var temp = utf8.decode(response.bodyBytes);
    developer.log("🎲 ${temp.toString()}", name: "adding_invoice");

    // final response = await apiHelper.post(
    //   url: url,
    //   endPoint: ApiEndPoints.addEntry,
    //   headers: headers,
    //   body: entry,
    //   printResult: true,
    // );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = addInvoiceResponseFromJson(response.body);
      final str = data.data!.number ?? '';
      final number = int.tryParse(str) ?? 0;
      return number;
      // final aaa = jsonDecode(response.body);
      // print(aaa);
      // return 87;
    } else {
      throw const ServerException();
    }
  }
}
