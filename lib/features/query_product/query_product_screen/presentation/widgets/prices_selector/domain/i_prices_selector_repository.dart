//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/price.dart';
import 'package:epsilon_api/features/login_screen/domain/failures/login_failure.dart';

abstract class IPricesSelectorRepository {
  Future<Either<HttpFailure, List<Price>>> fetchPrices(String searchTerm);
}
