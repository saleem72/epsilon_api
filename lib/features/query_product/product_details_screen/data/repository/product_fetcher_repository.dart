//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/data/data_source/product_details_service.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/product_datails.dart';

import '../../domain/repository/i_product_fetcher_repository.dart';

class ProductFetcherRepository implements IProductFetcherRepository {
  final ProductDetailsService _service;

  ProductFetcherRepository({
    required ProductDetailsService service,
  }) : _service = service;

  @override
  Future<Either<Failure, ProductDetails>> getProductByBarcode({
    required String barcode,
    required List<Price> prices,
  }) async {
    try {
      final result = await _service.getProductDetails(barcode, prices);
      return right(result.toProduct());
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductDetails>>> getProductBySerial({
    required String serial,
    required List<Price> prices,
  }) async {
    try {
      final result = await _service.searchByName(serial, prices);
      final products = result.map((e) => e.toProduct()).toList();
      return right(products);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
