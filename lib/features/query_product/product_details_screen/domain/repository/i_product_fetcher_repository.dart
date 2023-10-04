//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';

import '../models/product_datails.dart';

abstract class IProductFetcherRepository {
  Future<Either<Failure, List<ProductDetails>>> getProductBySerial({
    required String serial,
    required List<Price> prices,
  });
  Future<Either<Failure, ProductDetails>> getProductByBarcode({
    required String barcode,
    required List<Price> prices,
  });
}
