//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/currency.dart';
import 'package:epsilon_api/core/domian/models/voucher_primary_data.dart';
import 'package:epsilon_api/core/errors/failure.dart';

abstract class IFinanceVoucherRepository {
  Future<Either<Failure, List<CompactCustomer>>> getUsers();
  Future<Either<Failure, List<Currency>>> getCurrency();
  Future<Either<Failure, VoucherPrimaryData>> fetchData();
  Future<Either<Failure, int>> createVoucher(
      {required Map<String, dynamic> entry});
}
