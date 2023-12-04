//

import 'dart:async';

import 'package:epsilon_api/core/domian/models/price.dart';
import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/domain/i_prices_selector_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'prices_selector_event.dart';
part 'prices_selector_state.dart';

class PricesSelectorBloc
    extends Bloc<PricesSelectorEvent, PricesSelectorState> {
  final IPricesSelectorRepository _repository;
  final Safe _safe;
  PricesSelectorBloc({
    required IPricesSelectorRepository repository,
    required Safe safe,
  })  : _repository = repository,
        _safe = safe,
        super(PricesSelectorState.initial()) {
    on<PricesSelectorFetchDataEvent>(_onFetchData);
    on<PricesSelectorSelectedHasChangedEvent>(_onSelectedHasChanged);
  }

  FutureOr<void> _onFetchData(PricesSelectorFetchDataEvent event,
      Emitter<PricesSelectorState> emit) async {
    emit(state.copyWith(isLoading: true));
    final either = await _repository.fetchPrices('');
    either.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          error: l.toString(),
        ),
      ),
      (r) {
        final ids = _safe.getSavedPrices();
        final prices = r.where((element) => ids.contains(element.id)).toList();
        emit(state.copyWith(
          allPrices: r,
          selectedPrices: prices.isNotEmpty ? prices : r.take(2).toList(),
          isLoading: false,
        ));
      },
    );
  }

  _onSelectedHasChanged(PricesSelectorSelectedHasChangedEvent event,
      Emitter<PricesSelectorState> emit) {
    _safe.savePrices(pricesIds: event.selected.map((e) => e.id).toList());
    emit(state.copyWith(selectedPrices: event.selected));
  }
}
