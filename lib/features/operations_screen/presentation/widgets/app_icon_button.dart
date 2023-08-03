//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.label,
    required this.icon,
    this.errorMessage,
    required this.onPressed,
    this.iconSize = 30,
  });

  final String label;
  final String icon;
  final String? errorMessage;
  final Function() onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
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
                Text(
                  label,
                  style: Topology.subTitle.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
