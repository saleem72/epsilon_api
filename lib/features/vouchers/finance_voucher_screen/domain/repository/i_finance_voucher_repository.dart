//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/compact_customer.dart';

abstract class IFinanceVoucherRepository {
  Future<Either<Failure, List<CompactCustomer>>> getUsers();
}
