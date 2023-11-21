//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/data/dtos/search_invoices_request.dart';
import 'package:epsilon_api/core/domian/models/Invoices_movement_primary_data.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';
import 'package:epsilon_api/core/domian/models/searched_invoice.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/invoices/invoices_movement/data/service/invoices_movment_service.dart';

import '../../domian/repository/i_invoices_movement_repository.dart';

class InvoicesMovementRepository implements IInvoicesMovementRepository {
  final InvoicesMovementService _service;
  InvoicesMovementRepository({
    required InvoicesMovementService service,
  }) : _service = service;

  Future<List<CompactCustomer>> _fetchCustomers() async {
    final data = await _service.fetchCustomers();
    final customers = (data ?? []).map((e) => e.toCompactUser()).toList();
    return customers;
  }

  Future<List<InvoiceType>> _fetchInvoiceTypes() async {
    final remote = await _service.fetchInvoiceTypes();
    final data = remote.map((e) => e.toModel()).toList();
    return data;
  }

  @override
  Future<Either<Failure, InvoicesMovementPrimaryData>> fetchData() async {
    try {
      final customersReq = _fetchCustomers();
      final invoiceTypesReq = _fetchInvoiceTypes();
      final results = await Future.wait([customersReq, invoiceTypesReq]);
      final customersResult = results[0];
      final invoiceTypesResult = results[1];
      List<CompactCustomer> customers =
          customersResult as List<CompactCustomer>;
      List<InvoiceType> invoiceTypes = invoiceTypesResult as List<InvoiceType>;

      final data = InvoicesMovementPrimaryData(
        customers: customers,
        invoiceTypes: invoiceTypes,
      );

      return right(data);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchedInvoice>>> searchForInvoices(
      SearchInvoicesRequest request) async {
    try {
      final remote = await _service.searchForInvoices(request);
      final data = remote.map((e) => e.toModel()).toList();
      return right(data);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
