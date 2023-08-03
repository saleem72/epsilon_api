//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/data_source/customer_account_service.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/repository/i_account_balance_repository.dart';

import '../../domain/failure/account_balance_failure.dart';

class AccountBalanceRepository implements IAccountBalanceRepository {
  final CustomerAccountService _service;

  AccountBalanceRepository({
    required CustomerAccountService service,
  }) : _service = service;
  @override
  Future<Either<AccountBalanceFailure, AccountBalance>> getAccountBalance(
      String guid) async {
    try {
      final balance = await _service.getAccountBalance(guid);
      final result = balance.toAccountBalance();
      return right(result);
    } catch (e) {
      return left(GeneralAccountBalanceFailure(message: e.toString()));
    }
  }
}
