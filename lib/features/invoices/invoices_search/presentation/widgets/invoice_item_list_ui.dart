//

import 'package:epsilon_api/core/domian/models/invoice_ui_item.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

import 'app_table_cell.dart';
import 'invoice_item_list_ui_row.dart';

class InvoiceItemListUi extends StatelessWidget {
  const InvoiceItemListUi({
    super.key,
    required this.invoiceItems,
  });

  final List<InvoiceUiItem> invoiceItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: AppTableCell(
                  text: context.translate.invoice_product,
                  alignment: Alignment.centerRight,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: AppTableCell(text: context.translate.invoice_unit),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: AppTableCell(text: context.translate.subject_quntity),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: AppTableCell(
                  text: context.translate.invoice_price,
                  hasEdge: false,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        ...invoiceItems.map((e) => InvoiceItemListUiRow(item: e)),
      ],
    );
  }
}
