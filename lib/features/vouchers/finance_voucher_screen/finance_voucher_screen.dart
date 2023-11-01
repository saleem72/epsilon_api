//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/domian/models/currency.dart';
import 'package:epsilon_api/core/domian/models/payment_method.dart';
import 'package:epsilon_api/core/domian/models/voucher_type.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_date_picker.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/dashed_line.dart';
import 'package:epsilon_api/core/widgets/dotted_dropdown_text_field.dart';
import 'package:epsilon_api/core/widgets/dotted_text_field.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;
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
  final VoucherType voucherType;

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
  final VoucherType voucherType;

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
        _content(),
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

  Scaffold _content() {
    return Scaffold(
      body: BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
        // listenWhen: (previous, current) =>
        //     current.addedSuccessfully != previous.addedSuccessfully,
        // listener: (context, state) {
        //   if (state.addedSuccessfully) {
        //     _showSuccessMessage();
        //   }
        // },
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
          title: widget.voucherType == VoucherType.recipient
              ? context.translate.recipient_voucher
              : context.translate.payment_voucher,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _datePicker(context, state.selectedDate),
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
                        customers:
                            state.customers.map((e) => e.customerName).toList(),
                        onSelection: (customer) {
                          context.read<FinanceVoucherBloc>().add(
                              FinanceVoucherSelectedCustomerChangedEvent(
                                  customer: customer));
                        },
                        fullFilled: state.selectedCustomer != null,
                      ),
                      // const SizedBox(height: 32),
                      // PaymentMethodSelector(
                      //   onChange: (value) {
                      //     context.read<FinanceVoucherBloc>().add(
                      //         FinanceVoucherPaymentChangedEvent(method: value));
                      //     // setState(() {
                      //     //   method = value;
                      //     // });
                      //   },
                      // ),
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
                        onChanged: (p0) {},
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
          // setState(() {
          //   _selectedDate = date;
          // });
        },
        child: DatePickerBubble(selectedDate: selectedDate),
      ),
    );
  }

  Widget _dropdownButton(
      BuildContext context, List<Currency> list, Currency? selectedCurrency) {
    // const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    // Currency? dropdownValue = list.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(
              context.translate.currency,
              style: Topology.body.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              DashedLine(
                color: selectedCurrency == null ? Colors.red : Colors.black,
              ),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Currency>(
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
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (Currency? value) {
                          // This is called when the user selects an item.
                          // setState(() {
                          //   dropdownValue = value!;
                          // });
                          if (value != null) {
                            context.read<FinanceVoucherBloc>().add(
                                FinanceVoucherCurrencyChangedEvent(
                                    currency: value));
                          }
                        },
                        items: list.map<DropdownMenuItem<Currency>>((value) {
                          return DropdownMenuItem<Currency>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        // onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
