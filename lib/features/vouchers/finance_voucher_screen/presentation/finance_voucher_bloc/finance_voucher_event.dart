// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'finance_voucher_bloc.dart';

sealed class FinanceVoucherEvent extends Equatable {
  const FinanceVoucherEvent();

  @override
  List<Object> get props => [];
}

class FinanceVoucherPaymentChangedEvent extends FinanceVoucherEvent {
  final PaymentMethod method;
  const FinanceVoucherPaymentChangedEvent({
    required this.method,
  });
  @override
  List<Object> get props => [method];
}

class FinanceVoucherDateChangedEvent extends FinanceVoucherEvent {
  final DateTime date;
  const FinanceVoucherDateChangedEvent({
    required this.date,
  });
  @override
  List<Object> get props => [date];
}

class FinanceVoucherSelectedCustomerChangedEvent extends FinanceVoucherEvent {
  final String customer;
  const FinanceVoucherSelectedCustomerChangedEvent({
    required this.customer,
  });
  @override
  List<Object> get props => [customer];
}

class FinanceVoucherFetchDataEvent extends FinanceVoucherEvent {
  final VoucherType voucherType;
  const FinanceVoucherFetchDataEvent({
    required this.voucherType,
  });
  @override
  List<Object> get props => [voucherType];
}

class FinanceVoucherClearFailureEvent extends FinanceVoucherEvent {}

class FinanceVoucherCurrencyChangedEvent extends FinanceVoucherEvent {
  final Currency currency;

  const FinanceVoucherCurrencyChangedEvent({
    required this.currency,
  });

  @override
  List<Object> get props => [currency];
}

class FinanceVoucherCreateVoucherEvent extends FinanceVoucherEvent {}

class FinanceVoucherAmountChangedEvent extends FinanceVoucherEvent {
  final String amount;
  const FinanceVoucherAmountChangedEvent({
    required this.amount,
  });
  @override
  List<Object> get props => [amount];
}

class FinanceVoucherClearSuccessEvent extends FinanceVoucherEvent {}
