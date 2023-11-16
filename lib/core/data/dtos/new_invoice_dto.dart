// To parse this JSON data, do
//
//     final addInvoiceResponse = addInvoiceResponseFromJson(jsonString);

import 'dart:convert';

AddInvoiceResponse addInvoiceResponseFromJson(String str) =>
    AddInvoiceResponse.fromJson(json.decode(str));

String addInvoiceResponseToJson(AddInvoiceResponse data) =>
    json.encode(data.toJson());

class AddInvoiceResponse {
  int? statusCode;
  String? message;
  AddInvoiceResponseData? data;

  AddInvoiceResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory AddInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      AddInvoiceResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : AddInvoiceResponseData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class AddInvoiceResponseData {
  int? id;
  List<BillItemDTO>? billItems;
  DateTime? date;
  int? billPayType;
  int? typeId;
  int? custId;
  double? firstPay;
  String? currCode;
  double? discountRate;
  String? number;
  double? dataFinal;
  double? totalTax;
  double? includedTotalTax;

  AddInvoiceResponseData({
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
    this.dataFinal,
    this.totalTax,
    this.includedTotalTax,
  });

  factory AddInvoiceResponseData.fromJson(Map<String, dynamic> json) =>
      AddInvoiceResponseData(
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
            : null,
        currCode: json["CurrCode"],
        discountRate: (json["DiscountRate"] is num)
            ? (json["DiscountRate"] as num).toDouble()
            : null,
        number: json["Number"],
        dataFinal:
            (json["Final"] is num) ? (json["Final"] as num).toDouble() : null,
        totalTax: (json["TotalTax"] is num)
            ? (json["TotalTax"] as num).toDouble()
            : null,
        includedTotalTax: (json["IncludedTotalTax"] is num)
            ? (json["IncludedTotalTax"] as num).toDouble()
            : null,
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
        "Final": dataFinal,
        "TotalTax": totalTax,
        "IncludedTotalTax": includedTotalTax,
      };
}

class BillItemDTO {
  int? index;
  int? itemId;
  int? unitId;
  double? unitFact;
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

  factory BillItemDTO.fromJson(Map<String, dynamic> json) => BillItemDTO(
        index: json["Index"],
        itemId: json["ItemId"],
        unitId: json["UnitId"],
        unitFact: json["UnitFact"]?.toDouble(),
        quanitity: json["Quanitity"],
        price: json["Price"]?.toDouble(),
        bonus: json["Bonus"]?.toDouble(),
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
}

extension DynamicToDouble on dynamic {
  double? toDouble() {
    return (this is num) ? (this as num).toDouble() : null;
  }
}
