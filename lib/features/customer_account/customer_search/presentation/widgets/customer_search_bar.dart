//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/features/customer_account/customer_search/presentation/customer_search_bloc/customer_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../old_serach_bloc/old_serach_bloc.dart';

class CustomerSearchBar extends StatefulWidget {
  const CustomerSearchBar({
    super.key,
  });
  @override
  State<CustomerSearchBar> createState() => _CustomerSearchBarState();
}

class _CustomerSearchBarState extends State<CustomerSearchBar> {
  final TextEditingController _searchTerm = TextEditingController();

  @override
  void dispose() {
    _searchTerm.dispose();
    super.dispose();
  }

  void _searchTermHasChanged(BuildContext context, String? term) {
    if (term != null) {
      _searchTerm.text = term;
      context
          .read<CustomerSearchBloc>()
          .add(CustomerSearchEvent.searchByName(searchTerm: _searchTerm.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OldSearchBloc, OldSearchState>(
      listenWhen: (previous, current) =>
          previous.searchTerm != current.searchTerm,
      listener: (context, state) {
        _searchTermHasChanged(context, state.searchTerm);
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.primaryDark.withOpacity(0.49),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.read<OldSearchBloc>().add(
                    OldSearchEvent.searchTermHasChanged(
                        searchTerm: _searchTerm.text));

                context.read<CustomerSearchBloc>().add(
                    CustomerSearchEvent.searchByName(
                        searchTerm: _searchTerm.text));
              },
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  AppIcons.search,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchTerm,
                style: Topology.smallTitle.copyWith(
                  color: AppColors.primaryDark,
                ),
                onSubmitted: (value) {
                  context.read<OldSearchBloc>().add(
                      OldSearchEvent.searchTermHasChanged(
                          searchTerm: _searchTerm.text));
                  context.read<CustomerSearchBloc>().add(
                      CustomerSearchEvent.searchByName(
                          searchTerm: _searchTerm.text));
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: context.translate.search,
                  hintStyle: Topology.smallTitle.copyWith(
                    color: AppColors.secondary,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
