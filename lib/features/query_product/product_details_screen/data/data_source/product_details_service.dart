//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/data/dtos/product_by_barcode_response.dart';
import 'package:epsilon_api/core/data/dtos/product_dto.dart';
import 'package:epsilon_api/core/data/dtos/product_dto_with_stores.dart';
import 'package:epsilon_api/core/domian/models/price.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:http/http.dart' as http;

class ProductDetailsService {
  final ApiHelper apiHelper;
  final Safe safe;

  ProductDetailsService({
    required this.apiHelper,
    required this.safe,
  });

  Future<ProductDTOWithStores> getProductDetails(
      String barcode, List<Price> prices) async {
    final Map<String, String> params = {
      "searchWord": barcode,
      "PriceId": prices.isEmpty ? "44" : prices.first.id.toString(),
      "PriceId2": prices.length > 1 ? prices[1].id.toString() : "-1",
    };

    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';
    final response = await apiHelper.get(
      url: url, // ApiEndPoints.baseURL,
      endPoint: ApiEndPoints.productByBaroode,
      headers: headers,
      params: params,
    );

    return _newDecodeResult(response);
  }

  ProductDTOWithStores _newDecodeResult(http.Response response) {
    // if (response.statusCode == 204) {
    //     throw ProductNotFoundException(message: temp.message);
    //   }
    // throw UnauthorisedException();
    final str = response.body;
    final temp = ProductByBarcodeResponse.fromJson(str);
    if (temp.data == null) {
      throw ProductNotFoundException(message: temp.message);
    }
    final product = (temp.data!.item?.first);
    final stores = temp.data!.sites ?? <SiteDTO>[];

    final result = ProductDTOWithStores(product: product!, stores: stores);

    return result;
  }

  Future<List<ProductDto>> searchByName(
      String serial, List<Price> prices) async {
    final Map<String, String> params = {
      "searchWord": serial,
      "PriceId": prices.isEmpty ? "44" : prices.first.id.toString(),
      "PriceId2": prices.length > 1 ? prices[1].id.toString() : "-1",
    };

    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';
    final response = await apiHelper.get(
      url: url, // ApiEndPoints.baseURL,
      endPoint: ApiEndPoints.productByBaroode,
      headers: headers,
      params: params,
    );

    return _decodeSearchResult(response);
  }

  List<ProductDto> _decodeSearchResult(http.Response response) {
    final str = response.body;
    final temp = ProductByBarcodeResponse.fromJson(str);
    if (temp.data == null) {
      throw ProductNotFoundException(message: temp.message);
    }

    return temp.data!.item ?? [];
  }
}
