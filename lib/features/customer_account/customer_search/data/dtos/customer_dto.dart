//

import 'dart:convert';

import 'package:epsilon_api/core/extensions/dynamic_extension.dart';

import '../../domain/models/customer.dart';

List<CustomerDto> customerDtoFromJson(String str) => List<CustomerDto>.from(
    json.decode(str).map((x) => CustomerDto.fromJson(x)));

String customerDtoToJson(List<CustomerDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomersResponse {
  final List<CustomerDto> customers;
  CustomersResponse({
    required this.customers,
  });

  factory CustomersResponse.fromMap(Map<String, dynamic> map) {
    return CustomersResponse(
      customers: List<CustomerDto>.from(
        (map['customers'] as List<int>).map<CustomerDto>(
          (x) => CustomerDto.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory CustomersResponse.fromJson(String source) =>
      CustomersResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CustomerDto {
  double? number;
  String? customerName;
  String? nationality;
  String? phone1;
  String? phone2;
  String? fax;
  String? telex;
  String? notes;
  double? useFlag;
  String? checkDate;
  int? type;
  double? discRatio;
  double? defPrice;
  double? state;
  String? latinName;
  String? eMail;
  String? homePage;
  String? prefix;
  String? suffix;
  String? mobile;
  String? pager;
  String? guid;
  String? hoppies;
  String? gender;
  String? certificate;
  String? dateOfBirth;
  String? job;
  String? jobCategory;
  String? userFld1;
  String? userFld2;
  String? userFld3;
  String? userFld4;
  String? pictureGuid;
  String? accountGuid;
  String? barCode;
  bool? bHide;

  CustomerDto({
    this.number,
    this.customerName,
    this.nationality,
    this.phone1,
    this.phone2,
    this.fax,
    this.telex,
    this.notes,
    this.useFlag,
    this.checkDate,
    this.type,
    this.discRatio,
    this.defPrice,
    this.state,
    this.latinName,
    this.eMail,
    this.homePage,
    this.prefix,
    this.suffix,
    this.mobile,
    this.pager,
    this.guid,
    this.hoppies,
    this.gender,
    this.certificate,
    this.dateOfBirth,
    this.job,
    this.jobCategory,
    this.userFld1,
    this.userFld2,
    this.userFld3,
    this.userFld4,
    this.pictureGuid,
    this.accountGuid,
    this.barCode,
    this.bHide,
  });

  factory CustomerDto.fromJson(Map<String, dynamic> json) => CustomerDto(
        number: converttoDouble(json["Number"]),
        customerName: json["CustomerName"],
        nationality: json["Nationality"],
        phone1: json["Phone1"],
        phone2: json["Phone2"],
        fax: json["FAX"],
        telex: json["TELEX"],
        notes: json["Notes"],
        useFlag: converttoDouble(json["UseFlag"]),
        checkDate: json["CheckDate"],
        type: json["Type"],
        discRatio: converttoDouble(json["DiscRatio"]),
        defPrice: converttoDouble(json["DefPrice"]),
        state: converttoDouble(json["State"]),
        latinName: json["LatinName"],
        eMail: json["EMail"],
        homePage: json["HomePage"],
        prefix: json["Prefix"],
        suffix: json["Suffix"],
        mobile: json["Mobile"],
        pager: json["Pager"],
        guid: json["GUID"],
        hoppies: json["Hoppies"],
        gender: json["Gender"],
        certificate: json["Certificate"],
        dateOfBirth: json["DateOfBirth"],
        job: json["Job"],
        jobCategory: json["JobCategory"],
        userFld1: json["UserFld1"],
        userFld2: json["UserFld2"],
        userFld3: json["UserFld3"],
        userFld4: json["UserFld4"],
        pictureGuid: json["PictureGUID"],
        accountGuid: json["AccountGUID"],
        barCode: json["BarCode"],
        bHide: json["bHide"],
      );

  Map<String, dynamic> toJson() => {
        "Number": number,
        "CustomerName": customerName,
        "Nationality": nationality,
        "Phone1": phone1,
        "Phone2": phone2,
        "FAX": fax,
        "TELEX": telex,
        "Notes": notes,
        "UseFlag": useFlag,
        "CheckDate": checkDate,
        "Type": type,
        "DiscRatio": discRatio,
        "DefPrice": defPrice,
        "State": state,
        "LatinName": latinName,
        "EMail": eMail,
        "HomePage": homePage,
        "Prefix": prefix,
        "Suffix": suffix,
        "Mobile": mobile,
        "Pager": pager,
        "GUID": guid,
        "Hoppies": hoppies,
        "Gender": gender,
        "Certificate": certificate,
        "DateOfBirth": dateOfBirth,
        "Job": job,
        "JobCategory": jobCategory,
        "UserFld1": userFld1,
        "UserFld2": userFld2,
        "UserFld3": userFld3,
        "UserFld4": userFld4,
        "PictureGUID": pictureGuid,
        "AccountGUID": accountGuid,
        "BarCode": barCode,
        "bHide": bHide,
      };

  @override
  String toString() {
    return 'CustomerDto(number: $number, customerName: $customerName)';
  }

  Customer toCustomer() => Customer(
        guid: guid ?? '',
        number: number ?? 0,
        customerName: customerName ?? '',
        nationality: nationality ?? '',
        phone1: phone1 ?? '',
        phone2: phone2 ?? '',
        fax: fax ?? '',
        telex: telex ?? '',
        notes: notes ?? '',
      );
}
