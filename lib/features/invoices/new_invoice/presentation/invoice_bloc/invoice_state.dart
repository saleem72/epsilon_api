// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'invoice_bloc.dart';

class InvoiceState extends Equatable {
  final bool isLoading;
  final List<CompactCustomer> customers;
  final List<CompactProduct> products;
  final List<InvoiceType> invoiceTypes;
  final Failure? failure;

  final InvoiceType? selectedType;
  final CompactCustomer? selectedCustomer;
  final CompactProduct? selectedProduct;
  final DateTime selectedDate;

  final List<ProductUnit> units;
  final ProductUnit? selectedUnit;

  final List<InvoiceUiItem> invoiceItems;

  final int quantity;

  final bool isItemReady;
  final bool isInvoiceReady;

  final bool showMain;

  final bool hasAddedItem;
  final int? addedSuccessfully;
  final String? invoiceNumber;
  final String? invoiceImage;

  double get invoiceSubTotal => invoiceItems.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity));

  double get invoiceTaxTotal => invoiceItems.fold(
      0, (previousValue, element) => previousValue + element.tax);

  double get invoiceTotal => invoiceSubTotal + invoiceTaxTotal;

  Uint8List? get memoryImage => invoiceImage == null
      ? null
      : const Base64Decoder().convert(invoiceImage!);

  const InvoiceState({
    required this.isLoading,
    required this.customers,
    required this.products,
    required this.invoiceTypes,
    required this.failure,
    required this.selectedType,
    required this.selectedCustomer,
    required this.selectedDate,
    required this.selectedProduct,
    required this.units,
    required this.selectedUnit,
    required this.quantity,
    required this.invoiceItems,
    required this.isItemReady,
    required this.hasAddedItem,
    required this.isInvoiceReady,
    required this.addedSuccessfully,
    required this.showMain,
    required this.invoiceNumber,
    required this.invoiceImage,
  });

  factory InvoiceState.initial() => InvoiceState(
        isLoading: false,
        customers: const [],
        products: const [],
        invoiceTypes: const [],
        failure: null,
        selectedType: null,
        selectedCustomer: null,
        selectedProduct: null,
        selectedDate: DateTime.now(),
        units: const [],
        selectedUnit: null,
        quantity: 0,
        invoiceItems: const [],
        isItemReady: false,
        hasAddedItem: false,
        isInvoiceReady: false,
        addedSuccessfully: null,
        showMain: true,
        invoiceNumber: null,
        invoiceImage: null,
      );

  @override
  List<Object?> get props => [
        isLoading,
        customers,
        products,
        invoiceTypes,
        failure,
        selectedType,
        selectedCustomer,
        selectedDate,
        selectedProduct,
        units,
        selectedUnit,
        quantity,
        invoiceItems,
        isItemReady,
        hasAddedItem,
        isInvoiceReady,
        addedSuccessfully,
        showMain,
        invoiceNumber,
        invoiceImage,
      ];

  InvoiceState copyWith({
    bool? isLoading,
    List<CompactCustomer>? customers,
    List<CompactProduct>? products,
    List<InvoiceType>? invoiceTypes,
    Failure? failure,
    bool clearFailure = false,
    InvoiceType? selectedType,
    bool clearSelectedType = false,
    CompactCustomer? selectedCustomer,
    CompactProduct? selectedProduct,
    bool clearSelectedCutomer = false,
    bool clearSelectedProduct = false,
    DateTime? selectedDate,
    List<ProductUnit>? units,
    ProductUnit? selectedUnit,
    bool clearSelectedUnit = false,
    int? quantity,
    List<InvoiceUiItem>? invoiceItems,
    // bool? isItemReady,
    bool? hasAddedItem,
    int? addedSuccessfully,
    String? invoiceNumber,
    bool clearSuccess = false,
    bool? showMain,
    String? invoiceImage,
  }) {
    return InvoiceState(
      isLoading: isLoading ?? this.isLoading,
      customers: customers ?? this.customers,
      products: products ?? this.products,
      invoiceTypes: invoiceTypes ?? this.invoiceTypes,
      failure: clearFailure ? null : failure ?? this.failure,
      selectedType:
          clearSelectedType ? null : selectedType ?? this.selectedType,
      selectedCustomer: clearSelectedCutomer
          ? null
          : selectedCustomer ?? this.selectedCustomer,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedProduct:
          clearSelectedProduct ? null : selectedProduct ?? this.selectedProduct,
      units: units ?? this.units,
      selectedUnit:
          clearSelectedUnit ? null : selectedUnit ?? this.selectedUnit,
      quantity: quantity ?? this.quantity,
      invoiceItems: invoiceItems ?? this.invoiceItems,
      isItemReady: _calsIfItemReady(
        clearSelectedProduct ? null : selectedProduct ?? this.selectedProduct,
        clearSelectedUnit ? null : selectedUnit ?? this.selectedUnit,
        quantity ?? this.quantity,
      ),
      hasAddedItem: hasAddedItem ?? this.hasAddedItem,
      isInvoiceReady: _calsIfInvoiceReady(
          clearSelectedType ? null : selectedType ?? this.selectedType,
          clearSelectedCutomer
              ? null
              : selectedCustomer ?? this.selectedCustomer,
          invoiceItems ?? this.invoiceItems),
      addedSuccessfully: clearSuccess == true
          ? null
          : addedSuccessfully ?? this.addedSuccessfully,
      showMain: showMain ?? this.showMain,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceImage: invoiceImage ?? this.invoiceImage,
    );
  }

  bool _calsIfItemReady(
      CompactProduct? tProduct, ProductUnit? tUnit, int tQuantity) {
    return tProduct != null && tUnit != null && tQuantity > 0;
  }

  bool _calsIfInvoiceReady(InvoiceType? tType, CompactCustomer? tCustomer,
      List<InvoiceUiItem> tItems) {
    return tType != null && tCustomer != null && tItems.isNotEmpty;
  }

  bool isThereItemToAdd() =>
      selectedProduct != null && selectedUnit != null && quantity > 0;

  NewInvoice toInvoice() {
    final date =
        '${intl.DateFormat('yyyy-MM-ddThh:mm:ss.SSS').format(selectedDate)}Z';
    return NewInvoice(
      id: 0,
      billItems: invoiceItems.map((e) => BillItem.fromUi(e)).toList(),
      date: date,
      billPayType: 0,
      typeId: selectedType!.id,
      custId: selectedCustomer!.id,
      firstPay: 0,
      currCode: '',
      discountRate: 0,
      number: '103',
      billFinal: 0,
      totalTax: 0,
      includedTotalTax: 0,
      image: null,
    );
  }
}
