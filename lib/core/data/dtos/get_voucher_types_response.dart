// To parse this JSON data, do
//
//     final getVoucherTypesResponse = getVoucherTypesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/voucher_type.dart';

GetVoucherTypesResponse getVoucherTypesResponseFromJson(String str) =>
    GetVoucherTypesResponse.fromJson(json.decode(str));

String getVoucherTypesResponseToJson(GetVoucherTypesResponse data) =>
    json.encode(data.toJson());

class GetVoucherTypesResponse {
  int? statusCode;
  String? message;
  GetVoucherTypesResponseData? data;

  GetVoucherTypesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetVoucherTypesResponse.fromJson(Map<String, dynamic> json) =>
      GetVoucherTypesResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : GetVoucherTypesResponseData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class GetVoucherTypesResponseData {
  List<VoucherTypeDTO>? salesAndReturnTypes;

  GetVoucherTypesResponseData({
    this.salesAndReturnTypes,
  });

  factory GetVoucherTypesResponseData.fromJson(Map<String, dynamic> json) =>
      GetVoucherTypesResponseData(
        salesAndReturnTypes: json["SalesAndReturnTypes"] == null
            ? []
            : List<VoucherTypeDTO>.from(json["SalesAndReturnTypes"]!
                .map((x) => VoucherTypeDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SalesAndReturnTypes": salesAndReturnTypes == null
            ? []
            : List<dynamic>.from(salesAndReturnTypes!.map((x) => x.toJson())),
      };
}

class VoucherTypeDTO {
  int? id;
  String? name;
  String? latinName;
  bool? fldDebit;
  bool? fldCredit;
  int? flag;

  VoucherTypeDTO({
    this.id,
    this.name,
    this.latinName,
    this.fldDebit,
    this.fldCredit,
    this.flag,
  });

  factory VoucherTypeDTO.fromJson(Map<String, dynamic> json) => VoucherTypeDTO(
        id: json["Id"],
        name: json["Name"],
        latinName: json["LatinName"],
        fldDebit: json["FldDebit"],
        fldCredit: json["FldCredit"],
        flag: json["Flag"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "LatinName": latinName,
        "FldDebit": fldDebit,
        "FldCredit": fldCredit,
        "Flag": flag,
      };

  VoucherType toModel() => VoucherType(
        id: id ?? 0,
        name: name ?? '',
        latinName: latinName ?? '',
        fldDebit: fldDebit ?? false,
        fldCredit: fldCredit ?? false,
        flag: flag ?? 0,
      );
}
