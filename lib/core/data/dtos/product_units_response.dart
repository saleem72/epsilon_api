// To parse this JSON data, do
//
//     final productUnitsResponse = productUnitsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/product_unit.dart';

ProductUnitsResponse productUnitsResponseFromJson(String str) =>
    ProductUnitsResponse.fromJson(json.decode(str));

String productUnitsResponseToJson(ProductUnitsResponse data) =>
    json.encode(data.toJson());

class ProductUnitsResponse {
  int? statusCode;
  String? message;
  ProductUnitsResponseData? data;

  ProductUnitsResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ProductUnitsResponse.fromJson(Map<String, dynamic> json) =>
      ProductUnitsResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : ProductUnitsResponseData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class ProductUnitsResponseData {
  List<ProductUnitDTO>? units;

  ProductUnitsResponseData({
    this.units,
  });

  factory ProductUnitsResponseData.fromJson(Map<String, dynamic> json) =>
      ProductUnitsResponseData(
        units: json["Units"] == null
            ? []
            : List<ProductUnitDTO>.from(
                json["Units"]!.map((x) => ProductUnitDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Units": units == null
            ? []
            : List<dynamic>.from(units!.map((x) => x.toJson())),
      };
}

class ProductUnitDTO {
  int? id;
  String? name;
  double? fact;

  ProductUnitDTO({
    this.id,
    this.name,
    this.fact,
  });

  factory ProductUnitDTO.fromJson(Map<String, dynamic> json) => ProductUnitDTO(
        id: json["Id"],
        name: json["Name"],
        fact: (json["Fact"] is num) ? (json["Fact"] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Fact": fact,
      };

  ProductUnit toModel() =>
      ProductUnit(id: id ?? 0, name: name ?? '', fact: fact ?? 0);
}
