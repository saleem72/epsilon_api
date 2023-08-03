//

import 'package:equatable/equatable.dart';

class BarcodeOrSerial extends Equatable {
  const BarcodeOrSerial();
  factory BarcodeOrSerial.barcode({required String barcode}) =>
      Barcode(barcode: barcode);
  factory BarcodeOrSerial.serial({required String serial}) =>
      Serial(serial: serial);

  @override
  List<Object?> get props => [];
}

class Barcode extends BarcodeOrSerial {
  final String barcode;
  const Barcode({
    required this.barcode,
  });

  @override
  List<Object?> get props => [barcode];
}

class Serial extends BarcodeOrSerial {
  final String serial;
  const Serial({
    required this.serial,
  });

  @override
  List<Object?> get props => [serial];
}
