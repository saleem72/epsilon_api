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
    required this.voucherCategory,
    required this.isValid,
    required this.amount,
    required this.addedSuccessfully,
    required this.notes,
    required this.voucherTypes,
    required this.selectedType,
  });

  final PaymentMethod method;
  final DateTime selectedDate;
  final List<VoucherType> voucherTypes;
  final VoucherType? selectedType;
  final List<CompactCustomer> customers;
  final CompactCustomer? selectedCustomer;
  final Failure? failure;
  final bool isLoading;
  final String customerName;
  final List<Currency> currencies;
  final Currency? selectedCurrency;
  final VoucherCategory? voucherCategory;
  final bool isValid;
  final double amount;
  final int? addedSuccessfully;
  final String notes;

  List<VoucherType> get availableTypes =>
      voucherCategory == VoucherCategory.recipient
          ? voucherTypes.where((element) => element.fldCredit == true).toList()
          : voucherTypes.where((element) => element.fldDebit == true).toList();

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
        isValid,
        amount,
        addedSuccessfully,
        notes,
        voucherCategory,
        voucherTypes,
        selectedType,
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
        voucherCategory: null,
        isValid: false,
        amount: 0,
        addedSuccessfully: null,
        notes: '',
        voucherTypes: const [],
        selectedType: null,
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
    VoucherCategory? voucherCategory,
    double? amount,
    int? addedSuccessfully,
    bool? clearSuccess,
    String? notes,
    List<VoucherType>? voucherTypes,
    VoucherType? selectedType,
    bool clearSelectedType = false,
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
      voucherCategory: voucherCategory ?? this.voucherCategory,
      amount: amount ?? this.amount,
      addedSuccessfully: clearSuccess == true
          ? null
          : addedSuccessfully ?? this.addedSuccessfully,
      isValid: _checkStatus(
        customer: clearSelectedCutomer == true
            ? null
            : selectedCustomer ?? this.selectedCustomer,
        currency: clearSelectedCurrency == true
            ? null
            : selectedCurrency ?? this.selectedCurrency,
        tVoucherType:
            clearSelectedType ? null : selectedType ?? this.selectedType,
        amount: amount ?? this.amount,
      ),
      notes: notes ?? this.notes,
      voucherTypes: voucherTypes ?? this.voucherTypes,
      selectedType:
          clearSelectedType ? null : selectedType ?? this.selectedType,
    );
  }

  bool _checkStatus(
      {CompactCustomer? customer,
      Currency? currency,
      required double amount,
      VoucherType? tVoucherType}) {
    final hasCustomer = customer != null;
    final hasCurrency = currency != null;
    final hasType = tVoucherType != null;
    final validAmount = amount > 0;
    return hasCurrency && hasCustomer && validAmount && hasType;
  }

  NewVoucher toVoucher() {
    final date =
        '${intl.DateFormat('yyyy-MM-ddThh:mm:ss.SSS').format(selectedDate)}Z';
    return NewVoucher(
      entryItems: [
        NewVoucherItem(
          customerid: selectedCustomer?.id ?? 0,
          accountId: selectedCustomer?.accountId ?? 0,
          debit: voucherCategory == VoucherCategory.recipient ? 0 : amount,
          credit: voucherCategory == VoucherCategory.recipient ? amount : 0,
          currencyCode: selectedCurrency?.code ?? '',
          date: date,
          note: notes,
          note2: notes,
        ),
      ],
      date: date,
      typeId: selectedType?.id ?? 1, // voucherCategory?.typeId ?? 1,
      currencyCode: selectedCurrency?.code ?? '',
      number: '',
      note: notes,
    );
  }

  // Map<String, String> toMap() {
  //   final date =
  //       '${intl.DateFormat('yyyy-MM-ddThh:mm:ss.SSS').format(selectedDate)}Z';
  //   return {
  //     "EntryItems": '''[
  //   {
  //     "Custid": ${selectedCustomer?.id ?? 0},
  //     "Accid": ${selectedCustomer?.accountId ?? 0},
  //     "Debit": ${voucherType == VoucherType.recipient ? 0 : amount},
  //     "Credit": ${voucherType == VoucherType.recipient ? amount : 0},
  //     "CurrCode": '"${selectedCurrency?.code ?? ''}"',
  //     "Date": $date
  //   }
  // ]''',
  //     "Date": date,
  //     "TypeId": (voucherType?.typeId ?? 1).toString(),
  //     "CurrCode": '"${selectedCurrency?.code ?? ''}"',
  //     "Number": ""
  //   };
  // }
}
