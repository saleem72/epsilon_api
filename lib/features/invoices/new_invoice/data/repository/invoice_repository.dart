//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/invoice_primary_data.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';
import 'package:epsilon_api/core/domian/models/new_invoice.dart';
import 'package:epsilon_api/core/domian/models/product_unit.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/compact_product.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';

import '../../domain/repository/i_invoice_repository.dart';
import '../service/invoice_service.dart';

class InvoiceRepository implements IInvoiceRepository {
  final InvoiceService _service;

  InvoiceRepository({
    required InvoiceService service,
  }) : _service = service;

  Future<List<CompactCustomer>> _fetchCustomers() async {
    final data = await _service.fetchCustomers();
    final customers = (data ?? []).map((e) => e.toCompactUser()).toList();
    return customers;
  }

  Future<List<CompactProduct>> _fetchProducts() async {
    final data = await _service.fetchProducts();
    final products = data.map((e) => e.toCompactProduct()).toList();
    return products;
  }

  Future<List<InvoiceType>> _fetchInvoiceTypes() async {
    final remote = await _service.fetchInvoiceTypes();
    final data = remote.map((e) => e.toModel()).toList();
    return data;
  }

  @override
  Future<Either<Failure, InvoicePrimaryData>> fetchData() async {
    try {
      final customersReq = _fetchCustomers();
      final productsReq = _fetchProducts();
      final invoiceTypesReq = _fetchInvoiceTypes();
      final results =
          await Future.wait([customersReq, productsReq, invoiceTypesReq]);
      final customersResult = results[0];
      final productsResult = results[1];
      final invoiceTypesResult = results[2];
      List<CompactCustomer> customers =
          customersResult as List<CompactCustomer>;
      List<CompactProduct> products = productsResult as List<CompactProduct>;
      List<InvoiceType> invoiceTypes = invoiceTypesResult as List<InvoiceType>;

      final data = InvoicePrimaryData(
        customers: customers,
        products: products,
        invoiceTypes: invoiceTypes,
      );

      return right(data);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<CompactProduct>>> getProducts() async {
    try {
      final products = await _fetchProducts();
      return right(products);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<CompactCustomer>>> getCustomers() async {
    try {
      final customers = await _fetchCustomers();
      return right(customers);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<InvoiceType>>> getInvoiceTypes() async {
    try {
      final types = await _fetchInvoiceTypes();
      return right(types);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  Future<List<ProductUnit>> _fectchProductUnits(int productId) async {
    final remote = await _service.fetchProductUnits(productId);
    final data = remote.map((e) => e.toModel()).toList();

    return data;
  }

  @override
  Future<Either<Failure, List<ProductUnit>>> fetchProductUnit(
      int productId) async {
    try {
      final units = await _fectchProductUnits(productId);
      return right(units);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, double>> fetchProductPrice({
    required int typeId,
    required int itemId,
    required int unitId,
  }) async {
    try {
      final data = await _service.fetchPrice(
        typeId: typeId,
        itemId: itemId,
        unitId: unitId,
      );
      return right(data ?? 0);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, NewInvoice>> createInvoice(NewInvoice invoice) async {
    try {
      final data = await _service.createInvoice(invoice);
      return right(data);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
