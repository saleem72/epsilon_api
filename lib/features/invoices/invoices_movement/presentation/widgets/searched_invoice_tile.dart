//

import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:intl/intl.dart' as intl;
import 'package:epsilon_api/core/domian/models/searched_invoice.dart';
import 'package:flutter/material.dart';

class SearchedInvoiceTile extends StatelessWidget {
  const SearchedInvoiceTile({
    super.key,
    required this.balance,
  });

  final SearchedInvoice balance;

  @override
  Widget build(BuildContext context) {
    final numberFormatter = intl.NumberFormat('#,##0.##');
    // final dateFormatter = intl.DateFormat('yyyy/M/d');
    final normText = context.textTheme.bodyMedium;
    final boldText = context.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(80),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                ),
                children: <Widget>[
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Row(
                      children: [
                        const SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            height: 32,
                            child: Text(
                              context.translate.invoice_num,
                              style: boldText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.translate.sub_total,
                          style: boldText,
                        ),
                      ],
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.translate.invoice_note,
                          style: boldText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              balance.invoiceNumber,
                              style: normText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: _subTotal(normText, numberFormatter),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              balance.invHeaderNotes,
                              style: normText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          _taxsLine(context, boldText, numberFormatter),
          _finalTotalLine(context, boldText, numberFormatter),
        ],
      ),
    );
  }

  Widget _subTotal(TextStyle? normText, intl.NumberFormat numberFormatter) {
    final value = numberFormatter.format(balance.invoiceTotal);

    return value == '0'
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: normText,
              )
            ],
          );
  }

  Widget _finalTotalLine(BuildContext context, TextStyle? boldText,
      intl.NumberFormat numberFormatter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
          left: BorderSide(),
          right: BorderSide(),
        ),
      ),
      child: Row(
        children: [
          Text(
            context.translate.final_totoal,
            style: boldText,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(numberFormatter.format(balance.invoiceFinal)),
          ),
        ],
      ),
    );
  }

  Widget _taxsLine(BuildContext context, TextStyle? boldText,
      intl.NumberFormat numberFormatter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
          left: BorderSide(),
          right: BorderSide(),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    context.translate.discount,
                    style: boldText,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      numberFormatter.format(balance.totalDiscount),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: [
                  Text(
                    context.translate.taxs,
                    style: boldText,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      numberFormatter.format(balance.taxVal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
