//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/finance_voucher_bloc/finance_voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessAddVoucherView extends StatelessWidget {
  const SuccessAddVoucherView({
    super.key,
    required this.onClose,
  });
  final Function onClose;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
      builder: (context, state) {
        return state.addedSuccessfully == null
            ? const SizedBox.shrink()
            : _content(context, state.addedSuccessfully!);
      },
    );
  }

  Container _content(BuildContext context, int number) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              margin: const EdgeInsets.only(
                  left: 16, right: 16, top: 54, bottom: 38),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${context.translate.add_voucher_success} ($number)',
                          style: Topology.largeTitle.copyWith(
                            color: AppColors.primaryDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  GradientButton(
                    label: context.translate.ok,
                    onPressed: () => onClose(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
