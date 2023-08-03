//

import 'package:epsilon_api/configuration/api_end_points.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/helpers/api_helper/domain/api_helper.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:http/http.dart' as http;

import '../dtos/product_dto.dart';

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
      "Barcode": barcode,
      "PriceId": "4",
      "PriceId2": "-1",
      "Guid": safe.getToken() ?? '',
      "id": "62028"
    };

    // final response = await apiHelper.get(
    //   url: urlString,
    //   endPoint: '',
    // );

    final response = await apiHelper.get(
      url: ApiEndPoints.baseURL,
      endPoint: ApiEndPoints.productByBaroode,
      params: params,
    );

    return _decodeResult(response);
  }

  ProductDTOWithStores _decodeResult(http.Response response) {
    final str = response.body;
    final temp = productFromJson(str);
    if (temp.length == 2) {
      final products = temp[0].map((e) => e.toProductDTO()).toList();
      final stores = temp[1].map((e) => e.toStoreDTO()).toList();

      final result =
          ProductDTOWithStores(product: products.first, stores: stores);

      return result;
    }

    throw const DecodingException();
  }
}
