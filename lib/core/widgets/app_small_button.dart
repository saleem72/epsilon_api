//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class AppSmallButton extends StatelessWidget {
  const AppSmallButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isEnabled,
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
        padding: EdgeInsets.zero,
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isEnabled ? 1 : 0.6,
        child: Container(
          // padding: const EdgeInsets.only(top: 8, bottom: 16),
          height: 44,
          decoration: const BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          alignment: Alignment.center,
          child: Center(
              child: Text(
            label,
            style: Topology.smallTitle.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          )),
        ),
      ),
    );
  }
}
