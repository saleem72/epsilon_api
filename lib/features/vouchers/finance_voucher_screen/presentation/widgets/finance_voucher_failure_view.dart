//

import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/finance_voucher_bloc/finance_voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceVoucherFailureView extends StatelessWidget {
  const FinanceVoucherFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
      // buildWhen: (previous, current) => previous.failure != current.failure,
      builder: (context, state) {
        return state.failure == null
            ? const SizedBox.shrink()
            : GeneralErrorView(
                onAction: () => context
                    .read<FinanceVoucherBloc>()
                    .add(FinanceVoucherClearFailureEvent()),
                failure: state.failure,
              );
      },
    );
  }
}
