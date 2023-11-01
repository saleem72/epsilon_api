//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashed_line.dart';

class AppTextFieldWithLabel extends StatelessWidget {
  const AppTextFieldWithLabel({
    super.key,
    this.onChanged,
    required this.hint,
    required this.label,
    this.isValid = true,
    this.inputFormatters,
    this.keyboardType,
    this.controller,
  });
  final Function(String)? onChanged;
  final String hint;
  final String label;
  final bool isValid;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

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
          isValid: isValid,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
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
    required this.isValid,
    required this.inputFormatters,
    required this.keyboardType,
    this.controller,
  });
  final Function(String)? onChanged;
  final String hint;
  final bool isValid;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DashedLine(
            color: isValid ? Colors.black : Colors.red,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              Expanded(
                child: TextField(
                  controller: controller,
                  style: Topology.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                  onChanged: onChanged,
                  inputFormatters: inputFormatters,
                  keyboardType: keyboardType,
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
