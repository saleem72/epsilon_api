// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/currency.dart';
import 'package:epsilon_api/core/domian/models/voucher_primary_data.dart';
import 'package:epsilon_api/core/domian/models/voucher_type.dart';

import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_search/data/data_source/customer_search_service.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/data/datasource/finance_voucher_service.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/domain/repository/i_finance_voucher_repository.dart';

class FinanceVoucherRepository implements IFinanceVoucherRepository {
  final CustomerSearchService _service;
  final FinanceVoucherService _miscService;
  FinanceVoucherRepository(
      {required CustomerSearchService service,
      required FinanceVoucherService miscService})
      : _service = service,
        _miscService = miscService;

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

  @override
  Future<Either<Failure, List<Currency>>> getCurrency() async {
    try {
      final list = await _miscService.getCurrency();
      final result = list.map((e) => e.toCurrency()).toList();
      return right(result);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  Future<List<CompactCustomer>> _innerCustomers() async {
    final list = await _service.searchCustomersByName('');
    final result = list.map((e) => e.toCompactUser()).toList();
    return result;
  }

  Future<List<Currency>> _innerCurrency() async {
    final list = await _miscService.getCurrency();
    final result = list.map((e) => e.toCurrency()).toList();
    return result;
  }

  Future<List<VoucherType>> _innerVoucherTypes() async {
    final list = await _miscService.getVoucherTypes();
    final result = list.map((e) => e.toModel()).toList();
    return result;
  }

  @override
  Future<Either<Failure, VoucherPrimaryData>> fetchData() async {
    try {
      final currenciesReq = _innerCurrency();
      final usersReq = _innerCustomers();
      final voucherTypesReq = _innerVoucherTypes();
      final results =
          await Future.wait([currenciesReq, usersReq, voucherTypesReq]);
      final currenciesResult = results[0];
      final customersResult = results[1];
      final voucherTypesResult = results[2];
      List<Currency> currencies = currenciesResult as List<Currency>;
      List<CompactCustomer> customers =
          customersResult as List<CompactCustomer>;
      List<VoucherType> voucherTypes = voucherTypesResult as List<VoucherType>;
      final data = VoucherPrimaryData(
        currencies: currencies,
        customers: customers,
        voucherTypes: voucherTypes,
      );
      return right(data);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, int>> createVoucher(
      {required Map<String, dynamic> entry}) async {
    try {
      final data = await _miscService.createVoucher(entry);
      final number = int.tryParse(data.number ?? '0') ?? 0;
      return right(number);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
