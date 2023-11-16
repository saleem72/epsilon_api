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
      "Date": "2023-11-05T08:56:02.593Z",
      "Note": "string",
      "Note2": "string"
    }
  ],
  "Date": "2023-11-05T08:56:02.593Z",
  "TypeId": 0,
  "CurrCode": "string",
  "Number": "string",
  "Note": "string"
}
*/

class NewVoucher {
  final List<NewVoucherItem> entryItems;
  final String date;
  final int typeId;
  final String currencyCode;
  final String number;
  final String note;
  NewVoucher({
    required this.entryItems,
    required this.date,
    required this.typeId,
    required this.currencyCode,
    required this.number,
    required this.note,
  });
//
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'EntryItems': List<dynamic>.from(entryItems.map((x) => x.toMap())),
      'Date': date,
      'TypeId': typeId,
      'CurrCode': currencyCode,
      'Number': number,
      "Note": note,
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
      note: map['Note'] as String,
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
  final String note;
  final String note2;
  NewVoucherItem(
      {required this.customerid,
      required this.accountId,
      required this.debit,
      required this.credit,
      required this.currencyCode,
      required this.date,
      required this.note,
      required this.note2});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Custid': customerid,
      'Accid': accountId,
      'Debit': debit,
      'Credit': credit,
      'CurrCode': currencyCode,
      'Date': date,
      'Note': note,
      'Note2': note2,
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
      note: map['Note'] as String,
      note2: map['Note2'] as String,
    );
  }
}

// {
//   "EntryItems": [
//     {
//       "Custid":1,
//       "Accid":71,
//       "Debit":222.0,
//       "Credit":0.0,
//       "CurrCode":"$",
//       "Date":"2023-10-24T02:21:32.194Z"
//     }
//   ],
//   "Date": 2023-10-24T02:21:32.194Z,
//   "TypeId": 1,
//   "CurrCode": $,
//   "Number": ''
//   }
