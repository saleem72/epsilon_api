//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
  });

  final String title;
  final bool showBackButton;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 1.5,
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              onPressed: () => context.navigator.pop(),
              icon: RotatedBox(
                quarterTurns:
                    context.directionality == TextDirection.ltr ? 0 : -2,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          if (actions != null && actions!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [...actions!],
            ),
          Expanded(
            child: Text(
              title,
              style: Topology.smallTitle.copyWith(color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
