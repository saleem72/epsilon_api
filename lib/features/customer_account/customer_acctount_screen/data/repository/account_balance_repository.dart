//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/data_source/customer_account_service.dart';
import 'package:epsilon_api/core/domian/models/account_balance.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/repository/i_account_balance_repository.dart';

class AccountBalanceRepository implements IAccountBalanceRepository {
  final CustomerAccountService _service;

  AccountBalanceRepository({
    required CustomerAccountService service,
  }) : _service = service;
  @override
  Future<Either<Failure, List<AccountBalance>>> getAccountBalance(
      int id) async {
    try {
      final balance = await _service.getAccountBalance(id);
      final result = balance.map((e) => e.toAccountBalance()).toList();
      return right(result);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
