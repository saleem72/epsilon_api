//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/domian/models/currency.dart';
import 'package:epsilon_api/core/domian/models/customer.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;
import 'package:epsilon_api/core/domian/models/account_balance.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/presnstaion/customer_account_bloc/customer_account_bloc.dart';
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
      create: (context) =>
          di.locator()..add(CustomerAccountEvent.getBalance(id: customer.id)),
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
          const CustomerAccountFailureView(),
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
                    child: BalanceListView(
                      list: state.balance.first.items ?? [],
                      currency: state.balance.first.currency,
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   // child: CurrencyListView(currency: state.),
                  //   child: Container(),
                  // ),
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
    required this.currency,
  });

  final Currency? currency;

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
          CurrencyTile(curreny: currency),
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

  final Currency? curreny;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            curreny?.code ?? '',
          ),
        ),
        Expanded(
          child: Text(
            curreny?.name ?? '',
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
    required this.currency,
  });

  final List<EntryModel> list;
  final Currency? currency;

  @override
  Widget build(BuildContext context) {
    final numberFormatter = intl.NumberFormat('#,##0.##');
    final normText = context.textTheme.bodyMedium;
    final boldText = context.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              final balance = list[index];
              return BalanceTile(balance: balance, currency: currency);
            },
          ),
        ),
        const SizedBox(height: 16),
        _tableInCard(context, boldText, normText, numberFormatter),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _tableInCard(BuildContext context, TextStyle? boldText,
      TextStyle? normText, intl.NumberFormat numberFormatter) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Card(
            child: _buildTable(context, boldText, normText, numberFormatter)),
      ),
    );
  }

  Widget _buildTable(BuildContext context, TextStyle? boldText,
      TextStyle? normText, intl.NumberFormat numberFormatter) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          decoration: const BoxDecoration(
            color: AppColors.primaryDark,
          ),
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: SizedBox(
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        context.translate.debit_total,
                        textAlign: TextAlign.center,
                        style: boldText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.translate.credit_total,
                    style: boldText,
                  ),
                ],
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.translate.balance_total,
                    style: boldText,
                  ),
                ],
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: SizedBox(
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: _allDebitValue(normText, numberFormatter),
                    ),
                  ],
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: SizedBox(
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: _allCreditValue(normText, numberFormatter),
                    ),
                  ],
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: SizedBox(
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: _allBalanceValue(normText, numberFormatter),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _allDebitValue(
      TextStyle? normText, intl.NumberFormat numberFormatter) {
    final value = list.fold<double>(
        0, (previousValue, element) => previousValue + (element.debit ?? 0));

    return value == 0
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currency?.name ?? '',
                style: normText,
              ),
              const SizedBox(width: 4),
              Text(
                numberFormatter.format(value),
                style: normText,
              )
            ],
          );
  }

  Widget _allCreditValue(
      TextStyle? normText, intl.NumberFormat numberFormatter) {
    final value = list.fold<double>(
        0, (previousValue, element) => previousValue + (element.credit ?? 0));

    return value == 0
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currency?.name ?? '',
                style: normText,
              ),
              const SizedBox(width: 4),
              Text(
                numberFormatter.format(value),
                style: normText,
              )
            ],
          );
  }

  Widget _allBalanceValue(
      TextStyle? normText, intl.NumberFormat numberFormatter) {
    final value = list.fold<double>(
        0, (previousValue, element) => previousValue + (element.credit ?? 0));

    return value == 0
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currency?.name ?? '',
                style: normText,
              ),
              const SizedBox(width: 4),
              Text(
                numberFormatter.format(value),
                style: normText,
              )
            ],
          );
  }
}

class BalanceTile extends StatelessWidget {
  const BalanceTile({
    super.key,
    required this.balance,
    required this.currency,
  });

  final EntryModel balance;
  final Currency? currency;

  @override
  Widget build(BuildContext context) {
    final numberFormatter = intl.NumberFormat('#,##0.##');
    final dateFormatter = intl.DateFormat('yyyy/M/d');
    final normText = context.textTheme.bodyMedium;
    final boldText = context.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(80),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
              ),
              children: <Widget>[
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          context.translate.number,
                          style: boldText,
                        ),
                      ),
                    ],
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.translate.debit,
                        style: boldText,
                      ),
                    ],
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.translate.credit,
                        style: boldText,
                      ),
                    ],
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.translate.balance,
                          style: boldText,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            balance.number ?? '',
                            style: normText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: _debitValue(normText, numberFormatter),
                        ),
                      ],
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: _creditValue(normText, numberFormatter),
                        ),
                      ],
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: _balanceValue(normText, numberFormatter),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        _originLine(context, boldText, dateFormatter),
        _notesLine(context, boldText),
      ],
    );
  }

  Widget _debitValue(TextStyle? normText, intl.NumberFormat numberFormatter) {
    final value = numberFormatter.format(balance.debit);

    return value == '0'
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currency?.name ?? '',
                style: normText,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: normText,
              )
            ],
          );
  }

  Widget _balanceValue(TextStyle? normText, intl.NumberFormat numberFormatter) {
    final value = numberFormatter.format(balance.balance);

    return value == '0'
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currency?.name ?? '',
                style: normText,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: normText,
              )
            ],
          );
  }

  Widget _creditValue(TextStyle? normText, intl.NumberFormat numberFormatter) {
    final value = numberFormatter.format(balance.credit);

    return value == '0'
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currency?.name ?? '',
                style: normText,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: normText,
              )
            ],
          );
  }

  Widget _notesLine(BuildContext context, TextStyle? boldText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
          left: BorderSide(),
          right: BorderSide(),
        ),
      ),
      child: Row(
        children: [
          Text(
            context.translate.bill_notes,
            style: boldText,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(balance.notes ?? ''),
          ),
        ],
      ),
    );
  }

  Widget _originLine(BuildContext context, TextStyle? boldText,
      intl.DateFormat dateFormatter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
          left: BorderSide(),
          right: BorderSide(),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  context.translate.origin,
                  style: boldText,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    balance.itName ?? '',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  context.translate.date,
                  style: boldText,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(balance.date == null
                      ? ''
                      : dateFormatter.format(balance.date!)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
