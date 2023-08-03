//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceSearchDatePicker extends StatefulWidget {
  const InvoiceSearchDatePicker({
    super.key,
    required this.onChange,
  });
  final Function(DateTime) onChange;
  @override
  State<InvoiceSearchDatePicker> createState() =>
      _InvoiceSearchDatePickerState();
}

class _InvoiceSearchDatePickerState extends State<InvoiceSearchDatePicker> {
  DateTime _selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy/MM/dd');
  final double itemHeight = 58;

  @override
  Widget build(BuildContext context) {
    return _client(context);
  }

  Widget _client(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate.invoice_date,
          style: Topology.subTitle,
        ),
        const SizedBox(height: 10),
        _moreMenu(context),
      ],
    );
  }

  Widget _moreMenu(BuildContext context) {
    return AppDatePicker(
      restorationId: "InvoiceSearchDatePicker",
      onChange: (date) {
        setState(() {
          _selectedDate = date;
          widget.onChange(date);
        });
      },
      child: _clientPicker(context),
    );
  }

  Widget _clientPicker(BuildContext context) {
    const double itemHeight = 58;
    return Container(
      height: itemHeight,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.neutral95,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0, -0.5),
            spreadRadius: 0.5,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 1),
            spreadRadius: 0.5,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Image(
              image: AssetImage(AppIcons.calender),
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                Text(
                  formatter.format(_selectedDate),
                  style: Topology.subTitle.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
                // const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DatePopupMenuItemCard extends StatelessWidget {
  const DatePopupMenuItemCard({
    Key? key,
    required this.title,
    required this.isActive,
  }) : super(key: key);
  final String title;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            AppIcons.company,
            height: 26,
            width: 26,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
          isActive
              ? Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.check,
                    size: 18,
                    color: AppColors.green,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
