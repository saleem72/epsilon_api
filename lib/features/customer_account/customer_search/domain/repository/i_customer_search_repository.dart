//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/customer.dart';

abstract class ICustomerSearchRepository {
  Future<Either<Failure, List<Customer>>> searchCustomersByName(
      String searchTerm);
}
