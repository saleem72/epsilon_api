//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/customer.dart';
import 'package:epsilon_api/core/errors/failure.dart';

abstract class ICustomerSearchRepository {
  Future<Either<Failure, List<Customer>>> searchCustomersByName(
      String searchTerm);
}
