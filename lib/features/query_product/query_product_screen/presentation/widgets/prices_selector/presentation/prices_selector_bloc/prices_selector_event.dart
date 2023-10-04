part of 'prices_selector_bloc.dart';

sealed class PricesSelectorEvent extends Equatable {
  const PricesSelectorEvent();

  @override
  List<Object> get props => [];
}

final class PricesSelectorFetchDataEvent extends PricesSelectorEvent {}

final class PricesSelectorSelectedHasChangedEvent extends PricesSelectorEvent {
  final List<Price> selected;

  const PricesSelectorSelectedHasChangedEvent({required this.selected});

  @override
  List<Object> get props => [selected];
}
