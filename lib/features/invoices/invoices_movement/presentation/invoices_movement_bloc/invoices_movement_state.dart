// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invoices_movement_bloc.dart';

class InvoicesMovementState extends Equatable {
  final bool isLoading;
  final List<CompactCustomer> customers;
  final List<InvoiceType> invoiceTypes;
  final Failure? failure;
  final List<SearchedInvoice> invoices;
  final InvoiceType? selectedType;
  final CompactCustomer? selectedCustomer;

  final DateTime startDate;
  final DateTime endDate;

  final bool isReady;
  const InvoicesMovementState({
    required this.isLoading,
    required this.customers,
    required this.invoiceTypes,
    required this.failure,
    required this.startDate,
    required this.endDate,
    required this.invoices,
    required this.selectedType,
    required this.selectedCustomer,
    required this.isReady,
  });

  @override
  List<Object?> get props => [
        isLoading,
        customers,
        invoiceTypes,
        failure,
        startDate,
        endDate,
        invoices,
        selectedType,
        selectedCustomer,
        isReady,
      ];

  factory InvoicesMovementState.initial() => InvoicesMovementState(
        isLoading: false,
        customers: const [],
        invoiceTypes: const [],
        failure: null,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        invoices: const [],
        selectedType: null,
        selectedCustomer: null,
        isReady: false,
      );

  InvoicesMovementState copyWith({
    bool? isLoading,
    List<CompactCustomer>? customers,
    List<InvoiceType>? invoiceTypes,
    Failure? failure,
    List<SearchedInvoice>? invoices,
    DateTime? startDate,
    DateTime? endDate,
    bool clearFailure = false,
    InvoiceType? selectedType,
    bool clearSelectedType = false,
    CompactCustomer? selectedCustomer,
    bool clearSelectedCustomer = false,
  }) {
    return InvoicesMovementState(
      isLoading: isLoading ?? this.isLoading,
      customers: customers ?? this.customers,
      invoiceTypes: invoiceTypes ?? this.invoiceTypes,
      failure: clearFailure ? null : failure ?? this.failure,
      invoices: invoices ?? this.invoices,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedType:
          clearSelectedType ? null : selectedType ?? this.selectedType,
      selectedCustomer: clearSelectedCustomer
          ? null
          : selectedCustomer ?? this.selectedCustomer,
      isReady: _checkIfReady(
        clearSelectedType ? null : selectedType ?? this.selectedType,
        clearSelectedCustomer
            ? null
            : selectedCustomer ?? this.selectedCustomer,
      ),
    );
  }

  _checkIfReady(InvoiceType? tType, CompactCustomer? tCustomer) {
    return tType != null && tCustomer != null;
  }

  SearchInvoicesRequest toRequest() => SearchInvoicesRequest(
        startDate: startDate,
        endDate: endDate,
        billType: selectedType?.id ?? 0,
        custId: selectedCustomer?.id ?? 0,
      );
}
