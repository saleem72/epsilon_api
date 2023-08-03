//

class AccountBalance {
  List<Balance>? balance;
  List<Currency>? currency;

  AccountBalance({
    required this.balance,
    required this.currency,
  });
}

class Balance {
  String? accCode;
  String? accName;
  String? accLName;
  String? cuName;
  String? custLName;
  double? cuDefPrice;
  double? cuMaxDebit;
  double? debit;
  double? credit;
  double? prevBalance;
  double? balance;
  double? lastDebit;
  // Date
  DateTime? lastDebitDate;
  double? lastCredit;
  // Date
  DateTime? lastCreditDate;
  double? lastPay;
  // Date
  DateTime? lastPayDate;
  String? lastDebitNote;
  String? lastCreditNote;
  // Date
  DateTime? lastCheckDate;

  Balance({
    required this.accCode,
    required this.accName,
    required this.accLName,
    required this.cuName,
    required this.custLName,
    required this.cuDefPrice,
    required this.cuMaxDebit,
    required this.debit,
    required this.credit,
    required this.prevBalance,
    required this.balance,
    required this.lastDebit,
    required this.lastDebitDate,
    required this.lastCredit,
    required this.lastCreditDate,
    required this.lastPay,
    required this.lastPayDate,
    required this.lastDebitNote,
    required this.lastCreditNote,
    required this.lastCheckDate,
  });
}

class Currency {
  double? number;
  String? code;
  String? name;
  double? currencyVal;
  String? partName;
  double? partPrecision;
  // Date
  DateTime? date;
  double? security;
  String? latinName;
  String? latinPartName;
  String? guid;
  double? branchMask;
  String? pictureGuid;
  String? currencyIso;

  Currency({
    required this.number,
    required this.code,
    required this.name,
    required this.currencyVal,
    required this.partName,
    required this.partPrecision,
    required this.date,
    required this.security,
    required this.latinName,
    required this.latinPartName,
    required this.guid,
    required this.branchMask,
    required this.pictureGuid,
    required this.currencyIso,
  });
}
