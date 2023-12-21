//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';
import 'package:epsilon_api/core/domian/models/searched_invoice.dart';
import 'package:epsilon_api/core/widgets/app_date_picker.dart';
import 'package:epsilon_api/core/widgets/app_dropdown_button.dart';
import 'package:epsilon_api/core/widgets/dotted_dropdown_text_field.dart';
import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:epsilon_api/features/invoices/new_invoice/presentation/widgets/triangle_icon.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;
import 'package:epsilon_api/features/invoices/invoices_movement/presentation/invoices_movement_bloc/invoices_movement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../invoices_movement/invoices_movement_widgets.dart';

class InvoicesMovementScreen extends StatelessWidget {
  const InvoicesMovementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<InvoicesMovementBloc>()
        ..add(InvoicesMovementFetchDataEvent()),
      child: const InvoicesMovementScreenContent(),
    );
  }
}

class InvoicesMovementScreenContent extends StatefulWidget {
  const InvoicesMovementScreenContent({super.key});

  @override
  State<InvoicesMovementScreenContent> createState() =>
      _InvoicesMovementScreenContentState();
}

class _InvoicesMovementScreenContentState
    extends State<InvoicesMovementScreenContent> {
  final TextEditingController _customer = TextEditingController();

  @override
  void dispose() {
    _customer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoicesMovementBloc, InvoicesMovementState>(
      builder: (_, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            _mainScaffold(context, state),
            _buildFailure(context, state),
            InvoicesMovementLoadingView(isLoading: state.isLoading),
          ],
        );
      },
    );
  }

  Widget _buildFailure(BuildContext context, InvoicesMovementState state) {
    return state.failure == null
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

  Scaffold _mainScaffold(BuildContext context, InvoicesMovementState state) {
    return Scaffold(
      body: Column(
        children: [
          AppNavBar(title: context.translate.operation_invoices_totals),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _invoiceType(context, state),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _startDatePicker(context, state.startDate),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _endDatePicker(context, state.endDate),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _customerSelector(context, state),
                    const SizedBox(height: 24),
                    _searchForInvoicesButton(context, state.isReady),
                    const SizedBox(height: 24),
                    _buildInvoicesList(context, state.invoices),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppDropdownButton _invoiceType(
      BuildContext context, InvoicesMovementState state) {
    return AppDropdownButton(
      label: context.translate.invoice_type,
      fullFilled: state.selectedType != null,
      dropdownButton: _invoiceTypeDropdown(state, context),
    );
  }

  Widget _startDatePicker(BuildContext context, DateTime selectedDate) {
    return AppDatePicker(
      restorationId: "StartDateInvoicesMovementScreen",
      onChange: (date) {
        context
            .read<InvoicesMovementBloc>()
            .add(InvoicesMovementStartDateChangedEvent(date: date));
        // setState(() {
        //   _selectedDate = date;
        // });
      },
      child: DottedDatePicker(
        selectedDate: selectedDate,
        label: context.translate.start_date,
      ),
    );
  }

  Widget _endDatePicker(BuildContext context, DateTime selectedDate) {
    return AppDatePicker(
      restorationId: "EndDateInvoicesMovementScreen",
      onChange: (date) {
        context
            .read<InvoicesMovementBloc>()
            .add(InvoicesMovementEndDateChangedEvent(date: date));
        // setState(() {
        //   _selectedDate = date;
        // });
      },
      child: DottedDatePicker(
        selectedDate: selectedDate,
        label: context.translate.end_date,
      ),
    );
  }

  DropdownButton<InvoiceType> _invoiceTypeDropdown(
      InvoicesMovementState state, BuildContext context) {
    return DropdownButton<InvoiceType>(
      value: state.selectedType,
      isExpanded: true,
      icon: const TriangleIcon(),
      elevation: 16,
      style: Topology.body.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      onChanged: (InvoiceType? value) {
        if (value != null) {
          context
              .read<InvoicesMovementBloc>()
              .add(InvoicesMovementTypeChangedEvent(type: value));
        }
      },
      items: state.invoiceTypes.map<DropdownMenuItem<InvoiceType>>((value) {
        return DropdownMenuItem<InvoiceType>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  DottedDropdownTextField _customerSelector(
      BuildContext context, InvoicesMovementState state) {
    return DottedDropdownTextField(
      label: context.translate.agent,
      hint: context.translate.agent,
      controller: _customer,
      options: state.customers.map((e) => e.customerName).toList(),
      onSelection: (customer) {
        context.read<InvoicesMovementBloc>().add(
            InvoicesMovementSelectedCustomerChangedEvent(customer: customer));
      },
      fullFilled: state.selectedCustomer != null,
    );
  }

  Widget _searchForInvoicesButton(BuildContext context, bool isReady) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientButton(
          width: context.mediaQuery.size.width - 64,
          label: context.translate.search,
          isEnabled: isReady,
          onPressed: () {
            context
                .read<InvoicesMovementBloc>()
                .add(InvoicesMovementSearchInvoicesEvent());
          },
        ),
      ],
    );
  }

  Widget _buildInvoicesList(
      BuildContext context, List<SearchedInvoice> invoices) {
    // return ListView.builder(
    //   itemCount: invoices.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     final invoice = invoices[index];
    //     return SearchedInvoiceTile(balance: invoice);
    //   },
    // );
    return Column(
      children: [
        ...invoices.map((e) => SearchedInvoiceTile(balance: e)),
      ],
    );
  }
}
