//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

import '../models/payment_method.dart';

class PaymentMethodSelector extends StatefulWidget {
  const PaymentMethodSelector({
    super.key,
    required this.onChange,
  });

  final Function(PaymentMethod) onChange;

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  PaymentMethod method = PaymentMethod.chash;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PaymentSelectorButton(
          onPressed: () {
            setState(() {
              method = PaymentMethod.chash;
              widget.onChange(PaymentMethod.chash);
            });
          },
          label: context.translate.chash,
          isSelected: method == PaymentMethod.chash,
        ),
        const SizedBox(width: 16),
        PaymentSelectorButton(
          onPressed: () {
            setState(() {
              method = PaymentMethod.cheque;
              widget.onChange(PaymentMethod.cheque);
            });
          },
          label: context.translate.cheque,
          isSelected: method == PaymentMethod.cheque,
        ),
      ],
    );
  }
}

class PaymentSelectorButton extends StatelessWidget {
  const PaymentSelectorButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final Function() onPressed;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryDark : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: Topology.body.copyWith(
              height: 1.2,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
