//

import 'package:dartz/dartz.dart';

import '../failures/get_product_failure.dart';
import '../models/product_datails.dart';

abstract class IProductFetcherRepository {
  Future<Either<GetProductFailure, ProductDetails>> getProductBySerial(
      {required String serial});
  Future<Either<GetProductFailure, ProductDetails>> getProductByBarcode(
      {required String barcode});
}
