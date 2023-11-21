// To parse this JSON data, do
//
//     final getInvoiceMovementResponse = getInvoiceMovementResponseFromJson(jsonString);

import 'dart:convert';
import 'package:epsilon_api/core/domian/models/searched_invoice.dart';

GetInvoiceMovementResponse getInvoiceMovementResponseFromJson(String str) =>
    GetInvoiceMovementResponse.fromJson(json.decode(str));

String getInvoiceMovementResponseToJson(GetInvoiceMovementResponse data) =>
    json.encode(data.toJson());

class GetInvoiceMovementResponse {
  int? statusCode;
  String? message;
  List<SearchedInvoiceDTO>? data;

  GetInvoiceMovementResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetInvoiceMovementResponse.fromJson(Map<String, dynamic> json) =>
      GetInvoiceMovementResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<SearchedInvoiceDTO>.from(
                json["Data"]!.map((x) => SearchedInvoiceDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SearchedInvoiceDTO {
  String? invoiceNumber;
  String? customerName;
  String? invHeaderNotes;
  double? invoicePayType;
  double? invoiceFirstPay;
  double? invoiceIsPosted;
  double? invoiceDirection;
  String? invoiceTextFld1;
  String? invoiceTextFld2;
  String? invoiceTextFld3;
  String? invoiceTextFld4;
  String? itName;
  String? itLatinName;
  double? total;
  double? invoiceTotal;
  double? invoiceTotal2;
  double? rateTotal;
  double? extra;
  double? extraRate;
  double? itemExtra;
  double? totalExtra;
  double? discount;
  double? discountRate;
  double? itemsDiscount;
  double? totalDiscount;
  double? taxVal;
  double? includedTaxVal;
  double? totalWithTax;
  double? finalNoTax;
  double? invoiceFinal;
  String? cards;
  double? cardPayments;
  String? businessUnitName;
  String? salesManName;

  SearchedInvoiceDTO({
    this.invoiceNumber,
    this.customerName,
    this.invHeaderNotes,
    this.invoicePayType,
    this.invoiceFirstPay,
    this.invoiceIsPosted,
    this.invoiceDirection,
    this.invoiceTextFld1,
    this.invoiceTextFld2,
    this.invoiceTextFld3,
    this.invoiceTextFld4,
    this.itName,
    this.itLatinName,
    this.total,
    this.invoiceTotal,
    this.invoiceTotal2,
    this.rateTotal,
    this.extra,
    this.extraRate,
    this.itemExtra,
    this.totalExtra,
    this.discount,
    this.discountRate,
    this.itemsDiscount,
    this.totalDiscount,
    this.taxVal,
    this.includedTaxVal,
    this.totalWithTax,
    this.finalNoTax,
    this.invoiceFinal,
    this.cards,
    this.cardPayments,
    this.businessUnitName,
    this.salesManName,
  });

  factory SearchedInvoiceDTO.fromJson(Map<String, dynamic> json) =>
      SearchedInvoiceDTO(
        invoiceNumber: json["InvoiceNumber"],
        customerName: json["CustomerName"],
        invHeaderNotes: json["InvHeaderNotes"],
        invoicePayType: json["InvoicePayType"]?.toDouble(),
        invoiceFirstPay: json["InvoiceFirstPay"]?.toDouble(),
        invoiceIsPosted: json["InvoiceIsPosted"]?.toDouble(),
        invoiceDirection: json["InvoiceDirection"]?.toDouble(),
        invoiceTextFld1: json["InvoiceTextFld1"],
        invoiceTextFld2: json["InvoiceTextFld2"],
        invoiceTextFld3: json["InvoiceTextFld3"],
        invoiceTextFld4: json["InvoiceTextFld4"],
        itName: json["ITName"],
        itLatinName: json["ITLatinName"],
        cards: json["Cards"],
        businessUnitName: json["BusinessUnitName"],
        salesManName: json["SalesManName"],
        total: json["Total"]?.toDouble(),
        invoiceTotal: json["InvoiceTotal"]?.toDouble(),
        invoiceTotal2: json["InvoiceTotal2"]?.toDouble(),
        rateTotal: json["RateTotal"]?.toDouble(),
        extra: json["Extra"]?.toDouble(),
        extraRate: json["ExtraRate"]?.toDouble(),
        itemExtra: json["ItemExtra"]?.toDouble(),
        totalExtra: json["TotalExtra"]?.toDouble(),
        discount: json["Discount"]?.toDouble(),
        discountRate: json["DiscountRate"]?.toDouble(),
        itemsDiscount: json["ItemsDiscount"]?.toDouble(),
        totalDiscount: json["TotalDiscount"]?.toDouble(),
        taxVal: json["TaxVal"]?.toDouble()?.toDouble(),
        includedTaxVal: json["IncludedTaxVal"]?.toDouble(),
        totalWithTax: json["TotalWithTax"]?.toDouble()?.toDouble(),
        finalNoTax: json["FinalNoTax"]?.toDouble(),
        invoiceFinal: json["Final"]?.toDouble()?.toDouble(),
        cardPayments: json["CardPayments"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "InvoiceNumber": invoiceNumber,
        "CustomerName": customerName,
        "InvHeaderNotes": invHeaderNotes,
        "InvoicePayType": invoicePayType,
        "InvoiceFirstPay": invoiceFirstPay,
        "InvoiceIsPosted": invoiceIsPosted,
        "InvoiceDirection": invoiceDirection,
        "InvoiceTextFld1": invoiceTextFld1,
        "InvoiceTextFld2": invoiceTextFld2,
        "InvoiceTextFld3": invoiceTextFld3,
        "InvoiceTextFld4": invoiceTextFld4,
        "ITName": itName,
        "ITLatinName": itLatinName,
        "Total": total,
        "InvoiceTotal": invoiceTotal,
        "InvoiceTotal2": invoiceTotal2,
        "RateTotal": rateTotal,
        "Extra": extra,
        "ExtraRate": extraRate,
        "ItemExtra": itemExtra,
        "TotalExtra": totalExtra,
        "Discount": discount,
        "DiscountRate": discountRate,
        "ItemsDiscount": itemsDiscount,
        "TotalDiscount": totalDiscount,
        "TaxVal": taxVal,
        "IncludedTaxVal": includedTaxVal,
        "TotalWithTax": totalWithTax,
        "FinalNoTax": finalNoTax,
        "Final": invoiceFinal,
        "Cards": cards,
        "CardPayments": cardPayments,
        "BusinessUnitName": businessUnitName,
        "SalesManName": salesManName,
      };

  SearchedInvoice toModel() => SearchedInvoice(
        invoiceNumber: invoiceNumber ?? '',
        invHeaderNotes: invHeaderNotes ?? '',
        invoiceTotal: invoiceTotal ?? 0,
        taxVal: taxVal ?? 0,
        totalDiscount: totalDiscount ?? 0,
        invoiceFinal: invoiceFinal ?? 0,
      );
}
