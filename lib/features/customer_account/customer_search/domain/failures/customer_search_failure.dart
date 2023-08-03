// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

abstract class CustomerSearchFailure extends Equatable {
  const CustomerSearchFailure();
  @override
  List<Object?> get props => [];
}

class CustomerSearchGeneralFailure extends CustomerSearchFailure {
  final String message;
  const CustomerSearchGeneralFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
