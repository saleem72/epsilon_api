//

import 'package:epsilon_api/core/widgets/general_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../invoice_bloc/invoice_bloc.dart';

class AddInvoiceLoadingView extends StatelessWidget {
  const AddInvoiceLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      // buildWhen: (previous, current) => previous.failure != current.failure,
      builder: (context, state) {
        return state.isLoading
            ? const GeneralLoadingView()
            : const SizedBox.shrink();
      },
    );
  }
}
