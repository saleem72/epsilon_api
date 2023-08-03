//

import 'package:epsilon_api/features/customer_account/customer_search/domain/failures/customer_search_failure.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/customer.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/repository/i_customer_search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_search_event.dart';
part 'customer_search_state.dart';

class CustomerSearchBloc
    extends Bloc<CustomerSearchEvent, CustomerSearchState> {
  final ICustomerSearchRepository _repository;
  CustomerSearchBloc({
    required ICustomerSearchRepository repository,
  })  : _repository = repository,
        super(CustomerSearchInitial()) {
    on<_SearchByName>(_onSearchByName);
  }

  _onSearchByName(
      _SearchByName event, Emitter<CustomerSearchState> emit) async {
    final searchTerm = event.searchTerm;
    if (searchTerm.trim().isEmpty) {
      return;
    }
    emit(CustomerSearchLoading());
    final either = await _repository.searchCustomersByName(searchTerm);
    either.fold(
      (failure) {
        emit(CustomerSearchFailureState(failure: failure));
      },
      (customers) {
        emit(CustomerSearchSuccess(customers: customers));
      },
    );
  }
}
