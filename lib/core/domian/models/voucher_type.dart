// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

enum VoucherCategory {
  recipient,
  payment;

  int get typeId => this == VoucherCategory.recipient ? 2 : 3;
}

class VoucherType extends Equatable {
  final int id;
  final String name;
  final String latinName;
  final bool fldDebit;
  final bool fldCredit;
  final int flag;
  const VoucherType({
    required this.id,
    required this.name,
    required this.latinName,
    required this.fldDebit,
    required this.fldCredit,
    required this.flag,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        latinName,
        fldDebit,
        fldCredit,
        flag,
      ];
}
