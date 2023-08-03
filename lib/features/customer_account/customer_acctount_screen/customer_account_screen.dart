//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/presnstaion/customer_account_bloc/customer_account_bloc.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import '../../../core/widgets/app_nav_bar.dart';

class CustomerAccountScreen extends StatelessWidget {
  const CustomerAccountScreen({
    super.key,
    required this.customer,
  });
  final Customer customer;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerAccountBloc>(
      create: (context) => di.locator()
        ..add(CustomerAccountEvent.getBalance(guid: customer.guid)),
      child: CustomerAccountContent(
        customer: customer,
      ),
    );
  }
}

class CustomerAccountContent extends StatelessWidget {
  const CustomerAccountContent({super.key, required this.customer});
  final Customer customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _content(context),
          const CustomerAccountLoadingView(),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        AppNavBar(
          title: context.translate.customer_account_statement,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _customerInfo(),
                const Expanded(
                  child: CustomerAccountSuccessView(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _customerInfo() {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Image.asset(
            AppIcons.userImage,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              customer.customerName,
              style: Topology.body.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerAccountLoadingView extends StatelessWidget {
  const CustomerAccountLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerAccountBloc, CustomerAccountState>(
      builder: (context, state) {
        return state is CustomerAccountLoading
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

class CustomerAccountFailureView extends StatelessWidget {
  const CustomerAccountFailureView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerAccountBloc, CustomerAccountState>(
      builder: (context, state) {
        return state is CustomerAccountFailure
            ? Center(
                child: Text(state.failure.message ?? 'Unkown Error'),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

class CustomerAccountSuccessView extends StatelessWidget {
  const CustomerAccountSuccessView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerAccountBloc, CustomerAccountState>(
      builder: (context, state) {
        return state is CustomerAccountSuccess
            ? Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: BalanceListView(list: state.balance.balance ?? []),
                  ),
                  Expanded(
                    flex: 1,
                    child: CurrencyListView(list: state.balance.currency ?? []),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}

class CurrencyListView extends StatelessWidget {
  const CurrencyListView({
    super.key,
    required this.list,
  });

  final List<Currency> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Code',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Name',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                final curreny = list[index];
                return CurrencyTile(curreny: curreny);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({
    super.key,
    required this.curreny,
  });

  final Currency curreny;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            curreny.code ?? '',
          ),
        ),
        Expanded(
          child: Text(
            curreny.name ?? '',
          ),
        ),
      ],
    );
  }
}

class BalanceListView extends StatelessWidget {
  const BalanceListView({
    super.key,
    required this.list,
  });

  final List<Balance> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Customer',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Balance',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Checked',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                final balance = list[index];
                return BalanceTile(balance: balance);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceTile extends StatelessWidget {
  const BalanceTile({
    super.key,
    required this.balance,
  });

  final Balance balance;

  @override
  Widget build(BuildContext context) {
    final numberFormatter = intl.NumberFormat('#,##0.##');
    final dateFormatter = intl.DateFormat('yyyy/M/d');
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            balance.cuName ?? '',
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            numberFormatter.format(balance.balance ?? 0),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            balance.lastCheckDate == null
                ? ''
                : dateFormatter.format(balance.lastCheckDate!),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
