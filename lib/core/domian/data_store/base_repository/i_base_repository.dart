//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/errors/failure.dart';

abstract class IBaseRepository {
  Future<Either<Failure, String>> getProducts();
  Future<Either<Failure, List<CompactCustomer>>> getCustomers();
  Future<Either<Failure, DateTime>> getCurrencies();
}
