// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

class SearchedInvoice extends Equatable {
  final String invoiceNumber;
  final String invHeaderNotes;
  final double invoiceTotal;
  final double taxVal;
  final double totalDiscount;
  final double invoiceFinal;
  const SearchedInvoice({
    required this.invoiceNumber,
    required this.invHeaderNotes,
    required this.invoiceTotal,
    required this.taxVal,
    required this.totalDiscount,
    required this.invoiceFinal,
  });

  @override
  List<Object?> get props => [
        invoiceNumber,
        invHeaderNotes,
        invoiceTotal,
        taxVal,
        totalDiscount,
        invoiceFinal,
      ];
}
