//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.isEnabled = true,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final Function onPressed;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => isEnabled ? onPressed() : null,
      style: TextButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      ),
      child: SizedBox(
        height: 60,
        width: 150,
        child: Stack(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isEnabled ? 1 : 0.6,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.buttonGradient,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: Topology.smallTitle.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                ),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
