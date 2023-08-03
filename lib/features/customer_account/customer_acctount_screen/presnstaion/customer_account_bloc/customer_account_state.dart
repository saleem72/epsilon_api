// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_account_bloc.dart';

abstract class CustomerAccountState extends Equatable {
  const CustomerAccountState();

  @override
  List<Object?> get props => [];
}

class CustomerAccountInitial extends CustomerAccountState {}

class CustomerAccountLoading extends CustomerAccountState {}

class CustomerAccountSuccess extends CustomerAccountState {
  final AccountBalance balance;
  const CustomerAccountSuccess({
    required this.balance,
  });
  @override
  List<Object?> get props => [balance];
}

class CustomerAccountFailure extends CustomerAccountState {
  final AccountBalanceFailure failure;
  const CustomerAccountFailure({
    required this.failure,
  });
  @override
  List<Object?> get props => [failure];
}
