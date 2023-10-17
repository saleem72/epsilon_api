// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

class CompactCustomer extends Equatable {
  final int id;
  final double number;
  final String customerName;

  const CompactCustomer({
    required this.id,
    required this.number,
    required this.customerName,
  });

  @override
  List<Object> get props => [id, number, customerName];

  @override
  String toString() => 'CompactCustomer(id: $id, name: $customerName)';
}
