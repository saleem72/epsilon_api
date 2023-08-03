// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

abstract class AccountBalanceFailure extends Equatable {
  final String? message;
  const AccountBalanceFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class GeneralAccountBalanceFailure extends AccountBalanceFailure {
  const GeneralAccountBalanceFailure({
    required String message,
  }) : super(message);
}
