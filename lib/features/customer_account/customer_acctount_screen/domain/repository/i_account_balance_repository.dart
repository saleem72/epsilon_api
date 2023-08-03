//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/failure/account_balance_failure.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';


abstract class IAccountBalanceRepository {
  Future<Either<AccountBalanceFailure, AccountBalance>> getAccountBalance(
      String guid);
}
