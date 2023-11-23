//

import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductDetails {
  final int id;
  final String code;
  final String name;
  final double enduser;
  final double enduser2;
  final String unity;
  final String barcode;
  final String matunit;
  final String? imageBase64;
  final List<StoreQuntity> stores;

  ProductDetails({
    required this.id,
    required this.code,
    required this.name,
    required this.enduser,
    required this.unity,
    required this.enduser2,
    required this.barcode,
    required this.matunit,
    required this.stores,
    required this.imageBase64,
  });

  Uint8List? get memoryImage =>
      imageBase64 == null ? null : const Base64Decoder().convert(imageBase64!);
}

class StoreQuntity {
  final String store;
  final String quantity;

  StoreQuntity({
    required this.store,
    required this.quantity,
  });
}
