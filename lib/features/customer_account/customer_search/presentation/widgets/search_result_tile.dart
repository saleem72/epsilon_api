//

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/customer.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.customer,
  });
  final Customer customer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.navigator.pushNamed(
        AppScreens.customerAccount,
        arguments: customer,
      ),
      child: SizedBox(
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
                customer.customerName,
                style: Topology.body.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
