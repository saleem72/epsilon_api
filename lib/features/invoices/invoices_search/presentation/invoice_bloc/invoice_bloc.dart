//
import 'dart:developer' as developer;
import 'dart:async';
import 'package:intl/intl.dart' as intl;

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/compact_product.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';
import 'package:epsilon_api/core/domian/models/invoice_ui_item.dart';
import 'package:epsilon_api/core/domian/models/new_invoice.dart';
import 'package:epsilon_api/core/domian/models/product_unit.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/invoices/invoices_search/domain/repository/i_invoice_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final IInvoiceRepository _repository;
  InvoiceBloc({required IInvoiceRepository repository})
      : _repository = repository,
        super(InvoiceState.initial()) {
    on<InvoiceFetchDataEvent>(_onFetchData);
    on<InvoiceFetchCustomersEvent>(_onFetchCustomers);
    on<InvoiceFetchProductsEvent>(_onFetchProducts);
    on<InvoiceClearFailureEvent>(_onClearFailure);
    on<InvoiceTypeChangedEvent>(_onSelectedInvoiceTypeChange);
    on<InvoiceSelectedCustomerChangedEvent>(_onSelectedCustomerChange);
    on<InvoiceDateChangedEvent>(_onDateChange);
    on<InvoiceSelectedProductChangedEvent>(_onSelectedProductChanged);
    on<InvoiceFetchProductUnitsEvent>(_onFetchProductUnits);
    on<InvoiceSelectedUnitChangedEvent>(_onSelectedUnitChange);
    on<InvoiceQuantityChangedEvent>(_onQuantityChange);
    on<InvoiceAddItemEvent>(_onAddItem);
    on<InvoiceClearItemRelatedEvent>(_onClearItemRelated);
    on<InvoiceRemoveItemEvent>(_onRemoveItem);
    on<InvoiceCreateInvoiceEvent>(_onCreateInvoice);
    on<InvoiceClearSuccessEvent>(_onClearSuccess);
  }

  FutureOr<void> _onFetchData(
      InvoiceFetchDataEvent event, Emitter<InvoiceState> emit) async {
    emit(state.copyWith(isLoading: true));
    final either = await _repository.fetchData();
    either.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        failure: failure,
      )),
      (data) => emit(state.copyWith(
        isLoading: false,
        customers: data.customers,
        products: data.products,
        invoiceTypes: data.invoiceTypes,
      )),
    );
  }

  FutureOr<void> _onFetchCustomers(
      InvoiceFetchCustomersEvent event, Emitter<InvoiceState> emit) async {
    final either = await _repository.getCustomers();
    either.fold(
      (failure) {
        print(failure);
      },
      (data) {
        print(data);
      },
    );
  }

  FutureOr<void> _onFetchProducts(
      InvoiceFetchProductsEvent event, Emitter<InvoiceState> emit) async {
    final either = await _repository.getProducts();
    either.fold(
      (failure) {
        print(failure);
      },
      (data) {
        print(data);
      },
    );
  }

  FutureOr<void> _onClearFailure(
      InvoiceClearFailureEvent event, Emitter<InvoiceState> emit) {
    emit(state.copyWith(clearFailure: true));
  }

  FutureOr<void> _onSelectedInvoiceTypeChange(
      InvoiceTypeChangedEvent event, Emitter<InvoiceState> emit) {
    emit(state.copyWith(selectedType: event.type));
  }

  CompactCustomer? _customerFromString(String text) {
    final customers = state.customers
        .where((element) => element.customerName == text)
        .toList();
    return customers.firstOrNull;
  }

  CompactProduct? _productFromString(String text) {
    final products =
        state.products.where((element) => element.name == text).toList();
    return products.firstOrNull;
  }

  FutureOr<void> _onSelectedCustomerChange(
      InvoiceSelectedCustomerChangedEvent event, Emitter<InvoiceState> emit) {
    final customer = _customerFromString(event.customer);
    if (customer == null) {
      emit(state.copyWith(clearSelectedCutomer: true));
    } else {
      emit(state.copyWith(
        selectedCustomer: customer,
        // customerName: event.customer,
      ));
    }
  }

  FutureOr<void> _onDateChange(
      InvoiceDateChangedEvent event, Emitter<InvoiceState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  FutureOr<void> _onSelectedProductChanged(
      InvoiceSelectedProductChangedEvent event, Emitter<InvoiceState> emit) {
    final product = _productFromString(event.product);
    if (product == null) {
      emit(state.copyWith(clearSelectedProduct: true, units: []));
    } else {
      emit(state.copyWith(
        selectedProduct: product,
        // customerName: event.customer,
      ));
      add(InvoiceFetchProductUnitsEvent(productId: product.id));
    }
  }

  FutureOr<void> _onFetchProductUnits(
      InvoiceFetchProductUnitsEvent event, Emitter<InvoiceState> emit) async {
    emit(state.copyWith(isLoading: true));
    final either = await _repository.fetchProductUnit(event.productId);
    either.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        failure: failure,
      )),
      (data) => emit(state.copyWith(
        isLoading: false,
        units: data,
      )),
    );
  }

  FutureOr<void> _onSelectedUnitChange(
      InvoiceSelectedUnitChangedEvent event, Emitter<InvoiceState> emit) {
    emit(state.copyWith(selectedUnit: event.unit));
  }

  FutureOr<void> _onQuantityChange(
      InvoiceQuantityChangedEvent event, Emitter<InvoiceState> emit) {
    int quantity = 0;
    if (event.quantity.trim().isEmpty) {
      quantity = 0;
    } else {
      quantity = int.tryParse(event.quantity) ?? 0;
    }

    emit(state.copyWith(quantity: quantity));
  }

  FutureOr<void> _onAddItem(
      InvoiceAddItemEvent event, Emitter<InvoiceState> emit) async {
    // print('typeId: ${state.selectedType?.id}');
    // print('itemId: ${state.selectedProduct?.id}');
    // print('unitId: ${state.selectedUnit?.id}');

    // final Safe safe = locator();
    // final token = safe.getToken();
    // print('token: $token');

    final canAdd = state.isThereItemToAdd();

    emit(state.copyWith(isLoading: true));
    final either = await _repository.fetchProductPrice(
      typeId: state.selectedType?.id ?? 0,
      itemId: state.selectedProduct?.id ?? 0,
      unitId: state.selectedUnit?.id ?? 0,
    );

    either.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (price) {
        if (canAdd) {
          final item = InvoiceUiItem(
            product: state.selectedProduct!,
            unit: state.selectedUnit!,
            quantity: state.quantity,
            price: price,
          );
          final items = state.invoiceItems.map((e) => e).toList();
          items.insert(0, item);
          emit(state.copyWith(
            isLoading: false,
            invoiceItems: items,
            hasAddedItem: true,
          ));
        }
      },
    );

    // if (canAdd) {
    //   final item = InvoiceUiItem(
    //     product: state.selectedProduct!,
    //     unit: state.selectedUnit!,
    //     quantity: state.quantity,
    //     price: 1000,
    //   );
    //   final items = state.invoiceItems.map((e) => e).toList();
    //   items.insert(0, item);
    //   emit(state.copyWith(
    //     isLoading: false,
    //     invoiceItems: items,
    //     hasAddedItem: true,
    //   ));
    // }
  }

  FutureOr<void> _onClearItemRelated(
      InvoiceClearItemRelatedEvent event, Emitter<InvoiceState> emit) {
    emit(state.copyWith(
        clearSelectedProduct: true,
        clearSelectedUnit: true,
        units: [],
        hasAddedItem: false));
  }

  FutureOr<void> _onRemoveItem(
      InvoiceRemoveItemEvent event, Emitter<InvoiceState> emit) {
    final items = state.invoiceItems
        .map((e) => e == event.item ? null : e)
        .whereType<InvoiceUiItem>()
        .toList();
    emit(state.copyWith(invoiceItems: items));
  }

  FutureOr<void> _onCreateInvoice(
      InvoiceCreateInvoiceEvent event, Emitter<InvoiceState> emit) async {
    final invoice = state.toInvoice();
    emit(state.copyWith(isLoading: true));
    final either = await _repository.createInvoice(invoice);
    either.fold(
      (failure) => emit(state.copyWith(failure: failure, isLoading: false)),
      (id) => emit(state.copyWith(
        addedSuccessfully: id,
        isLoading: false,
      )),
    );
  }

  FutureOr<void> _onClearSuccess(
      InvoiceClearSuccessEvent event, Emitter<InvoiceState> emit) {
    emit(state.copyWith(
      clearSuccess: true,
      clearSelectedCutomer: true,
      clearSelectedProduct: true,
      clearSelectedUnit: true,
      clearSelectedType: true,
      invoiceItems: [],
      units: [],
      quantity: 0,
      clearFailure: true,
    ));
  }
}
