// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

class CompanyInfo extends Equatable {
  final int id;
  final String name;
  final String? phone;
  final String? address;

  const CompanyInfo({
    required this.id,
    required this.name,
    this.phone,
    this.address,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        address,
      ];

  factory CompanyInfo.example() => const CompanyInfo(
        id: 0,
        name: 'Coders DC',
        phone: '0983 567 981',
        address: 'Damas Bramkeh',
      );

  @override
  String toString() => '''CompanyInfo(
    id: $id, 
    name $name,
    phone ${phone ?? ""},
    address ${address ?? ""},
    )''';
}
