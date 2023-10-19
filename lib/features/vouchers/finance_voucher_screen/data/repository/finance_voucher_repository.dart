//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_search/data/data_source/customer_search_service.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/compact_customer.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/domain/repository/i_finance_voucher_repository.dart';

class FinanceVoucherRepository implements IFinanceVoucherRepository {
  final CustomerSearchService _service;

  FinanceVoucherRepository({
    required CustomerSearchService service,
  }) : _service = service;

  @override
  Future<Either<Failure, List<CompactCustomer>>> getUsers() async {
    try {
      final list = await _service.searchCustomersByName('');
      final result = list.map((e) => e.toCompactUser()).toList();
      return right(result);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
