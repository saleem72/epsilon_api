//

import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/features/customer_account/customer_search/presentation/customer_search_bloc/customer_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerErrorView extends StatelessWidget {
  const CustomerErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerSearchBloc, CustomerSearchState>(
      builder: (context, state) {
        if (state is CustomerSearchFailureState) {
          return GeneralErrorView(
            onAction: () => context
                .read<CustomerSearchBloc>()
                .add(CustomerSearchEvent.clearError()),
            failure: state.failure,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
