//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/domian/models/customer.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/features/customer_account/customer_search/presentation/customer_search_bloc/customer_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../old_serach_bloc/old_serach_bloc.dart';
import 'old_search_tile.dart';
import 'search_result_tile.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    super.key,
    required this.onSubmit,
    required this.onRemoveItem,
  }); //
  final Function(String) onSubmit;
  final Function(String) onRemoveItem;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerSearchBloc, CustomerSearchState>(
      builder: (context, state) {
        return state is CustomerSearchSuccess
            ? _buildList(context, state.customers)
            : Expanded(child: _oldSearch(context));
      },
    );
  }

  Widget _oldSearch(BuildContext context) {
    return BlocBuilder<OldSearchBloc, OldSearchState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.translate.old_research,
                ),
                TextButton(
                  onPressed: () => context
                      .read<OldSearchBloc>()
                      .add(OldSearchEvent.clearOldSearch()),
                  child: Text(context.translate.clear_all),
                ),
              ],
            ),
            state.oldSearch.isEmpty
                ? const SizedBox.shrink()
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.oldSearch.length,
                      itemBuilder: (BuildContext context, int index) {
                        final str = state.oldSearch[index];
                        return GestureDetector(
                          onTap: () => onSubmit(str),
                          child: OldSearchTile(
                            onClear: () => onRemoveItem(str),
                            name: str,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<Customer> customers) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.translate.results),
          const SizedBox(height: 8),
          if (customers.isEmpty)
            Expanded(
              child: _buildEmptyResult(context),
            ),
          if (customers.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: customers.length,
                itemBuilder: (BuildContext context, int index) {
                  final customer = customers[index];
                  return SearchResultTile(customer: customer);
                },
              ),
            ),
        ],
      ),
    );
  }

  Column _buildEmptyResult(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8), //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.translate.no_search_results,
              style: Topology.largeTitle.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(child: _oldSearch(context)),
      ],
    );
  }
}
