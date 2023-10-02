// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_account_bloc.dart';

abstract class CustomerAccountEvent extends Equatable {
  const CustomerAccountEvent();
  factory CustomerAccountEvent.getBalance({required int id}) =>
      _GetBalance(id: id);
  @override
  List<Object> get props => [];
}

class _GetBalance extends CustomerAccountEvent {
  final int id;
  const _GetBalance({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
