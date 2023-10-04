//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';

import '../failures/get_product_failure.dart';
import '../models/product_datails.dart';

abstract class IProductFetcherRepository {
  Future<Either<GetProductFailure, List<ProductDetails>>> getProductBySerial({
    required String serial,
    required List<Price> prices,
  });
  Future<Either<GetProductFailure, ProductDetails>> getProductByBarcode({
    required String barcode,
    required List<Price> prices,
  });
}
