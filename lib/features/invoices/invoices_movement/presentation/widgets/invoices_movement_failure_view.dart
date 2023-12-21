//

import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/features/invoices/Invoices_movement/presentation/invoices_movement_bloc/invoices_movement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoicesMovementFailureView extends StatelessWidget {
  const InvoicesMovementFailureView({
    super.key,
    required this.failure,
  });
  final Failure? failure;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoicesMovementBloc, InvoicesMovementState>(
      builder: (context, state) {
        return _buildFailure(context, state);
      },
    );
  }

  Widget _buildFailure(BuildContext context, InvoicesMovementState state) {
    return failure == null
        ? const SizedBox.shrink()
        : GeneralErrorView(
            onAction: () {
              context
                  .read<InvoicesMovementBloc>()
                  .add(InvoicesMovementClearFailureEvent());
            },
            failure: state.failure,
          );
  }
}
