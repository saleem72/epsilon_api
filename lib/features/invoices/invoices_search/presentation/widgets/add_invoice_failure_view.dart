//

import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/features/invoices/invoices_search/presentation/invoice_bloc/invoice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddInvoiceFailureView extends StatelessWidget {
  const AddInvoiceFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      // buildWhen: (previous, current) => previous.failure != current.failure,
      builder: (context, state) {
        return state.failure == null
            ? const SizedBox.shrink()
            : GeneralErrorView(
                onAction: () =>
                    context.read<InvoiceBloc>().add(InvoiceClearFailureEvent()),
                failure: state.failure,
              );
      },
    );
  }
}
