//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/widgets/dashed_line.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

class DottedDatePicker extends StatelessWidget {
  const DottedDatePicker({
    super.key,
    required this.selectedDate,
    required this.label,
  });

  final DateTime selectedDate;
  final String label;

  @override
  Widget build(BuildContext context) {
    final formatter = intl.DateFormat('dd/MM/yyyy');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(
              label,
              style: Topology.body.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const DashedLine(
                color: Colors.black,
              ),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(formatter.format(selectedDate)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
