// To parse this JSON data, do
//
//     final entryTypesResponse = entryTypesResponseFromJson(jsonString);

import 'dart:convert';

EntryTypesResponse entryTypesResponseFromJson(String str) =>
    EntryTypesResponse.fromJson(json.decode(str));

String entryTypesResponseToJson(EntryTypesResponse data) =>
    json.encode(data.toJson());

class EntryTypesResponse {
  int? statusCode;
  String? message;
  EntryTypesData? data;

  EntryTypesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory EntryTypesResponse.fromJson(Map<String, dynamic> json) =>
      EntryTypesResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data:
            json["Data"] == null ? null : EntryTypesData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class EntryTypesData {
  List<SalesAndReturnType>? salesAndReturnTypes;

  EntryTypesData({
    this.salesAndReturnTypes,
  });

  factory EntryTypesData.fromJson(Map<String, dynamic> json) => EntryTypesData(
        salesAndReturnTypes: json["SalesAndReturnTypes"] == null
            ? []
            : List<SalesAndReturnType>.from(json["SalesAndReturnTypes"]!
                .map((x) => SalesAndReturnType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SalesAndReturnTypes": salesAndReturnTypes == null
            ? []
            : List<dynamic>.from(salesAndReturnTypes!.map((x) => x.toJson())),
      };
}

class SalesAndReturnType {
  int? id;
  String? name;
  String? latinName;

  SalesAndReturnType({
    this.id,
    this.name,
    this.latinName,
  });

  factory SalesAndReturnType.fromJson(Map<String, dynamic> json) =>
      SalesAndReturnType(
        id: json["Id"],
        name: json["Name"],
        latinName: json["LatinName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "LatinName": latinName,
      };
}
