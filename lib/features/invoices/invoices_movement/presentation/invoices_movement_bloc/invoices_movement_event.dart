part of 'invoices_movement_bloc.dart';

sealed class InvoicesMovementEvent extends Equatable {
  const InvoicesMovementEvent();

  @override
  List<Object> get props => [];
}

class InvoicesMovementFetchDataEvent extends InvoicesMovementEvent {}

class InvoicesMovementClearFailureEvent extends InvoicesMovementEvent {}

class InvoicesMovementTypeChangedEvent extends InvoicesMovementEvent {
  final InvoiceType type;

  const InvoicesMovementTypeChangedEvent({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class InvoicesMovementStartDateChangedEvent extends InvoicesMovementEvent {
  final DateTime date;
  const InvoicesMovementStartDateChangedEvent({
    required this.date,
  });
  @override
  List<Object> get props => [date];
}

class InvoicesMovementEndDateChangedEvent extends InvoicesMovementEvent {
  final DateTime date;
  const InvoicesMovementEndDateChangedEvent({
    required this.date,
  });
  @override
  List<Object> get props => [date];
}

class InvoicesMovementSelectedCustomerChangedEvent
    extends InvoicesMovementEvent {
  final String customer;
  const InvoicesMovementSelectedCustomerChangedEvent({required this.customer});

  @override
  List<Object> get props => [customer];
}

class InvoicesMovementSearchInvoicesEvent extends InvoicesMovementEvent {}
