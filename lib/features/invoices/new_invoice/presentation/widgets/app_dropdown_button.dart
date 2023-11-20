//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/widgets/dashed_line.dart';
import 'package:flutter/material.dart';

class AppDropdownButton extends StatelessWidget {
  const AppDropdownButton({
    super.key,
    required this.fullFilled,
    required this.dropdownButton,
    required this.label,
  });
  final String label;
  final bool fullFilled;
  final DropdownButton dropdownButton;
  @override
  Widget build(BuildContext context) {
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
              DashedLine(
                color: fullFilled ? Colors.black : Colors.red,
              ),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: dropdownButton,
                    ),
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
