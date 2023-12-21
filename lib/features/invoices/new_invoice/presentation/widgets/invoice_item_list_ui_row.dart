//

import 'package:epsilon_api/core/domian/models/invoice_ui_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../invoice_bloc/invoice_bloc.dart';
import 'app_table_cell.dart';

class InvoiceItemListUiRow extends StatelessWidget {
  const InvoiceItemListUiRow({
    super.key,
    required this.item,
  });
  final InvoiceUiItem item;
  @override
  Widget build(BuildContext context) {
    // final numberFormatter = intl.NumberFormat('#,##0.#');
    return Slidable(
      key: ValueKey(item.id),
      startActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (_) => context
                .read<InvoiceBloc>()
                .add(InvoiceRemoveItemEvent(item: item)),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            // icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        // margin: const EdgeInsets.only(bottom: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(),
            left: BorderSide(),
            right: BorderSide(),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: AppTableCell(
                  text: item.product.name,
                  alignment: Alignment.centerRight,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: AppTableCell(text: item.unit.name),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: AppTableCell(text: item.quantity.toString()),
              ),
              // const SizedBox(width: 4),
              // Expanded(
              //   flex: 1,
              //   child: AppTableCell(text: numberFormatter.format(item.tax)),
              // ),
              const SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: AppTableCell(
                  text: item.price.toString(),
                  hasEdge: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
