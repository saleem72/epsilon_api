//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/domian/models/currency.dart';
import 'package:epsilon_api/core/domian/models/payment_method.dart';
import 'package:epsilon_api/core/domian/models/voucher_type.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_date_picker.dart';
import 'package:epsilon_api/core/widgets/app_dropdown_button.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/dotted_dropdown_text_field.dart';
import 'package:epsilon_api/core/widgets/dotted_text_field.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;
import 'package:epsilon_api/features/invoices/new_invoice/invoice_widgets.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/finance_voucher_bloc/finance_voucher_bloc.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/widgets/finance_voucher_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/widgets/finance_voucher_failure_view.dart';
import 'presentation/widgets/success_add_voucher_view.dart';

class FinanceVoucherScreen extends StatelessWidget {
  const FinanceVoucherScreen({
    super.key,
    required this.voucherType,
  });
  final VoucherCategory voucherType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<FinanceVoucherBloc>()
        ..add(FinanceVoucherFetchDataEvent(voucherType: voucherType)),
      child: FinanceVoucherScreenContent(voucherType: voucherType),
    );
  }
}

class FinanceVoucherScreenContent extends StatefulWidget {
  const FinanceVoucherScreenContent({
    super.key,
    required this.voucherType,
  });
  final VoucherCategory voucherType;

  @override
  State<FinanceVoucherScreenContent> createState() =>
      _FinanceVoucherScreenContentState();
}

class _FinanceVoucherScreenContentState
    extends State<FinanceVoucherScreenContent> {
  // PaymentMethod method = PaymentMethod.chash;
  final TextEditingController _customer = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  @override
  void dispose() {
    _customer.dispose();
    _amount.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _mainScaffold(),
        const FinanceVoucherFailureView(),
        const FinanceVoucherLoadingView(),
      ],
    );
  }

  _showSuccessMessage() {
    _customer.clear();
    _amount.clear();
    _notes.clear();
  }

  Scaffold _mainScaffold() {
    return Scaffold(
      body: BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
        builder: (context, state) {
          return Stack(
            children: [
              _mainContent(context, state),
              SuccessAddVoucherView(
                onClose: () {
                  _showSuccessMessage();
                  return context
                      .read<FinanceVoucherBloc>()
                      .add(FinanceVoucherClearSuccessEvent());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Column _mainContent(BuildContext context, FinanceVoucherState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNavBar(
          title: widget.voucherType == VoucherCategory.recipient
              ? context.translate.recipient_voucher
              : context.translate.payment_voucher,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _datePicker(
                        context,
                        state.selectedDate,
                      ),
                    ),
                    Expanded(
                        child: _voucherTypesButton(
                      context,
                      state.availableTypes,
                      state.selectedType,
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      DottedDropdownTextField(
                        label: context.translate.recived_from,
                        hint: context.translate.recipient,
                        controller: _customer,
                        options:
                            state.customers.map((e) => e.customerName).toList(),
                        onSelection: (customer) {
                          context.read<FinanceVoucherBloc>().add(
                              FinanceVoucherSelectedCustomerChangedEvent(
                                  customer: customer));
                        },
                        fullFilled: state.selectedCustomer != null,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppTextFieldWithLabel(
                              controller: _amount,
                              label: context.translate.chach_amount,
                              hint: context.translate.amount,
                              isValid: state.amount > 0,
                              inputFormatters: [
                                // CurrencyInputFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?\.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (p0) => context
                                  .read<FinanceVoucherBloc>()
                                  .add(FinanceVoucherAmountChangedEvent(
                                      amount: p0)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: _dropdownButton(
                              context,
                              state.currencies,
                              state.selectedCurrency,
                            ),
                          ),
                        ],
                      ),
                      if (state.method == PaymentMethod.cheque)
                        const SizedBox(height: 32),
                      if (state.method == PaymentMethod.cheque)
                        AppTextFieldWithLabel(
                          label: context.translate.cheque_num,
                          hint: context.translate.cheque_num,
                          onChanged: (p0) {},
                        ),
                      const SizedBox(height: 32),
                      AppTextFieldWithLabel(
                        label: context.translate.in_return,
                        hint: context.translate.notes,
                        controller: _notes,
                        onChanged: (p0) =>
                            context.read<FinanceVoucherBloc>().add(
                                  FinanceVoucherNotesChangedEvent(
                                    value: p0,
                                  ),
                                ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientButton(
                            label: context.translate.save,
                            isEnabled: state.isValid,
                            onPressed: () => context
                                .read<FinanceVoucherBloc>()
                                .add(FinanceVoucherCreateVoucherEvent()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding _datePicker(BuildContext context, DateTime selectedDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AppDatePicker(
        restorationId: "RecipientVoucherScreen",
        onChange: (date) {
          context
              .read<FinanceVoucherBloc>()
              .add(FinanceVoucherDateChangedEvent(date: date));
        },
        child: DatePickerBubble(selectedDate: selectedDate),
      ),
    );
  }

  Widget _dropdownButton(
      BuildContext context, List<Currency> list, Currency? selectedCurrency) {
    return AppDropdownButton(
      fullFilled: selectedCurrency != null,
      dropdownButton: _currencyDrop(selectedCurrency, context, list),
      label: context.translate.currency,
    );
  }

  DropdownButton<Currency> _currencyDrop(
      Currency? selectedCurrency, BuildContext context, List<Currency> list) {
    return DropdownButton<Currency>(
      value: selectedCurrency,
      isExpanded: true,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: AppColors.primaryDark,
        size: 32,
      ),
      elevation: 16,
      style: Topology.body.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      onChanged: (Currency? value) {
        if (value != null) {
          context
              .read<FinanceVoucherBloc>()
              .add(FinanceVoucherCurrencyChangedEvent(currency: value));
        }
      },
      items: list.map<DropdownMenuItem<Currency>>((value) {
        return DropdownMenuItem<Currency>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  Widget _voucherTypesButton(
      BuildContext context, List<VoucherType> list, VoucherType? selectedType) {
    return AppDropdownButton(
      fullFilled: selectedType != null,
      dropdownButton: _voucherTypesDrop(selectedType, context, list),
      label: context.translate.voucher_type,
    );
  }

  DropdownButton<VoucherType> _voucherTypesDrop(
      VoucherType? selectedType, BuildContext context, List<VoucherType> list) {
    return DropdownButton<VoucherType>(
      value: selectedType,
      isExpanded: true,
      icon: const TriangleIcon(),
      elevation: 16,
      style: Topology.body.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      onChanged: (VoucherType? value) {
        if (value != null) {
          context
              .read<FinanceVoucherBloc>()
              .add(FinanceVoucherTypeChangedEvent(voucherType: value));
        }
      },
      items: list.map<DropdownMenuItem<VoucherType>>((value) {
        return DropdownMenuItem<VoucherType>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
