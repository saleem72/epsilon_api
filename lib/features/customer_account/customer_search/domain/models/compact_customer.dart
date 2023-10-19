// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

class CompactCustomer extends Equatable {
  final int id;
  final String customerName;
  final int accountId;

  const CompactCustomer({
    required this.id,
    required this.customerName,
    required this.accountId,
  });

  @override
  List<Object> get props => [id, customerName];

  @override
  String toString() => 'CompactCustomer(id: $id, name: $customerName)';
}
