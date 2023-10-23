//

import 'package:epsilon_api/core/domian/models/price.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/presentation/prices_selector_bloc/prices_selector_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/widgets/all_prices_list.dart';

class PricesSelector extends StatelessWidget {
  const PricesSelector({
    super.key,
    required this.onChange,
  });
  final Function(List<Price>) onChange;
  @override
  Widget build(BuildContext context) {
    return _PricesSelectorContent(
      onChange: onChange,
    );
  }
}

class _PricesSelectorContent extends StatelessWidget {
  const _PricesSelectorContent({required this.onChange});
  final Function(List<Price>) onChange;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PricesSelectorBloc, PricesSelectorState>(
      listenWhen: (previous, current) =>
          previous.selectedPrices != current.selectedPrices,
      listener: (context, state) {
        onChange(state.selectedPrices);
      },
      builder: (context, state) {
        return _buildList(context, state);
      },
    );
  }

  Widget _buildList(BuildContext context, PricesSelectorState state) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showMenu(context, state),
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.green,
              // color: const Color(0xFFF1F1F1),
              border: Border.all(
                width: 0.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: state.isLoading
                ? const Center(
                    child: SizedBox(
                      height: 44,
                      width: 44,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Row(
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          ...state.selectedPrices
                              .map((e) => Chip(label: Text(e.name)))
                        ],
                      ),
                    ],
                  ),
          ),
          Transform.translate(
            offset: const Offset(-24, -12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: const Color(0xFFF1F1F1),
              child: Text(
                context.translate.prices,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showMenu(BuildContext context, PricesSelectorState state) {
    showDialog(
        context: context,
        builder: (newContect) {
          return AlertDialog(
            title: Text(context.translate.select_prices),
            content: AllPricesList(
              state: state,
              onChange: (selectedPrices) => context
                  .read<PricesSelectorBloc>()
                  .add(PricesSelectorSelectedHasChangedEvent(
                    selected: selectedPrices,
                  )),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(newContect).pop();
                },
                child: Text(context.translate.ok),
              ),
            ],
          );
        });
  }
}
