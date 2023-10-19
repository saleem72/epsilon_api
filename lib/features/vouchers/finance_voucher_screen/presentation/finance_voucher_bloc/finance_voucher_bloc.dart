//

import 'dart:async';

import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/compact_customer.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/domain/repository/i_finance_voucher_repository.dart';
import 'package:epsilon_api/features/vouchers/models/payment_method.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'finance_voucher_event.dart';
part 'finance_voucher_state.dart';

class FinanceVoucherBloc
    extends Bloc<FinanceVoucherEvent, FinanceVoucherState> {
  final IFinanceVoucherRepository _repository;
  FinanceVoucherBloc({
    required IFinanceVoucherRepository repository,
  })  : _repository = repository,
        super(FinanceVoucherState.initial()) {
    on<FinanceVoucherPaymentChangedEvent>(_onPaymentChanged);
    on<FinanceVoucherDateChangedEvent>(_onDateChanged);
    on<FinanceVoucherSelectedCustomerChangedEvent>(onSelectedCustomerChanged);
    on<FinanceVoucherFetchDataEvent>(_onFetchData);
    on<FinanceVoucherClearFailureEvent>(_onClearFailure);
  }

  FutureOr<void> _onPaymentChanged(FinanceVoucherPaymentChangedEvent event,
      Emitter<FinanceVoucherState> emit) {
    emit(state.copyWith(method: event.method));
  }

  FutureOr<void> _onDateChanged(
      FinanceVoucherDateChangedEvent event, Emitter<FinanceVoucherState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  CompactCustomer? _customerFromString(String text) {
    final customers = state.customers
        .where((element) => element.customerName == text)
        .toList();
    return customers.firstOrNull;
  }

  FutureOr<void> onSelectedCustomerChanged(
      FinanceVoucherSelectedCustomerChangedEvent event,
      Emitter<FinanceVoucherState> emit) {
    final customer = _customerFromString(event.customer);
    if (customer == null) {
      emit(state.copyWith(clearSelectedCutomer: true));
    } else {
      emit(state.copyWith(
        selectedCustomer: customer,
        customerName: event.customer,
      ));
    }
  }

  FutureOr<void> _onFetchData(FinanceVoucherFetchDataEvent event,
      Emitter<FinanceVoucherState> emit) async {
    emit(state.copyWith(isLoading: true));
    final either = await _repository.getUsers();
    either.fold(
      (failure) => emit(state.copyWith(failure: failure, isLoading: false)),
      (customers) =>
          emit(state.copyWith(customers: customers, isLoading: false)),
    );
  }

  FutureOr<void> _onClearFailure(FinanceVoucherClearFailureEvent event,
      Emitter<FinanceVoucherState> emit) {
    emit(state.copyWith(clearFailure: true));
  }
}
