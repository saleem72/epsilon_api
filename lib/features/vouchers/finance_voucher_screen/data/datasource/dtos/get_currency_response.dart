// To parse this JSON data, do
//
//     final getCurrencyResponse = getCurrencyResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';

GetCurrencyResponse getCurrencyResponseFromJson(String str) =>
    GetCurrencyResponse.fromJson(json.decode(str));

String getCurrencyResponseToJson(GetCurrencyResponse data) =>
    json.encode(data.toJson());

class GetCurrencyResponse {
  int? statusCode;
  String? message;
  List<CurrencyDTO>? data;

  GetCurrencyResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      GetCurrencyResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<CurrencyDTO>.from(
                json["Data"]!.map((x) => CurrencyDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CurrencyDTO {
  int? currId;
  double? currVal;
  String? code;
  String? name;
  String? partName;
  String? latinPartName;
  String? latinName;

  CurrencyDTO({
    this.currId,
    this.currVal,
    this.code,
    this.name,
    this.partName,
    this.latinPartName,
    this.latinName,
  });

  factory CurrencyDTO.fromJson(Map<String, dynamic> json) => CurrencyDTO(
        currId: json["CurrId"],
        currVal:
            (json["CurrVal"] is num) ? (json["CurrVal"] as num).toDouble() : 0,
        code: json["Code"],
        name: json["Name"],
        partName: json["PartName"],
        latinPartName: json["LatinPartName"],
        latinName: json["LatinName"],
      );

  Map<String, dynamic> toJson() => {
        "CurrId": currId,
        "CurrVal": currVal,
        "Code": code,
        "Name": name,
        "PartName": partName,
        "LatinPartName": latinPartName,
        "LatinName": latinName,
      };

  Currency toCurrency() => Currency(
        currId: currId ?? 0,
        currVal: currVal ?? 0,
        code: code ?? '',
        name: name ?? '',
      );
}
