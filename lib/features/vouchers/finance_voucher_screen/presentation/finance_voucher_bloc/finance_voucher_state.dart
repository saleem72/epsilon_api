// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'finance_voucher_bloc.dart';

class FinanceVoucherState extends Equatable {
  const FinanceVoucherState({
    required this.method,
    required this.selectedDate,
    required this.customers,
    required this.selectedCustomer,
    required this.failure,
    required this.isLoading,
    required this.customerName,
    required this.currencies,
    required this.selectedCurrency,
  });

  final PaymentMethod method;
  final DateTime selectedDate;
  final List<CompactCustomer> customers;
  final CompactCustomer? selectedCustomer;
  final Failure? failure;
  final bool isLoading;
  final String customerName;
  final List<Currency> currencies;
  final Currency? selectedCurrency;
  @override
  List<Object?> get props => [
        method,
        selectedDate,
        customers,
        selectedCustomer,
        failure,
        isLoading,
        customerName,
        currencies,
        selectedCurrency,
      ];

  factory FinanceVoucherState.initial() => FinanceVoucherState(
        method: PaymentMethod.chash,
        selectedDate: DateTime.now(),
        customers: const [],
        selectedCustomer: null,
        failure: null,
        isLoading: false,
        customerName: '',
        currencies: const [],
        selectedCurrency: null,
      );

  FinanceVoucherState copyWith({
    PaymentMethod? method,
    DateTime? selectedDate,
    List<CompactCustomer>? customers,
    CompactCustomer? selectedCustomer,
    bool? clearSelectedCutomer,
    Failure? failure,
    bool? clearFailure,
    bool? isLoading,
    String? customerName,
    List<Currency>? currencies,
    bool? clearSelectedCurrency,
    Currency? selectedCurrency,
  }) {
    return FinanceVoucherState(
      method: method ?? this.method,
      selectedDate: selectedDate ?? this.selectedDate,
      customers: customers ?? this.customers,
      selectedCustomer: clearSelectedCutomer == true
          ? null
          : selectedCustomer ?? this.selectedCustomer,
      failure: clearFailure == true ? null : failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
      customerName: customerName ?? this.customerName,
      currencies: currencies ?? this.currencies,
      selectedCurrency: clearSelectedCurrency == true
          ? null
          : selectedCurrency ?? this.selectedCurrency,
    );
  }
}
