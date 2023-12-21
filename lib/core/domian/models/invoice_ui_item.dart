// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

import 'package:epsilon_api/core/domian/models/compact_product.dart';
import 'package:epsilon_api/core/domian/models/product_unit.dart';

class InvoiceUiItem extends Equatable {
  final CompactProduct product;
  final ProductUnit unit;
  final int quantity;
  final double price;
  final double tax;
  const InvoiceUiItem({
    required this.product,
    required this.unit,
    required this.quantity,
    required this.price,
    required this.tax,
  });

  double get total => price * quantity;

  String get id => '${product.id}, ${unit.id}, $quantity, $price';

  @override
  List<Object?> get props => [
        product,
        unit,
        quantity,
        price,
        tax,
      ];
}
