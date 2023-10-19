//

import 'package:epsilon_api/core/widgets/general_loading_view.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/finance_voucher_bloc/finance_voucher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceVoucherLoadingView extends StatelessWidget {
  const FinanceVoucherLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
      // buildWhen: (previous, current) => previous.failure != current.failure,
      builder: (context, state) {
        return state.isLoading
            ? const GeneralLoadingView()
            : const SizedBox.shrink();
      },
    );
  }
}
