//

/*
  {
  "EntryItems": [
    {
      "Custid": 0,
      "Accid": 0,
      "Debit": 0,
      "Credit": 0,
      "CurrCode": "string",
      "Date": "2023-10-19T07:23:58.431Z"
    }
  ],
  "Date": "2023-10-19T07:23:58.431Z",
  "TypeId": 0,
  "CurrCode": "string",
  "Number": "string"
}
*/

class NewVoucher {
  final List<NewVoucherItem> entryItems;
  final String date;
  final int typeId;
  final String currencyCode;
  final String number;
  NewVoucher({
    required this.entryItems,
    required this.date,
    required this.typeId,
    required this.currencyCode,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'EntryItems': entryItems.map((x) => x.toMap()).toList(),
      'Date': date,
      'TypeId': typeId,
      'CurrCode': currencyCode,
      'Number': number,
    };
  }

  factory NewVoucher.fromMap(Map<String, dynamic> map) {
    return NewVoucher(
      entryItems: List<NewVoucherItem>.from(
        (map['EntryItems'] as List<int>).map<NewVoucherItem>(
          (x) => NewVoucherItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: map['Date'] as String,
      typeId: map['TypeId'] as int,
      currencyCode: map['CurrCode'] as String,
      number: map['Number'] as String,
    );
  }
}

class NewVoucherItem {
  final int customerid;
  final int accountId;
  final double debit;
  final double credit;
  final String currencyCode;
  final String date;
  NewVoucherItem({
    required this.customerid,
    required this.accountId,
    required this.debit,
    required this.credit,
    required this.currencyCode,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Custid': customerid,
      'Accid': accountId,
      'Debit': debit,
      'Credit': credit,
      'CurrCode': currencyCode,
      'Date': date,
    };
  }

  factory NewVoucherItem.fromMap(Map<String, dynamic> map) {
    return NewVoucherItem(
      customerid: map['Custid'] as int,
      accountId: map['Accid'] as int,
      debit: map['Debit'] == null ? 0 : (map['Debit'] as num).toDouble(),
      credit: map['Credit'] == null ? 0 : (map['Credit'] as num).toDouble(),
      currencyCode: map['CurrCode'] as String,
      date: map['Date'] as String,
    );
  }
}
