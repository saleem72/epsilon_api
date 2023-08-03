//

import 'dart:convert';

import 'package:epsilon_api/core/extensions/dynamic_extension.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/dtos/balance_dto.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';

List<AccountBalanceDto> accountBalanceDtoFromJson(String str) =>
    List<AccountBalanceDto>.from(json.decode(str).map((x) =>
        List<AccountBalanceDto>.from(
            x.map((x) => AccountBalanceDto.fromJson(x)))));

String accountBalanceDtoToJson(AccountBalanceDto data) =>
    json.encode(data.toJson());

class AccountBalanceDto {
  List<BalanceDTO>? balance;
  List<CurrencyDTO>? currency;

  AccountBalanceDto({
    this.balance,
    this.currency,
  });

  factory AccountBalanceDto.fromJson(Map<String, dynamic> json) =>
      AccountBalanceDto(
        balance: json["Balance"] == null
            ? []
            : List<BalanceDTO>.from(
                json["Balance"]!.map((x) => BalanceDTO.fromJson(x))),
        currency: json["Currency"] == null
            ? []
            : List<CurrencyDTO>.from(
                json["Currency"]!.map((x) => CurrencyDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Balance": balance == null
            ? []
            : List<dynamic>.from(balance!.map((x) => x.toJson())),
        "Currency": currency == null
            ? []
            : List<dynamic>.from(currency!.map((x) => x.toJson())),
      };

  AccountBalance toAccountBalance() => AccountBalance(
        balance: (balance ?? []).map((e) => e.toBalance()).toList(),
        currency: (currency ?? []).map((e) => e.toCurrency()).toList(),
      );
}

class BalanceDTO {
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
  // Date
  DateTime? lastDebitDate;
  double? lastCredit;
  // Date
  DateTime? lastCreditDate;
  double? lastPay;
  // Date
  DateTime? lastPayDate;
  String? lastDebitNote;
  String? lastCreditNote;
  // Date
  DateTime? lastCheckDate;

  BalanceDTO({
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
  });

  factory BalanceDTO.fromJson(Map<String, dynamic> json) => BalanceDTO(
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
        lastDebitDate: json["LastDebitDate"] == null
            ? null
            : DateTime.parse(json["LastDebitDate"]),
        lastCredit: converttoDouble(json["LastCredit"]),
        lastCreditDate: json["LastCreditDate"] == null
            ? null
            : DateTime.parse(json["LastCreditDate"]),
        lastPay: converttoDouble(json["LastPay"]),
        lastPayDate: json["LastPayDate"] == null
            ? null
            : DateTime.parse(json["LastPayDate"]),
        lastDebitNote: json["LastDebitNote"],
        lastCreditNote: json["LastCreditNote"],
        lastCheckDate: json["LastCheckDate"] == null
            ? null
            : DateTime.parse(json["LastCheckDate"]),
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
        "LastDebitDate": lastDebitDate?.toIso8601String(),
        "LastCredit": lastCredit,
        "LastCreditDate": lastCreditDate?.toIso8601String(),
        "LastPay": lastPay,
        "LastPayDate": lastPayDate?.toIso8601String(),
        "LastDebitNote": lastDebitNote,
        "LastCreditNote": lastCreditNote,
        "LastCheckDate": lastCheckDate?.toIso8601String(),
      };
  Balance toBalance() => Balance(
        accCode: accCode,
        accName: accName,
        accLName: accLName,
        cuName: cuName,
        custLName: custLName,
        cuDefPrice: cuDefPrice,
        cuMaxDebit: cuMaxDebit,
        debit: debit,
        credit: credit,
        prevBalance: prevBalance,
        balance: balance,
        lastDebit: lastDebit,
        lastDebitDate: lastDebitDate,
        lastCredit: lastCredit,
        lastCreditDate: lastCreditDate,
        lastPay: lastPay,
        lastPayDate: lastPayDate,
        lastDebitNote: lastDebitNote,
        lastCreditNote: lastCreditNote,
        lastCheckDate: lastCheckDate,
      );

  factory BalanceDTO.fromOld(BalanceDtoOld model) => BalanceDTO(
        accCode: model.accCode,
        accName: model.accName,
        accLName: model.accLName,
        cuName: model.cuName,
        custLName: model.custLName,
        cuDefPrice: model.cuDefPrice,
        cuMaxDebit: model.cuMaxDebit,
        debit: model.debit,
        credit: model.credit,
        prevBalance: model.prevBalance,
        balance: model.balance,
        lastDebit: model.lastDebit,
        lastDebitDate: model.lastDebitDate == null
            ? null
            : DateTime.tryParse(model.lastDebitDate!),
        lastCredit: model.lastCredit,
        lastCreditDate: model.lastCreditDate == null
            ? null
            : DateTime.tryParse(model.lastCreditDate!),
        lastPay: model.lastPay,
        lastPayDate: model.lastPayDate == null
            ? null
            : DateTime.tryParse(model.lastPayDate!),
        lastDebitNote: model.lastDebitNote,
        lastCreditNote: model.lastCreditNote,
        lastCheckDate: model.lastCheckDate == null
            ? null
            : DateTime.tryParse(model.lastCheckDate!),
      );
}

class CurrencyDTO {
  double? number;
  String? code;
  String? name;
  double? currencyVal;
  String? partName;
  double? partPrecision;
  // Date
  DateTime? date;
  double? security;
  String? latinName;
  String? latinPartName;
  String? guid;
  double? branchMask;
  String? pictureGuid;
  String? currencyIso;

  CurrencyDTO({
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

  factory CurrencyDTO.fromJson(Map<String, dynamic> json) => CurrencyDTO(
        number: converttoDouble(json["Number"]),
        code: json["Code"],
        name: json["Name"],
        currencyVal: converttoDouble(json["CurrencyVal"]),
        partName: json["PartName"],
        partPrecision: converttoDouble(json["PartPrecision"]),
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        security: converttoDouble(json["Security"]),
        latinName: json["LatinName"],
        latinPartName: json["LatinPartName"],
        guid: json["GUID"],
        branchMask: converttoDouble(json["branchMask"]),
        pictureGuid: json["PictureGUID"],
        currencyIso: json["CurrencyISO"],
      );

  Map<String, dynamic> toJson() => {
        "Number": number,
        "Code": code,
        "Name": name,
        "CurrencyVal": currencyVal,
        "PartName": partName,
        "PartPrecision": partPrecision,
        "Date": date?.toIso8601String(),
        "Security": security,
        "LatinName": latinName,
        "LatinPartName": latinPartName,
        "GUID": guid,
        "branchMask": branchMask,
        "PictureGUID": pictureGuid,
        "CurrencyISO": currencyIso,
      };
  Currency toCurrency() => Currency(
        number: number,
        code: code,
        name: name,
        currencyVal: currencyVal,
        partName: partName,
        partPrecision: partPrecision,
        date: date,
        security: security,
        latinName: latinName,
        latinPartName: latinPartName,
        guid: guid,
        branchMask: branchMask,
        pictureGuid: pictureGuid,
        currencyIso: currencyIso,
      );

  factory CurrencyDTO.fromOld(BalanceDtoOld model) => CurrencyDTO(
        number: model.number,
        code: model.code,
        name: model.name,
        currencyVal: model.currencyVal,
        partName: model.partName,
        partPrecision: model.partPrecision,
        date: model.date == null ? null : DateTime.tryParse(model.date!),
        security: model.security,
        latinName: model.latinName,
        latinPartName: model.latinPartName,
        guid: model.guid,
        branchMask: model.branchMask,
        pictureGuid: model.pictureGuid,
        currencyIso: model.currencyIso,
      );
}
