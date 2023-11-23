part of 'old_serach_bloc.dart';

sealed class OldSearchEvent extends Equatable {
  const OldSearchEvent();

  @override
  List<Object?> get props => [];
  factory OldSearchEvent.searchTermHasChanged({required String searchTerm}) =>
      _SearchTermHasChanged(searchTerm: searchTerm);

  factory OldSearchEvent.removeFromOldSearch({required String searchTerm}) =>
      _RemoveFromOldSearch(searchTerm: searchTerm);
  factory OldSearchEvent.clearOldSearch() => _ClearOldSearch();
}

class _SearchTermHasChanged extends OldSearchEvent {
  final String searchTerm;
  const _SearchTermHasChanged({
    required this.searchTerm,
  });
  @override
  List<Object?> get props => [searchTerm];
}

class _RemoveFromOldSearch extends OldSearchEvent {
  final String searchTerm;
  const _RemoveFromOldSearch({
    required this.searchTerm,
  });
  @override
  List<Object?> get props => [searchTerm];
}

class _ClearOldSearch extends OldSearchEvent {}
