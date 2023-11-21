// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:async';

import 'package:epsilon_api/core/data/dtos/search_invoices_request.dart';
import 'package:epsilon_api/core/domian/models/searched_invoice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/invoices/invoices_movement/domian/repository/i_invoices_movement_repository.dart';

part 'invoices_movement_event.dart';
part 'invoices_movement_state.dart';

class InvoicesMovementBloc
    extends Bloc<InvoicesMovementEvent, InvoicesMovementState> {
  final IInvoicesMovementRepository _repository;
  InvoicesMovementBloc({
    required IInvoicesMovementRepository repository,
  })  : _repository = repository,
        super(InvoicesMovementState.initial()) {
    on<InvoicesMovementFetchDataEvent>(_onFetchData);
    on<InvoicesMovementClearFailureEvent>(_onClearFailure);
    on<InvoicesMovementTypeChangedEvent>(_onTypeChanged);
    on<InvoicesMovementStartDateChangedEvent>(_onStartDateChanged);
    on<InvoicesMovementEndDateChangedEvent>(_onEndDateChanged);
    on<InvoicesMovementSelectedCustomerChangedEvent>(
        _onSelectedCustomerChanged);
    on<InvoicesMovementSearchInvoicesEvent>(_onSearchInvoices);
  }

  FutureOr<void> _onFetchData(InvoicesMovementFetchDataEvent event,
      Emitter<InvoicesMovementState> emit) async {
    emit(state.copyWith(isLoading: true));
    final either = await _repository.fetchData();
    either.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (data) => emit(state.copyWith(
        isLoading: false,
        customers: data.customers,
        invoiceTypes: data.invoiceTypes,
      )),
    );
  }

  FutureOr<void> _onClearFailure(InvoicesMovementClearFailureEvent event,
      Emitter<InvoicesMovementState> emit) {
    emit(state.copyWith(clearFailure: true));
  }

  FutureOr<void> _onTypeChanged(InvoicesMovementTypeChangedEvent event,
      Emitter<InvoicesMovementState> emit) {
    emit(state.copyWith(selectedType: event.type));
  }

  FutureOr<void> _onStartDateChanged(
      InvoicesMovementStartDateChangedEvent event,
      Emitter<InvoicesMovementState> emit) {
    emit(state.copyWith(startDate: event.date));
  }

  FutureOr<void> _onEndDateChanged(InvoicesMovementEndDateChangedEvent event,
      Emitter<InvoicesMovementState> emit) {
    emit(state.copyWith(endDate: event.date));
  }

  CompactCustomer? _customerFromString(String text) {
    final customers = state.customers
        .where((element) => element.customerName == text)
        .toList();
    return customers.firstOrNull;
  }

  FutureOr<void> _onSelectedCustomerChanged(
      InvoicesMovementSelectedCustomerChangedEvent event,
      Emitter<InvoicesMovementState> emit) {
    final customer = _customerFromString(event.customer);
    if (customer == null) {
      emit(state.copyWith(clearSelectedCustomer: true));
    } else {
      emit(state.copyWith(
        selectedCustomer: customer,
        // customerName: event.customer,
      ));
    }
  }

  FutureOr<void> _onSearchInvoices(InvoicesMovementSearchInvoicesEvent event,
      Emitter<InvoicesMovementState> emit) async {
    emit(state.copyWith(isLoading: true));
    final request = state.toRequest();
    final either = await _repository.searchForInvoices(request);
    either.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (data) => emit(state.copyWith(isLoading: false, invoices: data)),
    );
  }
}
