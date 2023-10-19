//

import 'package:flutter/material.dart';

class VoucherSelectionFailureView extends StatelessWidget {
  const VoucherSelectionFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
    //   // buildWhen: (previous, current) => previous.failure != current.failure,
    //   builder: (context, state) {
    //     return state.failure == null
    //         ? const SizedBox.shrink()
    //         : GeneralErrorView(
    //             onAction: () => context
    //                 .read<FinanceVoucherBloc>()
    //                 .add(FinanceVoucherClearFailureEvent()),
    //             failure: state.failure,
    //           );
    //   },
    // );
    return const SizedBox.shrink();
  }
}
