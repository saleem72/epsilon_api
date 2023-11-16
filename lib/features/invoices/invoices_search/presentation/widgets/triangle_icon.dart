//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:flutter/material.dart';

class TriangleIcon extends StatelessWidget {
  const TriangleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.arrow_drop_down,
      color: AppColors.primaryDark,
      size: 32,
    );
  }
}
