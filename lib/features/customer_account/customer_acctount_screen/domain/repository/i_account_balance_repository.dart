//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/core/domian/models/account_balance.dart';

abstract class IAccountBalanceRepository {
  Future<Either<Failure, List<AccountBalance>>> getAccountBalance(int id);
}
