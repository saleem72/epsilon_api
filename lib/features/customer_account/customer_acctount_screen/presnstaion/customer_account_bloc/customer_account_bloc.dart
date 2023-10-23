//

import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/core/domian/models/account_balance.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/repository/i_account_balance_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_account_event.dart';
part 'customer_account_state.dart';

class CustomerAccountBloc
    extends Bloc<CustomerAccountEvent, CustomerAccountState> {
  final IAccountBalanceRepository _repository;
  CustomerAccountBloc({
    required IAccountBalanceRepository repository,
  })  : _repository = repository,
        super(CustomerAccountInitial()) {
    on<_GetBalance>(_onGetBalance);
  }

  _onGetBalance(_GetBalance event, Emitter<CustomerAccountState> emit) async {
    emit(CustomerAccountLoading());
    final either = await _repository.getAccountBalance(event.id);

    either.fold(
      (l) => emit(CustomerAccountFailure(failure: l)),
      (r) => emit(CustomerAccountSuccess(balance: r)),
    );
  }
}
