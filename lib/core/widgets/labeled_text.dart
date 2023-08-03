//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  const LabeledText({
    super.key,
    required this.text,
    required this.label,
    required this.icon,
    this.errorMessage,
    this.iconSize = 30,
  });
  final String text;
  final String label;
  final String icon;
  final String? errorMessage;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Topology.subTitle,
        ),
        const SizedBox(height: 10),
        Container(
            height: 58,
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
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(icon),
                    height: iconSize,
                    width: iconSize,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      text,
                      style: Topology.subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
