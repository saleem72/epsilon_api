// To parse this JSON data, do
//
//     final searchCustomerResponse = searchCustomerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/customer.dart';

SearchCustomerResponse searchCustomerResponseFromJson(String str) =>
    SearchCustomerResponse.fromJson(json.decode(str));

String searchCustomerResponseToJson(SearchCustomerResponse data) =>
    json.encode(data.toJson());

class SearchCustomerResponse {
  int? statusCode;
  String? message;
  CustomerDTOList? data;

  SearchCustomerResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory SearchCustomerResponse.fromJson(Map<String, dynamic> json) =>
      SearchCustomerResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : CustomerDTOList.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class CustomerDTOList {
  List<CustomerDTO>? customers;

  CustomerDTOList({
    this.customers,
  });

  factory CustomerDTOList.fromJson(Map<String, dynamic> json) =>
      CustomerDTOList(
        customers: json["Customers"] == null
            ? []
            : List<CustomerDTO>.from(
                json["Customers"]!.map((x) => CustomerDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Customers": customers == null
            ? []
            : List<dynamic>.from(customers!.map((x) => x.toJson())),
      };
}

class CustomerDTO {
  int? id;
  String? customerName;
  String? code;
  int? accountId;
  String? certificate;
  String? name;
  String? email;
  dynamic defPrice;
  String? nationality;
  String? address;
  String? phone1;
  String? phone2;
  String? fax;
  String? telex;
  String? latinName;
  int? currencyId;
  dynamic taxDef;
  dynamic taxSubscripeNumber;
  String? mobile;
  String? pager;
  String? country;
  String? hoppies;
  String? gender;
  String? certificate1;
  dynamic dateOfBirth;
  String? job;
  String? jobCategory;
  String? userFld1;
  String? userFld2;
  String? userFld3;
  String? userFld4;
  String? barCode;
  bool? bHide;
  String? notes;
  int? currencyId1;

  CustomerDTO({
    this.id,
    this.customerName,
    this.code,
    this.accountId,
    this.certificate,
    this.name,
    this.email,
    this.defPrice,
    this.nationality,
    this.address,
    this.phone1,
    this.phone2,
    this.fax,
    this.telex,
    this.latinName,
    this.currencyId,
    this.taxDef,
    this.taxSubscripeNumber,
    this.mobile,
    this.pager,
    this.country,
    this.hoppies,
    this.gender,
    this.certificate1,
    this.dateOfBirth,
    this.job,
    this.jobCategory,
    this.userFld1,
    this.userFld2,
    this.userFld3,
    this.userFld4,
    this.barCode,
    this.bHide,
    this.notes,
    this.currencyId1,
  });

  factory CustomerDTO.fromJson(Map<String, dynamic> json) => CustomerDTO(
        id: json["Id"],
        customerName: json["CustomerName"],
        code: json["Code"],
        accountId: json["AccountId"],
        certificate: json["Certificate"],
        name: json["Name"],
        email: json["Email"],
        defPrice: json["DefPrice"],
        nationality: json["Nationality"],
        address: json["Address"],
        phone1: json["Phone1"],
        phone2: json["Phone2"],
        fax: json["FAX"],
        telex: json["TELEX"],
        latinName: json["LatinName"],
        currencyId: json["CurrencyId"],
        taxDef: json["TaxDef"],
        taxSubscripeNumber: json["TaxSubscripeNumber"],
        mobile: json["Mobile"],
        pager: json["Pager"],
        country: json["Country"],
        hoppies: json["Hoppies"],
        gender: json["Gender"],
        certificate1: json["Certificate1"],
        dateOfBirth: json["DateOfBirth"],
        job: json["Job"],
        jobCategory: json["JobCategory"],
        userFld1: json["UserFld1"],
        userFld2: json["UserFld2"],
        userFld3: json["UserFld3"],
        userFld4: json["UserFld4"],
        barCode: json["BarCode"],
        bHide: json["bHide"],
        notes: json["Notes"],
        currencyId1: json["CurrencyId1"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "CustomerName": customerName,
        "Code": code,
        "AccountId": accountId,
        "Certificate": certificate,
        "Name": name,
        "Email": email,
        "DefPrice": defPrice,
        "Nationality": nationality,
        "Address": address,
        "Phone1": phone1,
        "Phone2": phone2,
        "FAX": fax,
        "TELEX": telex,
        "LatinName": latinName,
        "CurrencyId": currencyId,
        "TaxDef": taxDef,
        "TaxSubscripeNumber": taxSubscripeNumber,
        "Mobile": mobile,
        "Pager": pager,
        "Country": country,
        "Hoppies": hoppies,
        "Gender": gender,
        "Certificate1": certificate1,
        "DateOfBirth": dateOfBirth,
        "Job": job,
        "JobCategory": jobCategory,
        "UserFld1": userFld1,
        "UserFld2": userFld2,
        "UserFld3": userFld3,
        "UserFld4": userFld4,
        "BarCode": barCode,
        "bHide": bHide,
        "Notes": notes,
        "CurrencyId1": currencyId1,
      };

  Customer toCustomer() {
    return Customer(
      id: id ?? 0,
      number: 0,
      customerName: customerName ?? '',
      nationality: nationality ?? '',
      phone1: phone1 ?? '',
      phone2: phone2 ?? '',
      fax: fax ?? '',
      telex: telex ?? '',
      notes: notes ?? '',
    );
  }

  CompactCustomer toCompactUser() {
    return CompactCustomer(
      id: id ?? 0,
      customerName: customerName ?? '',
      accountId: accountId ?? 0,
    );
  }
}
