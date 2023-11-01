//

import 'dart:async';

import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/domian/models/currency.dart';
import 'package:epsilon_api/core/domian/models/new_voucher.dart';
import 'package:epsilon_api/core/domian/models/payment_method.dart';
import 'package:epsilon_api/core/domian/models/voucher_type.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/domain/repository/i_finance_voucher_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

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
    on<FinanceVoucherCurrencyChangedEvent>(_onCurrencyChange);
    on<FinanceVoucherCreateVoucherEvent>(_onCreateVoucher);
    on<FinanceVoucherAmountChangedEvent>(_onAmountChanged);
    on<FinanceVoucherClearSuccessEvent>(_onClearSuccess);
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
    emit(state.copyWith(
      isLoading: true,
      voucherType: event.voucherType,
    ));
    // final Future<Either<Failure, List<Currency>>> currenciesReq =
    //     _repository.getCurrency();
    // final Future<Either<Failure, List<CompactCustomer>>> usersReq =
    //     _repository.getUsers();
    // final results = await Future.wait([currenciesReq, usersReq]);
    // final currenciesEither = results[0];
    // final usersEither = results[1];
    // List<Currency> currencies = [];
    // List<CompactCustomer> users = [];
    // Failure? error;
    // currenciesEither.fold(
    //   (failure) => error = failure,
    //   (data) => currencies = data as List<Currency>,
    // );
    // usersEither.fold(
    //   (failure) => error = failure,
    //   (data) => users = data as List<CompactCustomer>,
    // );
    final either = await _repository.fetchData();
    either.fold(
      (failure) => emit(state.copyWith(failure: failure, isLoading: false)),
      (data) => emit(state.copyWith(
        customers: data.customers,
        currencies: data.currencies,
        isLoading: false,
      )),
    );
  }

  FutureOr<void> _onClearFailure(FinanceVoucherClearFailureEvent event,
      Emitter<FinanceVoucherState> emit) {
    emit(state.copyWith(clearFailure: true));
  }

  FutureOr<void> _onCurrencyChange(FinanceVoucherCurrencyChangedEvent event,
      Emitter<FinanceVoucherState> emit) {
    emit(state.copyWith(selectedCurrency: event.currency));
  }

  FutureOr<void> _onCreateVoucher(FinanceVoucherCreateVoucherEvent event,
      Emitter<FinanceVoucherState> emit) async {
    final entry = state.toVoucher().toMap();
    emit(state.copyWith(isLoading: true));
    final either = await _repository.createVoucher(entry: entry);
    either.fold(
      (failure) => emit(state.copyWith(
        failure: failure,
        isLoading: false,
      )),
      (number) => emit(state.copyWith(
        addedSuccessfully: number,
        isLoading: false,
      )),
    );
  }

  FutureOr<void> _onAmountChanged(FinanceVoucherAmountChangedEvent event,
      Emitter<FinanceVoucherState> emit) {
    double amount = 0;
    if (event.amount.trim().isEmpty) {
      amount = 0;
    } else {
      amount = double.tryParse(event.amount) ?? 0;
    }

    emit(state.copyWith(amount: amount));
  }

  FutureOr<void> _onClearSuccess(FinanceVoucherClearSuccessEvent event,
      Emitter<FinanceVoucherState> emit) {
    emit(state.copyWith(
      clearSuccess: true,
      clearSelectedCurrency: true,
      clearSelectedCutomer: true,
      amount: 0,
      clearFailure: true,
      // voucherType: state.voucherType,
      // customers: state.customers,
      // currencies: state.currencies,
    ));
  }
}


// {
//   "Message":"The request entity's media type 'text/plain' is not supported for this resource."
//   }

//  {
//   "StatusCode":500,
//   "Message":"Object reference not set to an instance of an object.","Data":"   at EpsilonWebApi.Models.Entry.GetEntryWrapper(String Guid)\r\n   at EpsilonWebApi.Controllers.EntryController.AddEntry(Entry entry)\r\n   at lambda_method(Closure , Object , Object[] )\r\n   at System.Web.Http.Controllers.ReflectedHttpActionDescriptor.ActionExecutor.<>c__DisplayClass6_2.<GetExecutor>b__2(Object instance, Object[] methodParameters)\r\n   at System.Web.Http.Controllers.ReflectedHttpActionDescriptor.ExecuteAsync(HttpControllerContext controllerContext, IDictionary`2 arguments, CancellationToken cancellationToken)\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Controllers.ApiControllerActionInvoker.<InvokeActionAsyncCore>d__1.MoveNext()\r\n--- End of stack trace from previ"
//  }