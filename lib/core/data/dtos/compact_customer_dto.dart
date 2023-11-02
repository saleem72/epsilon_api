//

// To parse this JSON data, do
//
//     final searchCustomerResponse = searchCompactCustomerResponse(jsonString);

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/compact_customer.dart';

SearchCompactCustomerResponse searchCompactCustomerResponse(String str) =>
    SearchCompactCustomerResponse.fromJson(json.decode(str));

class SearchCompactCustomerResponse {
  int? statusCode;
  String? message;
  CustomerDTOList? data;

  SearchCompactCustomerResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory SearchCompactCustomerResponse.fromJson(Map<String, dynamic> json) =>
      SearchCompactCustomerResponse(
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
  List<CompactCustomerDTO>? customers;

  CustomerDTOList({
    this.customers,
  });

  factory CustomerDTOList.fromJson(Map<String, dynamic> json) =>
      CustomerDTOList(
        customers: json["Customers"] == null
            ? []
            : List<CompactCustomerDTO>.from(
                json["Customers"]!.map((x) => CompactCustomerDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Customers": customers == null
            ? []
            : List<dynamic>.from(customers!.map((x) => x.toJson())),
      };
}

class CompactCustomerDTO {
  int? id;
  String? customerName;
  int? accountId;

  CompactCustomerDTO({
    this.id,
    this.customerName,
    this.accountId,
  });

  factory CompactCustomerDTO.fromJson(Map<String, dynamic> json) =>
      CompactCustomerDTO(
        id: json["Id"],
        customerName: json["CustomerName"],
        accountId: json["AccountId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "CustomerName": customerName,
        "AccountId": accountId,
      };

  CompactCustomer toCompactUser() {
    return CompactCustomer(
      id: id ?? 0,
      customerName: customerName ?? '',
      accountId: accountId ?? 0,
    );
  }
}
