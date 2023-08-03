//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class InvoiceSearchClientPicker extends StatefulWidget {
  const InvoiceSearchClientPicker({
    super.key,
    required this.onChange,
  });
  final Function(String) onChange;
  @override
  State<InvoiceSearchClientPicker> createState() =>
      _InvoiceSearchClientPickerState();
}

class _InvoiceSearchClientPickerState extends State<InvoiceSearchClientPicker> {
  String? _value;
  final List<String> names = ["Jhon", "Jack", "Michel"];
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
          context.translate.invoice_client,
          style: Topology.subTitle,
        ),
        const SizedBox(height: 10),
        _moreMenu(context),
      ],
    );
  }

  PopupMenuButton<String> _moreMenu(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: MediaQuery.of(context).size.width - 32,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      offset: Offset(0, itemHeight + 8),
      onSelected: (item) {
        setState(() {
          _value = item;
          widget.onChange(item);
        });
      }, // => _actionForMenuItem(context, item: item),
      itemBuilder: (context) => names
          .map((e) => PopupMenuItem(
              value: e,
              child: ClientPopupMenuItemCard(
                title: e,
                isActive: e == _value,
              )))
          .toList(),
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
              image: AssetImage(AppIcons.client),
              height: 30,
              width: 25.61,
            ),
            const SizedBox(width: 8),
            _value == null
                ? IgnorePointer(
                    child: Row(
                      children: [
                        Text(
                          context.translate.invoice_client_hint,
                          style: Topology.subTitle.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        _value ?? '',
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

class ClientPopupMenuItemCard extends StatelessWidget {
  const ClientPopupMenuItemCard({
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
