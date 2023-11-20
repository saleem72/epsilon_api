//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

enum Operations {
  subject,
  customer,
  voucher,
  bill,
  invoicesTotals;

  String title(BuildContext context) {
    switch (this) {
      case Operations.subject:
        return context.translate.operation_subject;
      case Operations.customer:
        return context.translate.operation_customer;
      case Operations.voucher:
        return context.translate.operation_voucher;
      case Operations.bill:
        return context.translate.operation_bill;
      case Operations.invoicesTotals:
        return context.translate.operation_invoices_totals;
    }
  }

  String get icon {
    switch (this) {
      case Operations.subject:
        return AppIcons.querySubject;
      case Operations.customer:
        return AppIcons.queryCustomer;
      case Operations.voucher:
        return AppIcons.queryVoucher;
      case Operations.bill:
        return AppIcons.queryBill;
      case Operations.invoicesTotals:
        return AppIcons.queryBill;
    }
  }
}
