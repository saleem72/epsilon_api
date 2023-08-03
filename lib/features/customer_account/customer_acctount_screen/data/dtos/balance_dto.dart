// To parse this JSON data, do
//
//     final balanceDto = balanceDtoFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/extensions/dynamic_extension.dart';

List<List<BalanceDtoOld>> balanceDtoFromJson(String str) =>
    List<List<BalanceDtoOld>>.from(json.decode(str).map((x) =>
        List<BalanceDtoOld>.from(x.map((x) => BalanceDtoOld.fromJson(x)))));

String balanceDtoToJson(List<List<BalanceDtoOld>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class BalanceDtoOld {
  String? accCode;
  String? accName;
  String? accLName;
  String? cuName;
  String? custLName;
  double? cuDefPrice;
  double? cuMaxDebit;
  double? debit;
  double? credit;
  double? prevBalance;
  double? balance;
  double? lastDebit;
  String? lastDebitDate;
  double? lastCredit;
  String? lastCreditDate;
  double? lastPay;
  String? lastPayDate;
  String? lastDebitNote;
  String? lastCreditNote;
  String? lastCheckDate;
  double? number;
  String? code;
  String? name;
  double? currencyVal;
  String? partName;
  double? partPrecision;
  String? date;
  double? security;
  String? latinName;
  String? latinPartName;
  String? guid;
  double? branchMask;
  String? pictureGuid;
  String? currencyIso;

  BalanceDtoOld({
    this.accCode,
    this.accName,
    this.accLName,
    this.cuName,
    this.custLName,
    this.cuDefPrice,
    this.cuMaxDebit,
    this.debit,
    this.credit,
    this.prevBalance,
    this.balance,
    this.lastDebit,
    this.lastDebitDate,
    this.lastCredit,
    this.lastCreditDate,
    this.lastPay,
    this.lastPayDate,
    this.lastDebitNote,
    this.lastCreditNote,
    this.lastCheckDate,
    this.number,
    this.code,
    this.name,
    this.currencyVal,
    this.partName,
    this.partPrecision,
    this.date,
    this.security,
    this.latinName,
    this.latinPartName,
    this.guid,
    this.branchMask,
    this.pictureGuid,
    this.currencyIso,
  });

  factory BalanceDtoOld.fromJson(Map<String, dynamic> json) => BalanceDtoOld(
        accCode: json["AccCode"],
        accName: json["AccName"],
        accLName: json["AccLName"],
        cuName: json["CuName"],
        custLName: json["CustLName"],
        cuDefPrice: converttoDouble(json["CuDefPrice"]),
        cuMaxDebit: converttoDouble(json["CuMaxDebit"]),
        debit: converttoDouble(json["Debit"]),
        credit: converttoDouble(json["Credit"]),
        prevBalance: converttoDouble(json["PrevBalance"]),
        balance: converttoDouble(json["Balance"]),
        lastDebit: converttoDouble(json["LastDebit"]),
        lastDebitDate: json["LastDebitDate"],
        lastCredit: converttoDouble(json["LastCredit"]),
        lastCreditDate: json["LastCreditDate"],
        lastPay: converttoDouble(json["LastPay"]),
        lastPayDate: json["LastPayDate"],
        lastDebitNote: json["LastDebitNote"],
        lastCreditNote: json["LastCreditNote"],
        lastCheckDate: json["LastCheckDate"],
        number: converttoDouble(json["Number"]),
        code: json["Code"],
        name: json["Name"],
        currencyVal: converttoDouble(json["CurrencyVal"]),
        partName: json["PartName"],
        partPrecision: converttoDouble(json["PartPrecision"]),
        date: json["Date"],
        security: converttoDouble(json["Security"]),
        latinName: json["LatinName"],
        latinPartName: json["LatinPartName"],
        guid: json["GUID"],
        branchMask: converttoDouble(json["branchMask"]),
        pictureGuid: json["PictureGUID"],
        currencyIso: json["CurrencyISO"],
      );

  Map<String, dynamic> toJson() => {
        "AccCode": accCode,
        "AccName": accName,
        "AccLName": accLName,
        "CuName": cuName,
        "CustLName": custLName,
        "CuDefPrice": cuDefPrice,
        "CuMaxDebit": cuMaxDebit,
        "Debit": debit,
        "Credit": credit,
        "PrevBalance": prevBalance,
        "Balance": balance,
        "LastDebit": lastDebit,
        "LastDebitDate": lastDebitDate,
        "LastCredit": lastCredit,
        "LastCreditDate": lastCreditDate,
        "LastPay": lastPay,
        "LastPayDate": lastPayDate,
        "LastDebitNote": lastDebitNote,
        "LastCreditNote": lastCreditNote,
        "LastCheckDate": lastCheckDate,
        "Number": number,
        "Code": code,
        "Name": name,
        "CurrencyVal": currencyVal,
        "PartName": partName,
        "PartPrecision": partPrecision,
        "Date": date,
        "Security": security,
        "LatinName": latinName,
        "LatinPartName": latinPartName,
        "GUID": guid,
        "branchMask": branchMask,
        "PictureGUID": pictureGuid,
        "CurrencyISO": currencyIso,
      };
}
