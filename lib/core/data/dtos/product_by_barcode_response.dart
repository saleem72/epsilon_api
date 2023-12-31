// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final productByBarcodeDto = productByBarcodeDtoFromJson(jsonString);

import 'dart:convert';

//

import 'package:epsilon_api/core/domian/models/product_datails.dart';

import 'product_dto.dart';

class ProductByBarcodeResponse {
  /*
     "StatusCode": 200,
    "Message": "Data retrieved successfully",
    "Data":
  */

  final int statusCode;
  final String message;
  final ProductByBarcodeDto? data;
  ProductByBarcodeResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ProductByBarcodeResponse.fromMap(Map<String, dynamic> map) {
    return ProductByBarcodeResponse(
      statusCode: map['StatusCode'] as int,
      message: map['Message'] as String,
      data: ProductByBarcodeDto.fromJson(map['Data'] as Map<String, dynamic>),
    );
  }

  factory ProductByBarcodeResponse.fromJson(String source) =>
      ProductByBarcodeResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

ProductByBarcodeDto productByBarcodeDtoFromJson(String str) =>
    ProductByBarcodeDto.fromJson(json.decode(str));

String productByBarcodeDtoToJson(ProductByBarcodeDto data) =>
    json.encode(data.toJson());

class ProductByBarcodeDto {
  List<ProductDto>? item;
  List<SiteDTO>? sites;

  ProductByBarcodeDto({
    this.item,
    this.sites,
  });

  factory ProductByBarcodeDto.fromJson(Map<String, dynamic> json) =>
      ProductByBarcodeDto(
        item: json["Item"] == null
            ? []
            : List<ProductDto>.from(
                json["Item"]!.map((x) => ProductDto.fromJson(x))),
        sites: json["Sites"] == null
            ? []
            : List<SiteDTO>.from(
                json["Sites"]!.map((x) => SiteDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Item": item == null
            ? []
            : List<dynamic>.from(item!.map((x) => x.toJson())),
        "Sites": sites == null
            ? []
            : List<dynamic>.from(sites!.map((x) => x.toJson())),
      };
}

class SiteDTO {
  String? code;
  int? id;
  double? qty;
  String? stCde;
  String? stName;

  SiteDTO({
    this.code,
    this.id,
    this.qty,
    this.stCde,
    this.stName,
  });

  factory SiteDTO.fromJson(Map<String, dynamic> json) => SiteDTO(
        code: json["Code"],
        id: json["Id"],
        qty: json["Qty"],
        stCde: json["stCde"],
        stName: json["stName"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Id": id,
        "Qty": qty,
        "stCde": stCde,
        "stName": stName,
      };

  StoreQuntity toStoreQuntity() {
    return StoreQuntity(
      store: stName ?? '',
      quantity: qty ?? 0,
    );
  }
}
