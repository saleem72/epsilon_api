//

class NewInvoice {
  int id;
  List<BillItem> billItems;
  DateTime date;
  int billPayType;
  int typeId;
  int custId;
  double firstPay;
  String currCode;
  int discountRate;
  String number;
  double billFinal;
  double totalTax;
  int includedTotalTax;

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
  });
}

class BillItem {
  int index;
  int itemId;
  int unitId;
  int unitFact;
  int quanitity;
  double price;
  double bonus;

  BillItem({
    required this.index,
    required this.itemId,
    required this.unitId,
    required this.unitFact,
    required this.quanitity,
    required this.price,
    required this.bonus,
  });
}
