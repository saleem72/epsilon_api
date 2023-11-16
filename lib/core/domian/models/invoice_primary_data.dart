// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/compact_product.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';

class InvoicePrimaryData {
  final List<CompactCustomer> customers;
  final List<CompactProduct> products;
  final List<InvoiceType> invoiceTypes;
  InvoicePrimaryData({
    required this.customers,
    required this.products,
    required this.invoiceTypes,
  });
}
