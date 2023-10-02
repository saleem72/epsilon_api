// To parse this JSON data, do
//
//     final productDto = productDtoFromJson(jsonString);

import 'dart:convert';

import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/product_datails.dart';

ProductDto productDtoFromJson(String str) =>
    ProductDto.fromJson(json.decode(str));

String productDtoToJson(ProductDto data) => json.encode(data.toJson());

class ProductDto {
  int? id;
  String? name;
  String? code;
  String? latinName;
  String? spec;
  dynamic heigh;
  dynamic low;
  String? origin;
  String? company;
  int? type;
  String? pos;
  String? dim;
  bool? expireFlag;
  dynamic productionFlag;
  bool? snFlag;
  bool? forceInSn;
  bool? forceOutSn;
  String? color;
  String? provenance;
  String? quality;
  String? model;
  bool? isAssembly;
  double? assemblyQty;
  int? unitId;
  String? unitName;
  double? unitFact;
  int? uRank;
  int? untId;
  dynamic document;
  int? serial;
  double? price;
  double? price2;

  ProductDto({
    this.id,
    this.name,
    this.code,
    this.latinName,
    this.spec,
    this.heigh,
    this.low,
    this.origin,
    this.company,
    this.type,
    this.pos,
    this.dim,
    this.expireFlag,
    this.productionFlag,
    this.snFlag,
    this.forceInSn,
    this.forceOutSn,
    this.color,
    this.provenance,
    this.quality,
    this.model,
    this.isAssembly,
    this.assemblyQty,
    this.unitId,
    this.unitName,
    this.unitFact,
    this.uRank,
    this.untId,
    this.document,
    this.serial,
    required this.price,
    this.price2,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
        id: json["Id"],
        name: json["Name"],
        code: json["Code"],
        latinName: json["LatinName"],
        spec: json["Spec"],
        heigh: json["Heigh"],
        low: json["Low"],
        origin: json["Origin"],
        company: json["Company"],
        type: json["Type"],
        pos: json["Pos"],
        dim: json["Dim"],
        expireFlag: json["ExpireFlag"],
        productionFlag: json["ProductionFlag"],
        snFlag: json["SNFlag"],
        forceInSn: json["ForceInSN"],
        forceOutSn: json["ForceOutSN"],
        color: json["Color"],
        provenance: json["Provenance"],
        quality: json["Quality"],
        model: json["Model"],
        isAssembly: json["IsAssembly"],
        assemblyQty: json["AssemblyQty"],
        unitId: json["UnitId"],
        unitName: json["UnitName"],
        unitFact: json["UnitFact"],
        uRank: json["URank"],
        untId: json["UntID"],
        document: json["Document"],
        serial: json["Serial"],
        price: json["Price"],
        price2: json["Price2"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Code": code,
        "LatinName": latinName,
        "Spec": spec,
        "Heigh": heigh,
        "Low": low,
        "Origin": origin,
        "Company": company,
        "Type": type,
        "Pos": pos,
        "Dim": dim,
        "ExpireFlag": expireFlag,
        "ProductionFlag": productionFlag,
        "SNFlag": snFlag,
        "ForceInSN": forceInSn,
        "ForceOutSN": forceOutSn,
        "Color": color,
        "Provenance": provenance,
        "Quality": quality,
        "Model": model,
        "IsAssembly": isAssembly,
        "AssemblyQty": assemblyQty,
        "UnitId": unitId,
        "UnitName": unitName,
        "UnitFact": unitFact,
        "URank": uRank,
        "UntID": untId,
        "Document": document,
        "Serial": serial,
        "Price": price,
        "Price2": price2,
      };

  ProductDetails toProduct() {
    return ProductDetails(
      id: id ?? 0,
      code: code ?? '',
      name: name ?? '',
      enduser: price ?? 0,
      unity: unitName ?? '',
      enduser2: price2 ?? 0,
      barcode: '',
      matunit: '',
      stores: [],
    );
  }
}
