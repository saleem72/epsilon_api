// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/company_info.dart';
import 'package:epsilon_api/core/domian/models/invoice_ui_item.dart';
import 'package:epsilon_api/core/domian/models/new_invoice.dart';

class PDFInvoice {
  final NewInvoice invoice;
  final CompactCustomer customer;
  final List<InvoiceUiItem> invoiceItems;
  final CompanyInfo companyInfo;

  PDFInvoice({
    required this.invoice,
    required this.customer,
    required this.invoiceItems,
    required this.companyInfo,
  });
}
