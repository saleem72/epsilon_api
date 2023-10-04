// To parse this JSON data, do
//
//     final pricesResponse = pricesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';

PricesResponse pricesResponseFromJson(String str) =>
    PricesResponse.fromJson(json.decode(str));

String pricesResponseToJson(PricesResponse data) => json.encode(data.toJson());

class PricesResponse {
  int? statusCode;
  String? message;
  PriceDTOList? data;

  PricesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory PricesResponse.fromJson(Map<String, dynamic> json) => PricesResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null ? null : PriceDTOList.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class PriceDTOList {
  List<PriceDTO>? clients;

  PriceDTOList({
    this.clients,
  });

  factory PriceDTOList.fromJson(Map<String, dynamic> json) => PriceDTOList(
        clients: json["Clients"] == null
            ? []
            : List<PriceDTO>.from(
                json["Clients"]!.map((x) => PriceDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Clients": clients == null
            ? []
            : List<dynamic>.from(clients!.map((x) => x.toJson())),
      };
}

class PriceDTO {
  int? id;
  String? name;
  String? latinName;
  String? code;
  int? flag;

  PriceDTO({
    this.id,
    this.name,
    this.latinName,
    this.code,
    this.flag,
  });

  factory PriceDTO.fromJson(Map<String, dynamic> json) => PriceDTO(
        id: json["Id"],
        name: json["Name"],
        latinName: json["LatinName"],
        code: json["Code"],
        flag: json["FLAG"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "LatinName": latinName,
        "Code": code,
        "FLAG": flag,
      };

  Price toPrice() => Price(id: id ?? 0, name: name ?? '');
}
