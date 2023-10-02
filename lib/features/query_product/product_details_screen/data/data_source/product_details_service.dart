//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/data/dtos/product_dto.dart';
import 'package:http/http.dart' as http;

import '../dtos/new_product_dto.dart';
import '../dtos/product_dto_with_stores.dart';
import '../dtos/search_by_name_dto.dart';

class ProductDetailsService {
  final ApiHelper apiHelper;
  final Safe safe;

  ProductDetailsService({
    required this.apiHelper,
    required this.safe,
  });

  Future<ProductDTOWithStores> getProductDetails(String barcode) async {
    // final urlString = "{{host}}/Proucts/GetProductByBaroode?Barcode=800199&PriceId=44&PriceId2=-1&Guid={{guid}}&id=62028"

    // {{host}}/Proucts/GetProductByBaroode?
    // Barcode=800199&
    // PriceId=44&
    // PriceId2=-1&
    // Guid={{guid}}&
    // id=62028

    final Map<String, String> params = {
      "searchWord": barcode,
      "PriceId": "44",
      "PriceId2": "-1",
      // "id": "62028"
    };

    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    // final response = await apiHelper.get(
    //   url: urlString,
    //   endPoint: '',
    // );
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
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw const UnExpectedException();
    }
    try {
      final str = response.body;
      final temp = ProductByBarcodeResponse.fromJson(str);
      final product = (temp.data.item?.first);
      final stores = temp.data.sites ?? <Site>[];

      final result = ProductDTOWithStores(product: product!, stores: stores);

      return result;
    } catch (e) {
      throw const DecodingException();
    }
  }

  Future<List<ProductDto>> searchByName(String serial) async {
    final Map<String, String> params = {
      "searchKeyWord": serial,
    };

    final headers = {
      "Authorization": "Bearer ${safe.getToken() ?? ''}",
      "Accept": "application/json"
    };

    final url = '${safe.getHost()}/api/';
    final response = await apiHelper.get(
      url: url, // ApiEndPoints.baseURL,
      endPoint: ApiEndPoints.seachByName,
      headers: headers,
      params: params,
    );

    return _decodeSearchResult(response);
  }

  List<ProductDto> _decodeSearchResult(http.Response response) {
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw const UnExpectedException();
    }
    final str = response.body;
    if (str.replaceAll('"', '') == "Empty") {
      return [];
    }
    final result = SearchByNameResponse.fromJson(str);
    return result.data.products ?? [];
  }
}
