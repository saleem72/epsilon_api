// To parse this JSON data, do
//
//     final getPriceByUnitResponse = getPriceByUnitResponseFromJson(jsonString);

import 'dart:convert';

GetPriceByUnitResponse getPriceByUnitResponseFromJson(String str) =>
    GetPriceByUnitResponse.fromJson(json.decode(str));

String getPriceByUnitResponseToJson(GetPriceByUnitResponse data) =>
    json.encode(data.toJson());

class GetPriceByUnitResponse {
  int? statusCode;
  String? message;
  GetPriceByUnitResponseData? data;

  GetPriceByUnitResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetPriceByUnitResponse.fromJson(Map<String, dynamic> json) =>
      GetPriceByUnitResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : GetPriceByUnitResponseData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class GetPriceByUnitResponseData {
  double? price;
  int? unitId;
  int? itemId;
  double? tax;

  GetPriceByUnitResponseData({
    this.price,
    this.unitId,
    this.itemId,
    this.tax,
  });

  factory GetPriceByUnitResponseData.fromJson(Map<String, dynamic> json) =>
      GetPriceByUnitResponseData(
        price:
            (json["Price"] is num) ? (json["Price"] as num).toDouble() : null,
        unitId: json["UnitId"],
        itemId: json["ItemId"],
        tax: (json["Tax"] is num) ? (json["Tax"] as num).toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        "Price": price,
        "UnitId": unitId,
        "ItemId": itemId,
        "Tax": tax,
      };
}
