//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

import 'dashed_line.dart';
import 'dropdown_text_field.dart';

class DottedDropdownTextField extends StatelessWidget {
  const DottedDropdownTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.onSelection,
    required this.customers,
    required this.fullFilled,
  });
  final String label;
  final String hint;
  final Function(String) onSelection;
  final List<String> customers;
  final bool fullFilled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Topology.body.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 24,
          alignment: Alignment.center,
          child: Stack(
            children: [
              DashedLine(
                color: fullFilled ? Colors.black : Colors.red,
              ),
              DropdownTextField(
                hint: hint,
                onSelection: onSelection,
                customers: customers,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
