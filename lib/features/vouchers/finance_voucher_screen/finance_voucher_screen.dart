//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_date_picker.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/dashed_line.dart';
import 'package:epsilon_api/core/widgets/dotted_text_field.dart';
import 'package:epsilon_api/core/widgets/dropdown_text_field.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/compact_customer.dart';
import 'package:epsilon_api/features/vouchers/models/voucher_type.dart';
import 'package:flutter/material.dart';

import '../models/payment_method.dart';
import '../widgets/payment_method_selector.dart';

class FinanceVoucherScreen extends StatefulWidget {
  const FinanceVoucherScreen({
    super.key,
    required this.voucherType,
  });
  final VoucherType voucherType;
  @override
  State<FinanceVoucherScreen> createState() => _FinanceVoucherScreenState();
}

class _FinanceVoucherScreenState extends State<FinanceVoucherScreen> {
  PaymentMethod method = PaymentMethod.chash;
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  _datePicker(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // AppTextFieldWithLabel(
                        //   label: context.translate.recived_from,
                        //   hint: context.translate.recipient,
                        //   onChanged: (p0) {},
                        // ),
                        DottedDropdownTextField(
                          label: context.translate.recived_from,
                          hint: context.translate.recipient,
                          customers: const [
                            CompactCustomer(
                                id: 1, number: 1, customerName: 'sarah'),
                            CompactCustomer(
                                id: 2, number: 2, customerName: 'Khaled'),
                            CompactCustomer(
                                id: 3, number: 3, customerName: 'Jhon'),
                            CompactCustomer(
                                id: 4, number: 4, customerName: 'Jack'),
                          ],
                          onSelection: (customer) {
                            print(customer);
                          },
                        ),
                        const SizedBox(height: 32),
                        PaymentMethodSelector(
                          onChange: (value) {
                            setState(() {
                              method = value;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        AppTextFieldWithLabel(
                          label: context.translate.chach_amount,
                          hint: context.translate.amount,
                          onChanged: (p0) {},
                        ),
                        if (method == PaymentMethod.cheque)
                          const SizedBox(height: 32),
                        if (method == PaymentMethod.cheque)
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
      ),
    );
  }

  Padding _datePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AppDatePicker(
        restorationId: "RecipientVoucherScreen",
        onChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
        child: DatePickerBubble(selectedDate: _selectedDate),
      ),
    );
  }
}

class DottedDropdownTextField extends StatelessWidget {
  const DottedDropdownTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.onSelection,
    required this.customers,
  });
  final String label;
  final String hint;
  final Function(CompactCustomer) onSelection;
  final List<CompactCustomer> customers;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Topology.body.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 24,
          alignment: Alignment.center,
          child: Stack(
            children: [
              const DashedLine(),
              DropdownTextField(
                hint: hint,
                onSelection: onSelection,
                customers: customers,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
