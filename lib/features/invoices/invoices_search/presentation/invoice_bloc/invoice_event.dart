// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invoice_bloc.dart';

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class InvoiceFetchDataEvent extends InvoiceEvent {}

/// to remove
class InvoiceFetchCustomersEvent extends InvoiceEvent {}

/// to remove
class InvoiceFetchProductsEvent extends InvoiceEvent {}

class InvoiceClearFailureEvent extends InvoiceEvent {}

class InvoiceTypeChangedEvent extends InvoiceEvent {
  final InvoiceType type;
  const InvoiceTypeChangedEvent({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class InvoiceSelectedCustomerChangedEvent extends InvoiceEvent {
  final String customer;
  const InvoiceSelectedCustomerChangedEvent({
    required this.customer,
  });

  @override
  List<Object> get props => [customer];
}

class InvoiceSelectedProductChangedEvent extends InvoiceEvent {
  final String product;
  const InvoiceSelectedProductChangedEvent({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class InvoiceDateChangedEvent extends InvoiceEvent {
  final DateTime date;
  const InvoiceDateChangedEvent({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

class InvoiceFetchProductUnitsEvent extends InvoiceEvent {
  final int productId;
  const InvoiceFetchProductUnitsEvent({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

class InvoiceSelectedUnitChangedEvent extends InvoiceEvent {
  final ProductUnit unit;
  const InvoiceSelectedUnitChangedEvent({
    required this.unit,
  });
  @override
  List<Object> get props => [unit];
}

class InvoiceQuantityChangedEvent extends InvoiceEvent {
  final String quantity;
  const InvoiceQuantityChangedEvent({
    required this.quantity,
  });
  @override
  List<Object> get props => [quantity];
}

class InvoiceAddItemEvent extends InvoiceEvent {}

class InvoiceClearItemRelatedEvent extends InvoiceEvent {}

class InvoiceRemoveItemEvent extends InvoiceEvent {
  final InvoiceUiItem item;
  const InvoiceRemoveItemEvent({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

class InvoiceCreateInvoiceEvent extends InvoiceEvent {}

class InvoiceClearSuccessEvent extends InvoiceEvent {}
