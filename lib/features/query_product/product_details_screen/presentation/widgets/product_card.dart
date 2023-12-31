//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/domian/models/product_datails.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/widgets/labeled_text.dart';
import 'table_cell_content.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.product,
  });
  final ProductDetails? product;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        product?.memoryImage == null
            ? Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image,
                  size: 80,
                  color: Colors.white,
                ))
            : SizedBox(
                height: 100,
                width: 100,
                child: Image.memory(product!.memoryImage!)),
        const SizedBox(height: 16),
        LabeledText(
          text: product?.code ?? '',
          label: context.translate.subject_id,
          icon: AppIcons.subjectId,
        ),
        const SizedBox(height: 16),
        LabeledText(
          text: product?.name ?? '',
          label: context.translate.subject_name,
          icon: AppIcons.subjectName,
        ),
        const SizedBox(height: 16),
        LabeledText(
          text: product?.barcode ?? '',
          label: context.translate.serial_number,
          icon: AppIcons.serialNumber,
        ),
        const SizedBox(height: 16),
        LabeledText(
          text: product?.spec ?? '',
          label: context.translate.subject_properties,
          icon: AppIcons.properties,
        ),
        const SizedBox(height: 16),
        _pricesTable(context),
        const SizedBox(height: 16),
        _possibleQuntitiesTable(context),
      ],
    );
  }

  Widget _pricesTable(BuildContext context) {
    final formatter = NumberFormat('#,##0.##');
    return Table(
      border: TableBorder.all(
        color: AppColors.primaryLight,
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(), //IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child:
                    TableCellContent(text: context.translate.subject_price_one),
              ),
            ),
            TableCell(
              child:
                  TableCellContent(text: context.translate.subject_price_tow),
            ),
          ],
        ),
        TableRow(
          // decoration: const BoxDecoration(
          //   color: Colors.grey,
          // ),
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formatter.format(product?.enduser ?? 0),
                  style: Topology.subTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formatter.format(product?.enduser2 ?? 0),
                  style: Topology.subTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _possibleQuntitiesTable(BuildContext context) {
    if (product != null && product!.stores.isNotEmpty) {
      return Column(
        children: [
          _quantitiesTable(context, product!.stores),
          const SizedBox(height: 16),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _quantitiesTable(BuildContext context, List<StoreQuntity> stores) {
    final quantity = stores.fold<double>(
        0, (previousValue, element) => previousValue + element.quantity);
    final formatter = NumberFormat('#,##0.##');
    return Column(
      children: [
        Table(
          border: TableBorder.all(
            color: AppColors.primaryLight,
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(), //IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child:
                        TableCellContent(text: context.translate.subject_store),
                  ),
                ),
                TableCell(
                  child:
                      TableCellContent(text: context.translate.subject_quntity),
                ),
              ],
            ),
            ...stores
                .map((e) => _tableRowForStore(e.quantity, e.store, formatter)),
          ],
        ),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
              border: Border(
            left: BorderSide(
              color: AppColors.primaryLight,
            ),
            right: BorderSide(
              color: AppColors.primaryLight,
            ),
            bottom: BorderSide(
              color: AppColors.primaryLight,
            ),
          )),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                context.translate.sum,
                style: Topology.smallTitle,
              )),
              Expanded(
                  child: Text(
                formatter.format(quantity),
                textAlign: TextAlign.center,
              ))
            ],
          ),
        ),
      ],
    );
  }

  TableRow _tableRowForStore(double qny, String store, NumberFormat formatter) {
    return TableRow(
      // decoration: const BoxDecoration(
      //   color: Colors.grey,
      // ),
      children: <Widget>[
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              store,
              style: Topology.subTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatter.format(qny),
              style: Topology.subTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
