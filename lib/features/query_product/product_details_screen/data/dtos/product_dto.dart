//

import 'dart:convert';

import 'package:epsilon_api/core/extensions/dynamic_extension.dart';

import '../../domain/models/product_datails.dart';

List<List<ProductByBarcodeDTO>> productFromJson(String str) =>
    List<List<ProductByBarcodeDTO>>.from(json.decode(str).map((x) =>
        List<ProductByBarcodeDTO>.from(
            x.map((x) => ProductByBarcodeDTO.fromJson(x)))));

class ProductDTOWithStores {
  final ProductDTO product;
  final List<StoreDTO> stores;
  ProductDTOWithStores({
    required this.product,
    required this.stores,
  });

  ProductDetails toProduct() {
    return ProductDetails(
      code: product.code,
      name: product.name ?? '',
      enduser: (product.price ?? 0),
      unity: product.unity ?? '',
      unit2: product.unit2 ?? '',
      enduser2: product.price2 ?? 0,
      barcode: product.barCode ?? '',
      matunit: (product.price2 ?? 0).toString(),
      stores: stores.map((e) => e.toStore()).toList(),
    );
  }
}

class ProductDTO {
  String code;
  double? number;
  String? name;
  String? latinName;
  String? barCode;
  String? codedCode;
  String? unity;
  String? spec;
  double? unitFact;
  String? unitName;
  double? price;
  double? priceType;
  double? sellType;
  double? bonusOne;
  double? currencyVal;
  double? useFlag;
  String? origin;
  String? company;
  double? type;
  String? lastPriceDate;
  double? bonus;
  String? unit2;
  double? unit2Fact;
  String? unit3;
  double? unit3Fact;
  double? flag;
  String? pos;
  String? dim;
  bool? expireFlag;
  bool? productionFlag;
  bool? unit2FactFlag;
  bool? unit3FactFlag;
  String? barCode2;
  String? barCode3;
  bool? snFlag;
  bool? forceInSn;
  bool? forceOutSn;
  double? vat;
  String? color;
  String? provenance;
  String? quality;
  String? model;
  String? guid;
  double? price2;
  ProductDTO({
    required this.code,
    required this.number,
    required this.name,
    required this.latinName,
    required this.barCode,
    required this.codedCode,
    required this.unity,
    required this.spec,
    required this.unitFact,
    required this.unitName,
    required this.price,
    required this.priceType,
    required this.sellType,
    required this.bonusOne,
    required this.currencyVal,
    required this.useFlag,
    required this.origin,
    required this.company,
    required this.type,
    required this.lastPriceDate,
    required this.bonus,
    required this.unit2,
    required this.unit2Fact,
    required this.unit3,
    required this.unit3Fact,
    required this.flag,
    required this.pos,
    required this.dim,
    required this.expireFlag,
    required this.productionFlag,
    required this.unit2FactFlag,
    required this.unit3FactFlag,
    required this.barCode2,
    required this.barCode3,
    required this.snFlag,
    required this.forceInSn,
    required this.forceOutSn,
    required this.vat,
    required this.color,
    required this.provenance,
    required this.quality,
    required this.model,
    required this.guid,
    required this.price2,
  });

  // Product toProduct() => Product(
  //       number: number?.toInt(),
  //       name: name,
  //       code: code,
  //       latinName: latinName,
  //       barCode: barCode,
  //       codedCode: codedCode,
  //       unity: unity,
  //       spec: spec,
  //       unitFact: unitFact?.toInt(),
  //       unitName: unitName,
  //       price: price?.toInt(),
  //       priceType: priceType?.toInt(),
  //       sellType: sellType?.toInt(),
  //       bonusOne: bonusOne?.toInt(),
  //       currencyVal: currencyVal?.toInt(),
  //       useFlag: useFlag?.toInt(),
  //       origin: origin,
  //       company: company,
  //       type: type?.toInt(),
  //       lastPriceDate: lastPriceDate,
  //       bonus: bonus?.toInt(),
  //       unit2: unit2,
  //       unit2Fact: unit2Fact?.toInt(),
  //       unit3: unit3,
  //       unit3Fact: unit3Fact?.toInt(),
  //       flag: flag?.toInt(),
  //       pos: pos,
  //       dim: dim,
  //       expireFlag: expireFlag,
  //       productionFlag: productionFlag,
  //       unit2FactFlag: unit2FactFlag,
  //       unit3FactFlag: unit3FactFlag,
  //       barCode2: barCode2,
  //       barCode3: barCode3,
  //       snFlag: snFlag,
  //       forceInSn: forceInSn,
  //       forceOutSn: forceOutSn,
  //       vat: vat?.toInt(),
  //       color: color,
  //       provenance: provenance,
  //       quality: quality,
  //       model: model,
  //       guid: guid,
  //       stores: [],
  //     );
}

class StoreDTO {
  double? price2;
  double? qty;
  String? stCode;
  String? stName;
  StoreDTO({
    required this.price2,
    required this.qty,
    required this.stCode,
    required this.stName,
  });

  StoreQuntity toStore() => StoreQuntity(
        store: stName ?? '',
        quantity: (qty ?? 0).toString(),
      );

  // Store toStore() => Store(
  //       price2: price2,
  //       qty: qty,
  //       stCode: stCode,
  //       stName: stName,
  //     );
}

class ProductByBarcodeDTO {
  double? number;
  String? name;
  String code;
  String? latinName;
  String? barCode;
  String? codedCode;
  String? unity;
  String? spec;
  double? unitFact;
  String? unitName;
  double? price;
  double? priceType;
  double? sellType;
  double? bonusOne;
  double? currencyVal;
  double? useFlag;
  String? origin;
  String? company;
  double? type;
  String? lastPriceDate;
  double? bonus;
  String? unit2;
  double? unit2Fact;
  String? unit3;
  double? unit3Fact;
  double? flag;
  String? pos;
  String? dim;
  bool? expireFlag;
  bool? productionFlag;
  bool? unit2FactFlag;
  bool? unit3FactFlag;
  String? barCode2;
  String? barCode3;
  bool? snFlag;
  bool? forceInSn;
  bool? forceOutSn;
  double? vat;
  String? color;
  String? provenance;
  String? quality;
  String? model;
  String? guid;
  double? price2;
  double? qty;
  String? stCode;
  String? stName;

  ProductByBarcodeDTO({
    this.number,
    this.name,
    required this.code,
    this.latinName,
    this.barCode,
    this.codedCode,
    this.unity,
    this.spec,
    this.unitFact,
    this.unitName,
    this.price,
    this.priceType,
    this.sellType,
    this.bonusOne,
    this.currencyVal,
    this.useFlag,
    this.origin,
    this.company,
    this.type,
    this.lastPriceDate,
    this.bonus,
    this.unit2,
    this.unit2Fact,
    this.unit3,
    this.unit3Fact,
    this.flag,
    this.pos,
    this.dim,
    this.expireFlag,
    this.productionFlag,
    this.unit2FactFlag,
    this.unit3FactFlag,
    this.barCode2,
    this.barCode3,
    this.snFlag,
    this.forceInSn,
    this.forceOutSn,
    this.vat,
    this.color,
    this.provenance,
    this.quality,
    this.model,
    this.guid,
    this.price2,
    this.qty,
    this.stCode,
    this.stName,
  });

  factory ProductByBarcodeDTO.fromJson(Map<String, dynamic> json) {
    return ProductByBarcodeDTO(
      number: converttoDouble(json["Number"]),
      name: json["Name"],
      code: json["Code"],
      latinName: json["LatinName"],
      barCode: json["BarCode"],
      codedCode: json["CodedCode"],
      unity: json["Unity"],
      spec: json["Spec"],
      unitFact: converttoDouble(json["UnitFact"]),
      unitName: json["UnitName"],
      price: converttoDouble(json["Price"]),
      priceType: converttoDouble(json["PriceType"]),
      sellType: converttoDouble(json["SellType"]),
      bonusOne: converttoDouble(json["BonusOne"]),
      currencyVal: converttoDouble(json["CurrencyVal"]),
      useFlag: converttoDouble(json["UseFlag"]),
      origin: json["Origin"],
      company: json["Company"],
      type: converttoDouble(json["Type"]),
      lastPriceDate: json["LastPriceDate"],
      bonus: converttoDouble(json["Bonus"]),
      unit2: json["Unit2"],
      unit2Fact: converttoDouble(json["Unit2Fact"]),
      unit3: json["Unit3"],
      unit3Fact: converttoDouble(json["Unit3Fact"]),
      flag: converttoDouble(json["Flag"]),
      pos: json["Pos"],
      dim: json["Dim"],
      expireFlag: json["ExpireFlag"],
      productionFlag: json["ProductionFlag"],
      unit2FactFlag: json["Unit2FactFlag"],
      unit3FactFlag: json["Unit3FactFlag"],
      barCode2: json["BarCode2"],
      barCode3: json["BarCode3"],
      snFlag: json["SNFlag"],
      forceInSn: json["ForceInSN"],
      forceOutSn: json["ForceOutSN"],
      vat: converttoDouble(json["VAT"]),
      color: json["Color"],
      provenance: json["Provenance"],
      quality: json["Quality"],
      model: json["Model"],
      guid: json["GUID"],
      price2: converttoDouble(json["Price2"]),
      qty: converttoDouble(json["Qty"]),
      stCode: json["stCode"],
      stName: json["stName"],
    );
  }

  ProductDTO toProductDTO() => ProductDTO(
        code: code,
        number: number,
        name: name,
        latinName: latinName,
        barCode: barCode,
        codedCode: codedCode,
        unity: unity,
        spec: spec,
        unitFact: unitFact,
        unitName: unitName,
        price: price,
        priceType: priceType,
        sellType: sellType,
        bonusOne: bonusOne,
        currencyVal: currencyVal,
        useFlag: useFlag,
        origin: origin,
        company: company,
        type: type,
        lastPriceDate: lastPriceDate,
        bonus: bonus,
        unit2: unit2,
        unit2Fact: unit2Fact,
        unit3: unit3,
        unit3Fact: unit3Fact,
        flag: flag,
        pos: pos,
        dim: dim,
        expireFlag: expireFlag,
        productionFlag: productionFlag,
        unit2FactFlag: unit2FactFlag,
        unit3FactFlag: unit3FactFlag,
        barCode2: barCode2,
        barCode3: barCode3,
        snFlag: snFlag,
        forceInSn: forceInSn,
        forceOutSn: forceOutSn,
        vat: vat,
        color: color,
        provenance: provenance,
        quality: quality,
        model: model,
        guid: guid,
        price2: price2,
      );

  StoreDTO toStoreDTO() => StoreDTO(
        price2: price2,
        qty: qty,
        stCode: stCode,
        stName: stName,
      );
}
