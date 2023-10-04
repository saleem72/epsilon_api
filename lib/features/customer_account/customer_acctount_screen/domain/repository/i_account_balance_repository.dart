//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';

abstract class IAccountBalanceRepository {
  Future<Either<Failure, List<AccountBalance>>> getAccountBalance(int id);
}
