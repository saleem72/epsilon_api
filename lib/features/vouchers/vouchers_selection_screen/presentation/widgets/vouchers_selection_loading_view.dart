//

import 'package:flutter/material.dart';

class VoucherSelectionLoadingView extends StatelessWidget {
  const VoucherSelectionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
    //   // buildWhen: (previous, current) => previous.failure != current.failure,
    //   builder: (context, state) {
    //     return state.isLoading
    //         ? const GeneralLoadingView()
    //         : const SizedBox.shrink();
    //   },
    // );
    return const SizedBox.shrink();
  }
}
