//

import 'package:epsilon_api/core/domian/models/invoice_ui_item.dart';

class NewInvoice {
  int id;
  List<BillItem> billItems;
  String date;
  int billPayType;
  int typeId;
  int custId;
  double firstPay;
  String currCode;
  double discountRate;
  String number;
  double billFinal;
  double totalTax;
  int includedTotalTax;
  String? image;

  NewInvoice({
    required this.id,
    required this.billItems,
    required this.date,
    required this.billPayType,
    required this.typeId,
    required this.custId,
    required this.firstPay,
    required this.currCode,
    required this.discountRate,
    required this.number,
    required this.billFinal,
    required this.totalTax,
    required this.includedTotalTax,
    required this.image,
  });
  // "2023-11-15T10:14:08.333Z"
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "Id": 0,
      "billItems": List<dynamic>.from(billItems.map((x) => x.toMap())),
      "Date": date,
      "BillPayType": 0,
      "TypeId": typeId,
      "CustId": custId,
      "FirstPay": 0,
      "CurrCode": "",
      "DiscountRate": 0,
      "Number": "",
      "Final": 0,
      "TotalTax": 0,
      "IncludedTotalTax": 0
    };
  }

  double get subTotal => billItems.fold(
      0, (previousValue, element) => previousValue + element.total);
}

class BillItem {
  int index;
  int itemId;
  int unitId;
  double unitFact;
  int quanitity;
  double price;
  double bonus;

  double get total => quanitity * price;

  BillItem({
    required this.index,
    required this.itemId,
    required this.unitId,
    required this.unitFact,
    required this.quanitity,
    required this.price,
    required this.bonus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "Index": index,
      "ItemId": itemId,
      "UnitId": unitId,
      "UnitFact": unitFact,
      "Quanitity": quanitity,
      "Price": price,
      "Bonus": 0
    };
  }

  factory BillItem.fromUi(InvoiceUiItem item) => BillItem(
        index: 0,
        itemId: item.product.id,
        unitId: item.unit.id,
        unitFact: item.unit.fact,
        quanitity: item.quantity,
        price: item.price,
        bonus: 0,
      );
}
