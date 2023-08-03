//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

import 'dashed_line.dart';

class AppTextFieldWithLabel extends StatelessWidget {
  const AppTextFieldWithLabel({
    super.key,
    this.onChanged,
    required this.hint,
    required this.label,
  });
  final Function(String)? onChanged;
  final String hint;
  final String label;

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
        const SizedBox(height: 8),
        DottedTextField(
          hint: hint,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class DottedTextField extends StatelessWidget {
  const DottedTextField({
    super.key,
    this.onChanged,
    required this.hint,
  });
  final Function(String)? onChanged;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DashedLine(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              Expanded(
                child: TextField(
                  style: Topology.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: Topology.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                    isCollapsed: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
