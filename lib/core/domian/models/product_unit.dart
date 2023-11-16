// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

class ProductUnit extends Equatable {
  final int id;
  final String name;
  final double fact;
  const ProductUnit({
    required this.id,
    required this.name,
    required this.fact,
  });

  @override
  List<Object?> get props => [id, name, fact];
}
