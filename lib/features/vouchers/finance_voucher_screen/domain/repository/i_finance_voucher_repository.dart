//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/compact_customer.dart';

class VoucherPrimaryData {
  final List<Currency> currencies;
  final List<CompactCustomer> customers;
  const VoucherPrimaryData({
    required this.currencies,
    required this.customers,
  });
}

abstract class IFinanceVoucherRepository {
  Future<Either<Failure, List<CompactCustomer>>> getUsers();
  Future<Either<Failure, List<Currency>>> getCurrency();
  Future<Either<Failure, VoucherPrimaryData>> fetchData();
}
