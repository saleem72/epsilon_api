// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'currency.dart';

class AccountBalance {
  List<EntryModel>? items;
  double? debit;
  double? credit;
  double? balance;
  bool? isBalanced;
  dynamic accId;
  int? id;
  String? custName;
  bool? noAcc;
  String? nationality;
  String? address;
  String? phone2;
  String? fax;
  String? homePage;
  String? prefix;
  String? suffix;
  String? area;
  String? city;
  String? street;
  String? poBox;
  String? zipCode;
  String? mobile;
  String? pager;
  String? notes;
  String? country;
  String? hoppies;
  String? gender;
  String? certificate;
  String? latinName;
  String? telex;
  String? job;
  String? jobCategory;
  String? userFld1;
  String? userFld2;
  String? userFld3;
  String? userFld4;
  String? barCode;
  Currency? currency;
  String? taxDef;
  AccountBalance({
    required this.items,
    required this.debit,
    required this.credit,
    required this.balance,
    required this.isBalanced,
    required this.accId,
    required this.id,
    required this.custName,
    required this.noAcc,
    required this.nationality,
    required this.address,
    required this.phone2,
    required this.fax,
    required this.homePage,
    required this.prefix,
    required this.suffix,
    required this.area,
    required this.city,
    required this.street,
    required this.poBox,
    required this.zipCode,
    required this.mobile,
    required this.pager,
    required this.notes,
    required this.country,
    required this.hoppies,
    required this.gender,
    required this.certificate,
    required this.latinName,
    required this.telex,
    required this.job,
    required this.jobCategory,
    required this.userFld1,
    required this.userFld2,
    required this.userFld3,
    required this.userFld4,
    required this.barCode,
    required this.currency,
    required this.taxDef,
  });
}

class EntryModel {
  int? id;
  String? itName;
  String? itName2;
  String? number;
  DateTime? date;
  // DateTime? colDate;
  double? invoiceTotal;
  double? invoiceTotalExtra;
  double? invoiceTotalDisc;
  double? invoiceItemsDisc;
  double? netDisc;
  double? invoiceItemsExtra;
  double? netExtra;
  double? itemFinal;
  double? invoiceFirstPay;
  int? invoicePayType;
  int? invoiceIsPosted;
  int? invoiceDirection;
  // String? invoiceTextFld1;
  // String? invoiceTextFld2;
  // String? invoiceTextFld3;
  // String? invoiceTextFld4;
  double? invoiceTax;
  double? invoiceIncludedTax;
  double? tax;
  String? notes;
  dynamic siteName;
  double? debit;
  double? credit;
  double? fact;
  int? flag;
  bool? isInvoice;
  bool? isClientPayment;
  bool? isJornal;
  bool? isNotePaper;
  String? jornalParms;
  int? typeId;
  List<dynamic>? items;
  double? balance;
  dynamic businessUnitId;
  String? businessUnitName;
  EntryModel({
    required this.id,
    required this.itName,
    required this.itName2,
    required this.number,
    required this.date,
    // required this.colDate,
    required this.invoiceTotal,
    required this.invoiceTotalExtra,
    required this.invoiceTotalDisc,
    required this.invoiceItemsDisc,
    required this.netDisc,
    required this.invoiceItemsExtra,
    required this.netExtra,
    required this.itemFinal,
    required this.invoiceFirstPay,
    required this.invoicePayType,
    required this.invoiceIsPosted,
    required this.invoiceDirection,
    // required this.invoiceTextFld1,
    // required this.invoiceTextFld2,
    // required this.invoiceTextFld3,
    // required this.invoiceTextFld4,
    required this.invoiceTax,
    required this.invoiceIncludedTax,
    required this.tax,
    required this.notes,
    required this.siteName,
    required this.debit,
    required this.credit,
    required this.fact,
    required this.flag,
    required this.isInvoice,
    required this.isClientPayment,
    required this.isJornal,
    required this.isNotePaper,
    required this.jornalParms,
    required this.typeId,
    required this.items,
    required this.balance,
    required this.businessUnitId,
    required this.businessUnitName,
  });
}
