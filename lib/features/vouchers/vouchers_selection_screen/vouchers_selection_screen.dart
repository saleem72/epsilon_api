//

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/features/operations_screen/presentation/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';

class VouchersSelectionScreen extends StatelessWidget {
  const VouchersSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavBar(title: context.translate.voucher_selection),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppIconButton(
                  label: context.translate.recipient_voucher,
                  icon: AppIcons.recipientVoucher,
                  onPressed: () =>
                      context.navigator.pushNamed(AppScreens.recipientVoucher),
                ),
                const SizedBox(height: 16),
                AppIconButton(
                  label: context.translate.payment_voucher,
                  icon: AppIcons.paymentVoucher,
                  onPressed: () =>
                      context.navigator.pushNamed(AppScreens.paymentVoucher),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
