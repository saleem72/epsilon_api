//

import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_date_picker.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/dotted_dropdown_text_field.dart';
import 'package:epsilon_api/core/widgets/dotted_text_field.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/finance_voucher_bloc/finance_voucher_bloc.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/widgets/finance_voucher_loading_view.dart';
import 'package:epsilon_api/features/vouchers/models/voucher_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/payment_method.dart';
import '../widgets/payment_method_selector.dart';
import 'presentation/widgets/finance_voucher_failure_view.dart';

class FinanceVoucherScreen extends StatelessWidget {
  const FinanceVoucherScreen({
    super.key,
    required this.voucherType,
  });
  final VoucherType voucherType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<FinanceVoucherBloc>()..add(FinanceVoucherFetchDataEvent()),
      child: _FinanceVoucherScreenState(voucherType: voucherType),
    );
  }
}

class _FinanceVoucherScreenState extends StatelessWidget {
  const _FinanceVoucherScreenState({
    required this.voucherType,
  });
  final VoucherType voucherType;
  // PaymentMethod method = PaymentMethod.chash;
  // DateTime _selectedDate = DateTime.now();
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

  Scaffold _content() {
    return Scaffold(
      body: BlocBuilder<FinanceVoucherBloc, FinanceVoucherState>(
        builder: (context, state) {
          return _mainContent(context, state);
        },
      ),
    );
  }

  Column _mainContent(BuildContext context, FinanceVoucherState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNavBar(
          title: voucherType == VoucherType.recipient
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
                        customers:
                            state.customers.map((e) => e.customerName).toList(),
                        onSelection: (customer) {
                          context.read<FinanceVoucherBloc>().add(
                              FinanceVoucherSelectedCustomerChangedEvent(
                                  customer: customer));
                        },
                        fullFilled: state.selectedCustomer != null,
                      ),
                      const SizedBox(height: 32),
                      PaymentMethodSelector(
                        onChange: (value) {
                          context.read<FinanceVoucherBloc>().add(
                              FinanceVoucherPaymentChangedEvent(method: value));
                          // setState(() {
                          //   method = value;
                          // });
                        },
                      ),
                      const SizedBox(height: 32),
                      AppTextFieldWithLabel(
                        label: context.translate.chach_amount,
                        hint: context.translate.amount,
                        onChanged: (p0) {},
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
                        onChanged: (p0) {},
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientButton(
                            label: context.translate.save,
                            onPressed: () {},
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
}
