// To parse this JSON data, do
//
//     final customerTransactionsResponse = customerTransactionsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/models/account_balance.dart';

CustomerTransactionsResponse customerTransactionsResponseFromJson(String str) =>
    CustomerTransactionsResponse.fromJson(json.decode(str));

String customerTransactionsResponseToJson(CustomerTransactionsResponse data) =>
    json.encode(data.toJson());

class CustomerTransactionsResponse {
  int? statusCode;
  String? message;
  List<BalanceDTO>? data;

  CustomerTransactionsResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory CustomerTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      CustomerTransactionsResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<BalanceDTO>.from(
                json["Data"]!.map((x) => BalanceDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BalanceDTO {
  List<EntryDTO>? items;
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
  ClientCurr? clientCurr;
  String? taxDef;

  BalanceDTO({
    this.items,
    this.debit,
    this.credit,
    this.balance,
    this.isBalanced,
    this.accId,
    this.id,
    this.custName,
    this.noAcc,
    this.nationality,
    this.address,
    this.phone2,
    this.fax,
    this.homePage,
    this.prefix,
    this.suffix,
    this.area,
    this.city,
    this.street,
    this.poBox,
    this.zipCode,
    this.mobile,
    this.pager,
    this.notes,
    this.country,
    this.hoppies,
    this.gender,
    this.certificate,
    this.latinName,
    this.telex,
    this.job,
    this.jobCategory,
    this.userFld1,
    this.userFld2,
    this.userFld3,
    this.userFld4,
    this.barCode,
    this.clientCurr,
    this.taxDef,
  });

  factory BalanceDTO.fromJson(Map<String, dynamic> json) => BalanceDTO(
        items: json["Items"] == null
            ? []
            : List<EntryDTO>.from(
                json["Items"]!.map((x) => EntryDTO.fromJson(x))),
        debit: json["Debit"],
        credit: json["Credit"],
        balance: json["Balance"],
        isBalanced: json["IsBalanced"],
        accId: json["AccId"],
        id: json["Id"],
        custName: json["CustName"],
        noAcc: json["NoAcc"],
        nationality: json["Nationality"],
        address: json["Address"],
        phone2: json["Phone2"],
        fax: json["FAX"],
        homePage: json["HomePage"],
        prefix: json["Prefix"],
        suffix: json["Suffix"],
        area: json["Area"],
        city: json["City"],
        street: json["Street"],
        poBox: json["POBox"],
        zipCode: json["ZipCode"],
        mobile: json["Mobile"],
        pager: json["Pager"],
        notes: json["Notes"],
        country: json["Country"],
        hoppies: json["Hoppies"],
        gender: json["Gender"],
        certificate: json["Certificate"],
        latinName: json["LatinName"],
        telex: json["Telex"],
        job: json["Job"],
        jobCategory: json["JobCategory"],
        userFld1: json["UserFld1"],
        userFld2: json["UserFld2"],
        userFld3: json["UserFld3"],
        userFld4: json["UserFld4"],
        barCode: json["BarCode"],
        clientCurr: json["ClientCurr"] == null
            ? null
            : ClientCurr.fromJson(json["ClientCurr"]),
        taxDef: json["TaxDef"],
      );

  Map<String, dynamic> toJson() => {
        "Items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "Debit": debit,
        "Credit": credit,
        "Balance": balance,
        "IsBalanced": isBalanced,
        "AccId": accId,
        "Id": id,
        "CustName": custName,
        "NoAcc": noAcc,
        "Nationality": nationality,
        "Address": address,
        "Phone2": phone2,
        "FAX": fax,
        "HomePage": homePage,
        "Prefix": prefix,
        "Suffix": suffix,
        "Area": area,
        "City": city,
        "Street": street,
        "POBox": poBox,
        "ZipCode": zipCode,
        "Mobile": mobile,
        "Pager": pager,
        "Notes": notes,
        "Country": country,
        "Hoppies": hoppies,
        "Gender": gender,
        "Certificate": certificate,
        "LatinName": latinName,
        "Telex": telex,
        "Job": job,
        "JobCategory": jobCategory,
        "UserFld1": userFld1,
        "UserFld2": userFld2,
        "UserFld3": userFld3,
        "UserFld4": userFld4,
        "BarCode": barCode,
        "ClientCurr": clientCurr?.toJson(),
        "TaxDef": taxDef,
      };

  AccountBalance toAccountBalance() {
    return AccountBalance(
      items: (items ?? []).map((e) => e.toModel()).toList(),
      debit: debit,
      credit: credit,
      balance: balance,
      isBalanced: isBalanced,
      accId: accId,
      id: id,
      custName: custName,
      noAcc: noAcc,
      nationality: nationality,
      address: address,
      phone2: phone2,
      fax: fax,
      homePage: homePage,
      prefix: prefix,
      suffix: suffix,
      area: area,
      city: city,
      street: street,
      poBox: poBox,
      zipCode: zipCode,
      mobile: mobile,
      pager: pager,
      notes: notes,
      country: country,
      hoppies: hoppies,
      gender: gender,
      certificate: certificate,
      latinName: latinName,
      telex: telex,
      job: job,
      jobCategory: jobCategory,
      userFld1: userFld1,
      userFld2: userFld2,
      userFld3: userFld3,
      userFld4: userFld4,
      barCode: barCode,
      currency: clientCurr?.toCurrency(),
      taxDef: taxDef,
    );
  }
}

class ClientCurr {
  int? currId;
  double? currVal;
  String? code;
  String? name;
  String? partName;
  String? latinPartName;
  String? latinName;

  ClientCurr({
    this.currId,
    this.currVal,
    this.code,
    this.name,
    this.partName,
    this.latinPartName,
    this.latinName,
  });

  factory ClientCurr.fromJson(Map<String, dynamic> json) => ClientCurr(
        currId: json["CurrId"],
        currVal: json["CurrVal"],
        code: json["Code"],
        name: json["Name"],
        partName: json["PartName"],
        latinPartName: json["LatinPartName"],
        latinName: json["LatinName"],
      );

  Map<String, dynamic> toJson() => {
        "CurrId": currId,
        "CurrVal": currVal,
        "Code": code,
        "Name": name,
        "PartName": partName,
        "LatinPartName": latinPartName,
        "LatinName": latinName,
      };

  Currency toCurrency() {
    return Currency(
      currId: currId,
      currVal: currVal,
      code: code,
      name: name,
      partName: partName,
      latinPartName: latinPartName,
      latinName: latinName,
    );
  }
}

class EntryDTO {
  int? id;
  String? itName;
  String? itName2;
  String? number;
  DateTime? date;
  // dynamic colDate;
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
  dynamic invoiceTextFld1;
  dynamic invoiceTextFld2;
  dynamic invoiceTextFld3;
  dynamic invoiceTextFld4;
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

  EntryDTO({
    this.id,
    this.itName,
    this.itName2,
    this.number,
    this.date,
    // this.colDate,
    this.invoiceTotal,
    this.invoiceTotalExtra,
    this.invoiceTotalDisc,
    this.invoiceItemsDisc,
    this.netDisc,
    this.invoiceItemsExtra,
    this.netExtra,
    this.itemFinal,
    this.invoiceFirstPay,
    this.invoicePayType,
    this.invoiceIsPosted,
    this.invoiceDirection,
    this.invoiceTextFld1,
    this.invoiceTextFld2,
    this.invoiceTextFld3,
    this.invoiceTextFld4,
    this.invoiceTax,
    this.invoiceIncludedTax,
    this.tax,
    this.notes,
    this.siteName,
    this.debit,
    this.credit,
    this.fact,
    this.flag,
    this.isInvoice,
    this.isClientPayment,
    this.isJornal,
    this.isNotePaper,
    this.jornalParms,
    this.typeId,
    this.items,
    this.balance,
    this.businessUnitId,
    this.businessUnitName,
  });

  factory EntryDTO.fromJson(Map<String, dynamic> json) => EntryDTO(
        id: json["ID"],
        itName: json["ITName"],
        itName2: json["ITName2"],
        number: json["Number"],
        date: json["Date"] == null ? null : DateTime.tryParse(json["Date"]),
        // colDate: json["ColDate"],
        invoiceTotal: json["InvoiceTotal"],
        invoiceTotalExtra: json["InvoiceTotalExtra"],
        invoiceTotalDisc: json["InvoiceTotalDisc"],
        invoiceItemsDisc: json["InvoiceItemsDisc"],
        netDisc: json["NetDisc"],
        invoiceItemsExtra: json["InvoiceItemsExtra"],
        netExtra: json["NetExtra"],
        itemFinal: json["Final"],
        invoiceFirstPay: json["InvoiceFirstPay"],
        invoicePayType: json["InvoicePayType"],
        invoiceIsPosted: json["InvoiceIsPosted"],
        invoiceDirection: json["InvoiceDirection"],
        invoiceTextFld1: json["InvoiceTextFld1"],
        invoiceTextFld2: json["InvoiceTextFld2"],
        invoiceTextFld3: json["InvoiceTextFld3"],
        invoiceTextFld4: json["InvoiceTextFld4"],
        invoiceTax: json["InvoiceTax"],
        invoiceIncludedTax: json["InvoiceIncludedTax"],
        tax: json["Tax"],
        notes: json["Notes"],
        siteName: json["SiteName"],
        debit: json["Debit"],
        credit: json["Credit"],
        fact: json["Fact"],
        flag: json["Flag"],
        isInvoice: json["IsInvoice"],
        isClientPayment: json["IsClientPayment"],
        isJornal: json["IsJornal"],
        isNotePaper: json["IsNotePaper"],
        jornalParms: json["JornalParms"],
        typeId: json["TypeId"],
        items: json["Items"] == null
            ? []
            : List<dynamic>.from(json["Items"]!.map((x) => x)),
        balance: json["Balance"],
        businessUnitId: json["BusinessUnitId"],
        businessUnitName: json["BusinessUnitName"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ITName": itName,
        "ITName2": itName2,
        "Number": number,
        "Date": date?.toIso8601String(),
        // "ColDate": colDate,
        "InvoiceTotal": invoiceTotal,
        "InvoiceTotalExtra": invoiceTotalExtra,
        "InvoiceTotalDisc": invoiceTotalDisc,
        "InvoiceItemsDisc": invoiceItemsDisc,
        "NetDisc": netDisc,
        "InvoiceItemsExtra": invoiceItemsExtra,
        "NetExtra": netExtra,
        "Final": itemFinal,
        "InvoiceFirstPay": invoiceFirstPay,
        "InvoicePayType": invoicePayType,
        "InvoiceIsPosted": invoiceIsPosted,
        "InvoiceDirection": invoiceDirection,
        "InvoiceTextFld1": invoiceTextFld1,
        "InvoiceTextFld2": invoiceTextFld2,
        "InvoiceTextFld3": invoiceTextFld3,
        "InvoiceTextFld4": invoiceTextFld4,
        "InvoiceTax": invoiceTax,
        "InvoiceIncludedTax": invoiceIncludedTax,
        "Tax": tax,
        "Notes": notes,
        "SiteName": siteName,
        "Debit": debit,
        "Credit": credit,
        "Fact": fact,
        "Flag": flag,
        "IsInvoice": isInvoice,
        "IsClientPayment": isClientPayment,
        "IsJornal": isJornal,
        "IsNotePaper": isNotePaper,
        "JornalParms": jornalParms,
        "TypeId": typeId,
        "Items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
        "Balance": balance,
        "BusinessUnitId": businessUnitId,
        "BusinessUnitName": businessUnitName,
      };

  EntryModel toModel() {
    return EntryModel(
      id: id,
      itName: itName,
      itName2: itName2,
      number: number,
      date: date,
      // colDate: colDate,
      invoiceTotal: invoiceTotal,
      invoiceTotalExtra: invoiceTotalExtra,
      invoiceTotalDisc: invoiceTotalDisc,
      invoiceItemsDisc: invoiceItemsDisc,
      netDisc: netDisc,
      invoiceItemsExtra: invoiceItemsExtra,
      netExtra: netExtra,
      itemFinal: itemFinal,
      invoiceFirstPay: invoiceFirstPay,
      invoicePayType: invoicePayType,
      invoiceIsPosted: invoiceIsPosted,
      invoiceDirection: invoiceDirection,
      invoiceTax: invoiceTax,
      invoiceIncludedTax: invoiceIncludedTax,
      tax: tax,
      notes: notes,
      siteName: siteName,
      debit: debit,
      credit: credit,
      fact: fact,
      flag: flag,
      isInvoice: isInvoice,
      isClientPayment: isClientPayment,
      isJornal: isJornal,
      isNotePaper: isNotePaper,
      jornalParms: jornalParms,
      typeId: typeId,
      items: items,
      balance: balance,
      businessUnitId: businessUnitId,
      businessUnitName: businessUnitName,
    );
  }
}
