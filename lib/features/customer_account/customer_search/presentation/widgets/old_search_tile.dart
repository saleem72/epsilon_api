//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class OldSearchTile extends StatelessWidget {
  const OldSearchTile({
    super.key,
    required this.name,
    required this.onClear,
  });
  final String name;
  final Function onClear;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Image.asset(
            AppIcons.userImage,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              name,
              style: Topology.body.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ),
          IconButton(
            onPressed: () => onClear(),
            icon: const Icon(
              Icons.close,
              size: 16,
              color: AppColors.primaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
