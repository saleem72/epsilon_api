//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {super.key,
      this.isEnabled = true,
      required this.label,
      required this.onPressed,
      this.width = 150,
      this.secondLabel});
  final String label;
  final String? secondLabel;
  final Function onPressed;
  final bool isEnabled;
  final double width;
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
        width: width,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Row(
                  mainAxisAlignment: secondLabel == null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: Topology.smallTitle.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (secondLabel != null)
                      Text(
                        secondLabel!,
                        style: Topology.smallTitle.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
