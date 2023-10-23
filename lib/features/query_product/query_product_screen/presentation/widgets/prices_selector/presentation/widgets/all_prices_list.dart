//

import 'package:epsilon_api/core/domian/models/price.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/presentation/prices_selector_bloc/prices_selector_bloc.dart';
import 'package:flutter/material.dart';

class AllPricesList extends StatefulWidget {
  const AllPricesList({
    super.key,
    required this.state,
    required this.onChange,
  });
  final PricesSelectorState state;
  final Function(List<Price>) onChange;
  @override
  State<AllPricesList> createState() => _AllPricesListState();
}

class _AllPricesListState extends State<AllPricesList> {
  List<Price> allPrices = [];
  List<Price> selectedPrices = [];
  @override
  void initState() {
    super.initState();
    allPrices = widget.state.allPrices.map((e) => e).toList();
    selectedPrices = widget.state.selectedPrices.map((e) => e).toList();
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context, widget.state);
  }

  SingleChildScrollView _buildList(
      BuildContext context, PricesSelectorState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [...allPrices.map((e) => _buildPrice(e))],
      ),
    );
  }

  Widget _buildPrice(Price price) {
    return Row(
      children: [
        Checkbox(
          value: selectedPrices.contains(price),
          onChanged: (value) => _selectUnselectPrice(price, value ?? false),
        ),
        Expanded(child: Text(price.name)),
      ],
    );
  }

  _selectUnselectPrice(Price price, bool isSelected) {
    if (isSelected && selectedPrices.length > 1) {
      return;
    }
    setState(() {
      if (isSelected) {
        selectedPrices.add(price);
      } else {
        selectedPrices.remove(price);
      }
      widget.onChange(selectedPrices);
    });
  }
}
