//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/price.dart';
import 'package:epsilon_api/core/domian/models/product_datails.dart';
import 'package:epsilon_api/core/errors/failure.dart';

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
