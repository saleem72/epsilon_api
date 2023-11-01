// To parse this JSON data, do
//
//     final addNewVoucherResponse = addNewVoucherResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/new_voucher.dart';

AddNewVoucherResponse addNewVoucherResponseFromJson(String str) =>
    AddNewVoucherResponse.fromJson(json.decode(str));

String addNewVoucherResponseToJson(AddNewVoucherResponse data) =>
    json.encode(data.toJson());

class AddNewVoucherResponse {
  int? statusCode;
  String? message;
  NewVoucherDTO? data;

  AddNewVoucherResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory AddNewVoucherResponse.fromJson(Map<String, dynamic> json) =>
      AddNewVoucherResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data:
            json["Data"] == null ? null : NewVoucherDTO.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class NewVoucherDTO {
  List<NewVoucherItemDto>? entryItems;
  String? date;
  int? typeId;
  String? currCode;
  String? number;

  NewVoucherDTO({
    this.entryItems,
    this.date,
    this.typeId,
    this.currCode,
    this.number,
  });

  factory NewVoucherDTO.fromJson(Map<String, dynamic> json) => NewVoucherDTO(
        entryItems: json["EntryItems"] == null
            ? []
            : List<NewVoucherItemDto>.from(
                json["EntryItems"]!.map((x) => NewVoucherItemDto.fromJson(x))),
        date: json["Date"],
        typeId: json["TypeId"],
        currCode: json["CurrCode"],
        number: json["Number"],
      );

  Map<String, dynamic> toJson() => {
        "EntryItems": entryItems == null
            ? []
            : List<dynamic>.from(entryItems!.map((x) => x.toJson())),
        "Date": date,
        "TypeId": typeId,
        "CurrCode": currCode,
        "Number": number,
      };

  NewVoucher toModel() => NewVoucher(
        entryItems:
            (entryItems ?? []).map<NewVoucherItem>((e) => e.toModel()).toList(),
        date: date ?? '',
        typeId: typeId ?? 0,
        currencyCode: currCode ?? '',
        number: number ?? '',
      );
}

class NewVoucherItemDto {
  int? custid;
  int? accid;
  double? debit;
  double? credit;
  String? currCode;
  String? date;

  NewVoucherItemDto({
    this.custid,
    this.accid,
    this.debit,
    this.credit,
    this.currCode,
    this.date,
  });

  factory NewVoucherItemDto.fromJson(Map<String, dynamic> json) =>
      NewVoucherItemDto(
        custid: json["Custid"],
        accid: json["Accid"],
        debit: json["Debit"] is num ? (json["Debit"] as num).toDouble() : 0,
        credit: json["Credit"] is num ? (json["Credit"] as num).toDouble() : 0,
        currCode: json["CurrCode"],
        date: json["Date"],
      );

  Map<String, dynamic> toJson() => {
        "Custid": custid,
        "Accid": accid,
        "Debit": debit,
        "Credit": credit,
        "CurrCode": currCode,
        "Date": date,
      };

  NewVoucherItem toModel() => NewVoucherItem(
        customerid: custid ?? 0,
        accountId: accid ?? 0,
        debit: debit ?? 0,
        credit: credit ?? 0,
        currencyCode: currCode ?? '',
        date: date ?? '',
      );
}
