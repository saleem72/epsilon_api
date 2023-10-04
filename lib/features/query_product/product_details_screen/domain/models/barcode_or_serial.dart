//

import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';
import 'package:equatable/equatable.dart';

abstract class HasPrices {
  List<Price> get prices;
}

class BarcodeOrSerial extends Equatable implements HasPrices {
  const BarcodeOrSerial();
  factory BarcodeOrSerial.barcode({
    required String barcode,
    required List<Price> prices,
  }) =>
      Barcode(barcode: barcode, prices: prices);
  factory BarcodeOrSerial.serial({
    required String serial,
    required List<Price> prices,
  }) =>
      Serial(serial: serial, prices: prices);

  @override
  List<Object?> get props => [];

  @override
  List<Price> get prices => [];
}

class Barcode extends BarcodeOrSerial {
  final String barcode;
  @override
  final List<Price> prices;
  const Barcode({
    required this.barcode,
    required this.prices,
  });

  @override
  List<Object?> get props => [barcode, prices];
}

class Serial extends BarcodeOrSerial {
  final String serial;
  @override
  final List<Price> prices;
  const Serial({
    required this.serial,
    required this.prices,
  });

  @override
  List<Object?> get props => [serial, prices];
}
