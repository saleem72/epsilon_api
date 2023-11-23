//

import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/extensions/num_extension.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;
import 'package:epsilon_api/features/customer_account/customer_search/presentation/customer_search_bloc/customer_search_bloc.dart';
import 'package:epsilon_api/features/customer_account/customer_search/presentation/old_serach_bloc/old_serach_bloc.dart';
import 'package:epsilon_api/features/customer_account/customer_search/presentation/widgets/customer_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_decoration_image.dart';
import 'presentation/widgets/customer_search_bar.dart';
import 'presentation/widgets/customer_search_loading_view.dart';
import 'presentation/widgets/search_result_list.dart';

class CustomerSearch extends StatelessWidget {
  const CustomerSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerSearchBloc>(
          create: (_) => di.locator(),
        ),
        BlocProvider<OldSearchBloc>(
          create: (context) => di.locator(),
        ),
      ],
      child: const CustomerSearchContent(),
    );
  }
}

class CustomerSearchContent extends StatelessWidget {
  const CustomerSearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _mainContent(context),
          const CustomerSearchLoadingView(),
          const CustomerErrorView(),
        ],
      ),
    );
  }

  Column _mainContent(BuildContext context) {
    return Column(
      children: [
        AppNavBar(
          title: context.translate.customer_account_statement,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
          child: CustomerSearchBar(),
        ),
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              _decorationImage(),
              _decorationImage2(context),
              _content(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SearchResultList(
            onSubmit: (value) {
              context
                  .read<OldSearchBloc>()
                  .add(OldSearchEvent.searchTermHasChanged(searchTerm: value));
            },
            onRemoveItem: (value) => context
                .read<OldSearchBloc>()
                .add(OldSearchEvent.removeFromOldSearch(searchTerm: value)),
          ),
        ],
      ),
    );
  }

  Widget _decorationImage2(BuildContext context) {
    return Transform.translate(
      offset: Offset((MediaQuery.of(context).size.width / 2) + 90, 0),
      child: Transform.rotate(
        angle: -12.toRadians(),
        child: const AppDecorationImage(),
      ),
    );
  }

  Widget _decorationImage() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Transform.translate(
        offset: const Offset(-110, 0),
        child: const AppDecorationImage(),
      ),
    );
  }
}
