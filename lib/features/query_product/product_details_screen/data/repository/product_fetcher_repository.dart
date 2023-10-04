//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/data/data_source/product_details_service.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/product_datails.dart';

import '../../../../../../core/helpers/network_info/network_info.dart';
import '../../domain/failures/get_product_failure.dart';
import '../../domain/repository/i_product_fetcher_repository.dart';

class ProductFetcherRepository implements IProductFetcherRepository {
  final NetworkInfo _networkInfo;
  final ProductDetailsService _service;

  ProductFetcherRepository({
    required NetworkInfo networkInfo,
    required ProductDetailsService service,
  })  : _networkInfo = networkInfo,
        _service = service;

  @override
  Future<Either<GetProductFailure, ProductDetails>> getProductByBarcode({
    required String barcode,
    required List<Price> prices,
  }) async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      return Left(GetProductFailure.noInternet());
    }

    try {
      final result = await _service.getProductDetails(barcode, prices);
      return right(result.toProduct());
    } catch (e) {
      return left(GetProductFailure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<GetProductFailure, List<ProductDetails>>> getProductBySerial({
    required String serial,
    required List<Price> prices,
  }) async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      return Left(GetProductFailure.noInternet());
    }

    try {
      final result = await _service.searchByName(serial, prices);
      final products = result.map((e) => e.toProduct()).toList();
      return right(products);
    } catch (e) {
      return left(GetProductFailure.unexpected(message: e.toString()));
    }
  }
}
