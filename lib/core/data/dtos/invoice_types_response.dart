// To parse this JSON data, do
//
//     final invoiceTypesResponse = invoiceTypesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/invoice_type.dart';

InvoiceTypesResponse invoiceTypesResponseFromJson(String str) =>
    InvoiceTypesResponse.fromJson(json.decode(str));

String invoiceTypesResponseToJson(InvoiceTypesResponse data) =>
    json.encode(data.toJson());

class InvoiceTypesResponse {
  int? statusCode;
  String? message;
  InvoiceTypesResponseData? data;

  InvoiceTypesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory InvoiceTypesResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceTypesResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : InvoiceTypesResponseData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class InvoiceTypesResponseData {
  List<InvoiceTypeDTO>? salesAndReturnTypes;

  InvoiceTypesResponseData({
    this.salesAndReturnTypes,
  });

  factory InvoiceTypesResponseData.fromJson(Map<String, dynamic> json) =>
      InvoiceTypesResponseData(
        salesAndReturnTypes: json["SalesAndReturnTypes"] == null
            ? []
            : List<InvoiceTypeDTO>.from(json["SalesAndReturnTypes"]!
                .map((x) => InvoiceTypeDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SalesAndReturnTypes": salesAndReturnTypes == null
            ? []
            : List<dynamic>.from(salesAndReturnTypes!.map((x) => x.toJson())),
      };
}

class InvoiceTypeDTO {
  int? id;
  String? name;
  // String? latinName;
  // int? isReturm;

  InvoiceTypeDTO({
    this.id,
    this.name,
    // this.latinName,
    // this.isReturm,
  });

  factory InvoiceTypeDTO.fromJson(Map<String, dynamic> json) => InvoiceTypeDTO(
        id: json["Id"],
        name: json["Name"],
        // latinName: json["LatinName"],
        // isReturm: json["IsReturm"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        // "LatinName": latinName,
        // "IsReturm": isReturm,
      };

  InvoiceType toModel() => InvoiceType(
        id: id ?? 0,
        name: name ?? '',
      );
}
