//

import 'package:dartz/dartz.dart';

import '../failures/customer_search_failure.dart';
import '../models/customer.dart';

abstract class ICustomerSearchRepository {
  Future<Either<CustomerSearchFailure, List<Customer>>> searchCustomersByName(
      String searchTerm);
}
