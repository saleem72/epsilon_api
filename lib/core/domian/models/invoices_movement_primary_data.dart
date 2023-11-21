// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';

class InvoicesMovementPrimaryData {
  final List<CompactCustomer> customers;
  final List<InvoiceType> invoiceTypes;
  InvoicesMovementPrimaryData({
    required this.customers,
    required this.invoiceTypes,
  });
}
