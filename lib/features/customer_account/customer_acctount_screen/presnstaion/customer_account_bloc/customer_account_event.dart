// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_account_bloc.dart';

abstract class CustomerAccountEvent extends Equatable {
  const CustomerAccountEvent();
  factory CustomerAccountEvent.getBalance({required String guid}) =>
      _GetBalance(guid: guid);
  @override
  List<Object> get props => [];
}

class _GetBalance extends CustomerAccountEvent {
  final String guid;
  const _GetBalance({
    required this.guid,
  });

  @override
  List<Object> get props => [guid];
}
