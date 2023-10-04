//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/features/login_screen/domain/failures/login_failure.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';

abstract class IPricesSelectorRepository {
  Future<Either<HttpFailure, List<Price>>> fetchPrices(String searchTerm);
}
