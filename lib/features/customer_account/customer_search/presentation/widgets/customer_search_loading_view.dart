//

import 'package:epsilon_api/features/customer_account/customer_search/presentation/customer_search_bloc/customer_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerSearchLoadingView extends StatelessWidget {
  const CustomerSearchLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerSearchBloc, CustomerSearchState>(
      builder: (context, state) {
        return state is CustomerSearchLoading
            ? const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
