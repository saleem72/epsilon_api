// To parse this JSON data, do
//
//     final addNewInvoiceResponse = addNewInvoiceResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/new_invoice.dart';

NewInvoiceDTO newInvoiceDtoFromJson(String str) =>
    NewInvoiceDTO.fromJson(json.decode(str));

String newInvoiceDtoToJson(NewInvoiceDTO data) => json.encode(data.toJson());

class NewInvoiceDTO {
  int? id;
  List<BillItemDTO>? billItems;
  DateTime? date;
  int? billPayType;
  int? typeId;
  int? custId;
  double? firstPay;
  String? currCode;
  int? discountRate;
  String? number;
  double? billFinal;
  double? totalTax;
  int? includedTotalTax;

  NewInvoiceDTO({
    this.id,
    this.billItems,
    this.date,
    this.billPayType,
    this.typeId,
    this.custId,
    this.firstPay,
    this.currCode,
    this.discountRate,
    this.number,
    this.billFinal,
    this.totalTax,
    this.includedTotalTax,
  });

  factory NewInvoiceDTO.fromModel(NewInvoice model) => NewInvoiceDTO(
        id: model.id,
        billItems:
            model.billItems.map((e) => BillItemDTO.fromModel(e)).toList(),
        date: model.date,
        billPayType: model.billPayType,
        typeId: model.typeId,
        custId: model.custId,
        firstPay: model.firstPay,
        currCode: model.currCode,
        discountRate: model.discountRate,
        number: model.number,
        billFinal: model.billFinal,
        totalTax: model.totalTax,
        includedTotalTax: model.includedTotalTax,
      );

  factory NewInvoiceDTO.fromJson(Map<String, dynamic> json) => NewInvoiceDTO(
        id: json["Id"],
        billItems: json["billItems"] == null
            ? []
            : List<BillItemDTO>.from(
                json["billItems"]!.map((x) => BillItemDTO.fromJson(x))),
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        billPayType: json["BillPayType"],
        typeId: json["TypeId"],
        custId: json["CustId"],
        firstPay: (json["FirstPay"] is num)
            ? (json["FirstPay"] as num).toDouble()
            : 0,
        currCode: json["CurrCode"],
        discountRate: json["DiscountRate"],
        number: json["Number"],
        billFinal:
            (json["Final"] is num) ? (json["Final"] as num).toDouble() : 0,
        totalTax: (json["TotalTax"] is num)
            ? (json["TotalTax"] as num).toDouble()
            : 0,
        includedTotalTax: json["IncludedTotalTax"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "billItems": billItems == null
            ? []
            : List<dynamic>.from(billItems!.map((x) => x.toJson())),
        "Date": date?.toIso8601String(),
        "BillPayType": billPayType,
        "TypeId": typeId,
        "CustId": custId,
        "FirstPay": firstPay,
        "CurrCode": currCode,
        "DiscountRate": discountRate,
        "Number": number,
        "Final": billFinal,
        "TotalTax": totalTax,
        "IncludedTotalTax": includedTotalTax,
      };

  NewInvoice toModel() => NewInvoice(
        id: id ?? 0,
        billItems: (billItems ?? []).map((e) => e.toModel()).toList(),
        date: date ?? DateTime.now(),
        billPayType: billPayType ?? 0,
        typeId: typeId ?? 0,
        custId: custId ?? 0,
        firstPay: firstPay ?? 0,
        currCode: currCode ?? '',
        discountRate: discountRate ?? 0,
        number: number ?? '',
        billFinal: billFinal ?? 0,
        totalTax: totalTax ?? 0,
        includedTotalTax: includedTotalTax ?? 0,
      );
}

class BillItemDTO {
  int? index;
  int? itemId;
  int? unitId;
  int? unitFact;
  int? quanitity;
  double? price;
  double? bonus;

  BillItemDTO({
    this.index,
    this.itemId,
    this.unitId,
    this.unitFact,
    this.quanitity,
    this.price,
    this.bonus,
  });

  factory BillItemDTO.fromModel(BillItem model) => BillItemDTO(
        index: model.index,
        itemId: model.itemId,
        unitId: model.unitId,
        unitFact: model.unitFact,
        quanitity: model.quanitity,
        price: model.price,
        bonus: model.bonus,
      );

  factory BillItemDTO.fromJson(Map<String, dynamic> json) => BillItemDTO(
        index: json["Index"],
        itemId: json["ItemId"],
        unitId: json["UnitId"],
        unitFact: json["UnitFact"],
        quanitity: json["Quanitity"],
        price: (json["Price"] is num) ? (json["Price"] as num).toDouble() : 0,
        bonus: (json["Bonus"] is num) ? (json["Bonus"] as num).toDouble() : 0,
      );

  Map<String, dynamic> toJson() => {
        "Index": index,
        "ItemId": itemId,
        "UnitId": unitId,
        "UnitFact": unitFact,
        "Quanitity": quanitity,
        "Price": price,
        "Bonus": bonus,
      };

  BillItem toModel() => BillItem(
        index: index ?? 0,
        itemId: itemId ?? 0,
        unitId: unitId ?? 0,
        unitFact: unitFact ?? 0,
        quanitity: quanitity ?? 0,
        price: price ?? 0,
        bonus: bonus ?? 0,
      );
}
