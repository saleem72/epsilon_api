//

import 'dart:async';

import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'old_serach_event.dart';
part 'old_serach_state.dart';

class OldSearchBloc extends Bloc<OldSearchEvent, OldSearchState> {
  final Safe _safe;

  OldSearchBloc({
    required Safe safe,
  })  : _safe = safe,
        super(OldSearchState.initial(values: safe.getOldSearch())) {
    on<_RemoveFromOldSearch>(_onRemoveFromOldSearch);
    on<_SearchTermHasChanged>(_onSearchTermHasChanged);
    on<_ClearOldSearch>(_onClearOldSearch);
  }

  Future<List<String>> _modifyOldSearch(
      List<String> oldValues, String searchTerm) async {
    if (!oldValues.contains(searchTerm)) {
      oldValues.insert(0, searchTerm);
      await _safe.setOldSearch(oldValues);
      return _safe.getOldSearch();
    }
    return oldValues;
  }

  FutureOr<void> _onRemoveFromOldSearch(
      _RemoveFromOldSearch event, Emitter<OldSearchState> emit) async {
    if (state.oldSearch.contains(event.searchTerm)) {
      final values = state.oldSearch.map((e) => e).toList();
      values.remove(event.searchTerm);
      await _safe.setOldSearch(values);
      final newValues = _safe.getOldSearch();
      emit(state.copyWith(oldSearch: newValues));
    }
  }

  FutureOr<void> _onSearchTermHasChanged(
      _SearchTermHasChanged event, Emitter<OldSearchState> emit) async {
    final newValues = await _modifyOldSearch(state.oldSearch, event.searchTerm);

    emit(state.copyWith(oldSearch: newValues, searchTerm: event.searchTerm));
  }

  FutureOr<void> _onClearOldSearch(
      _ClearOldSearch event, Emitter<OldSearchState> emit) async {
    await _safe.clearOldSearch();
    emit(state.copyWith(oldSearch: []));
  }
}
