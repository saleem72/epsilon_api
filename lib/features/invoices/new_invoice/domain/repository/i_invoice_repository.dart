//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/compact_product.dart';
import 'package:epsilon_api/core/domian/models/invoice_primary_data.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';
import 'package:epsilon_api/core/domian/models/new_invoice.dart';
import 'package:epsilon_api/core/domian/models/product_unit.dart';
import 'package:epsilon_api/core/errors/failure.dart';

abstract class IInvoiceRepository {
  Future<Either<Failure, List<CompactProduct>>> getProducts();
  Future<Either<Failure, List<CompactCustomer>>> getCustomers();
  Future<Either<Failure, List<InvoiceType>>> getInvoiceTypes();
  Future<Either<Failure, InvoicePrimaryData>> fetchData();
  Future<Either<Failure, List<ProductUnit>>> fetchProductUnit(int productId);
  Future<Either<Failure, double>> fetchProductPrice({
    required int typeId,
    required int itemId,
    required int unitId,
  });
  Future<Either<Failure, NewInvoice>> createInvoice(NewInvoice invoice);
}
