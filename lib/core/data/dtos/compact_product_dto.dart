// ignore_for_file: public_member_api_docs, sort_constructors_first
//

// To parse this JSON data, do
//
//     final searchCustomerResponse = searchCompactCustomerResponse(jsonString);

import 'dart:convert';

FetchCompactProductResponse fetchCompactProductResponse(String str) =>
    FetchCompactProductResponse.fromJson(json.decode(str));

class FetchCompactProductResponse {
  int? statusCode;
  String? message;
  CompactProductList? data;

  FetchCompactProductResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory FetchCompactProductResponse.fromJson(Map<String, dynamic> json) =>
      FetchCompactProductResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : CompactProductList.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class CompactProductList {
  final List<CompactProductDTO> products;

  CompactProductList({
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Products': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }

  factory CompactProductList.fromJson(Map<String, dynamic> json) =>
      CompactProductList(
        products: json["Products"] == null
            ? []
            : List<CompactProductDTO>.from(
                json["Products"]!.map((x) => CompactProductDTO.fromJson(x))),
      );
}

class CompactProductDTO {
  final int? id;
  final String? name;

  CompactProductDTO({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Id': id,
      'Name': name,
    };
  }

  factory CompactProductDTO.fromJson(Map<String, dynamic> map) {
    return CompactProductDTO(
      id: map['id'] != null ? map['Id'] as int : null,
      name: map['name'] != null ? map['Name'] as String : null,
    );
  }
}
