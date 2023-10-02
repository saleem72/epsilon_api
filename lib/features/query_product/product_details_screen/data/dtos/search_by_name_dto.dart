// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final searchByNameDto = searchByNameDtoFromJson(jsonString);

import 'dart:convert';

import 'product_dto.dart';

class SearchByNameResponse {
  final int statusCode;
  final String message;
  final SearchByNameDto data;

  SearchByNameResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SearchByNameResponse.fromMap(Map<String, dynamic> map) {
    return SearchByNameResponse(
      statusCode: map['StatusCode'] as int,
      message: map['Message'] as String,
      data: SearchByNameDto.fromJson(map['Data'] as Map<String, dynamic>),
    );
  }

  factory SearchByNameResponse.fromJson(String source) =>
      SearchByNameResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

SearchByNameDto searchByNameDtoFromJson(String str) =>
    SearchByNameDto.fromJson(json.decode(str));

String searchByNameDtoToJson(SearchByNameDto data) =>
    json.encode(data.toJson());

class SearchByNameDto {
  List<ProductDto>? products;

  SearchByNameDto({
    this.products,
  });

  factory SearchByNameDto.fromJson(Map<String, dynamic> json) =>
      SearchByNameDto(
        products: json["Products"] == null
            ? []
            : List<ProductDto>.from(
                json["Products"]!.map((x) => ProductDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class SearchProductDTO {
  String? code;
  String? id;
  String? name;
  bool? expireFlag;
  String? latinName;
  String? spec;
  String? origin;
  String? company;
  int? type;
  String? pos;
  String? dim;
  bool? expireFlag1;
  bool? productionFlag;
  bool? snFlag;
  bool? forceInSn;
  bool? forceOutSn;
  String? color;
  String? provenance;
  String? quality;
  String? model;
  int? unitId;
  String? unitName;
  // double? unitFact;
  // double? uRank;
  int? untId;
  String? document;
  String? barcodes;
  String? idd;
  bool? qtyIsInt;
  bool? isAssembly;
  // double? assemblyQty;

  SearchProductDTO({
    this.code,
    this.id,
    this.name,
    this.expireFlag,
    this.latinName,
    this.spec,
    this.origin,
    this.company,
    this.type,
    this.pos,
    this.dim,
    this.expireFlag1,
    this.productionFlag,
    this.snFlag,
    this.forceInSn,
    this.forceOutSn,
    this.color,
    this.provenance,
    this.quality,
    this.model,
    this.unitId,
    this.unitName,
    // this.unitFact,
    // this.uRank,
    this.untId,
    this.document,
    this.barcodes,
    this.idd,
    this.qtyIsInt,
    this.isAssembly,
    // this.assemblyQty,
  });

  factory SearchProductDTO.fromJson(Map<String, dynamic> json) =>
      SearchProductDTO(
        code: json["Code"],
        id: (json["Id"] is int) ? (json["Id"] as int).toString() : json["Id"],
        name: json["Name"],
        expireFlag: json["ExpireFlag"],
        latinName: json["LatinName"],
        spec: json["Spec"],
        origin: json["Origin"],
        company: json["Company"],
        type: json["Type"],
        pos: json["Pos"],
        dim: json["Dim"],
        expireFlag1: json["ExpireFlag1"],
        productionFlag: json["ProductionFlag"],
        snFlag: json["SNFlag"],
        forceInSn: json["ForceInSN"],
        forceOutSn: json["ForceOutSN"],
        color: json["Color"],
        provenance: json["Provenance"],
        quality: json["Quality"],
        model: json["Model"],
        unitId: json["UnitId"],
        unitName: json["UnitName"],
        // unitFact: json["UnitFact"],
        // uRank: json["URank"],
        untId: json["UntID"],
        document: json["Document"],
        barcodes: json["Barcodes"],
        idd: json["IDD"],
        qtyIsInt: json["QtyIsInt"],
        isAssembly: json["IsAssembly"],
        // assemblyQty: json["AssemblyQty"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Id": id,
        "Name": name,
        "ExpireFlag": expireFlag,
        "LatinName": latinName,
        "Spec": spec,
        "Origin": origin,
        "Company": company,
        "Type": type,
        "Pos": pos,
        "Dim": dim,
        "ExpireFlag1": expireFlag1,
        "ProductionFlag": productionFlag,
        "SNFlag": snFlag,
        "ForceInSN": forceInSn,
        "ForceOutSN": forceOutSn,
        "Color": color,
        "Provenance": provenance,
        "Quality": quality,
        "Model": model,
        "UnitId": unitId,
        "UnitName": unitName,
        // "UnitFact": unitFact,
        // "URank": uRank,
        "UntID": untId,
        "Document": document,
        // "TaxDef": taxDef,
        "Barcodes": barcodes,
        "IDD": idd,
        "QtyIsInt": qtyIsInt,
        "IsAssembly": isAssembly,
        // "AssemblyQty": assemblyQty,
        // "AssembleAllowAddItem": assembleAllowAddItem,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
