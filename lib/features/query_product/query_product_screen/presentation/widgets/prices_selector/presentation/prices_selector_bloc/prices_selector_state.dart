// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prices_selector_bloc.dart';

class PricesSelectorState extends Equatable {
  const PricesSelectorState(
      {required this.isLoading,
      required this.allPrices,
      required this.selectedPrices,
      required this.error});

  final bool isLoading;
  final List<Price> allPrices;
  final List<Price> selectedPrices;
  final String? error;

  @override
  List<Object?> get props =>
      [isLoading, allPrices, selectedPrices, error, selectedPrices.length];

  PricesSelectorState copyWith({
    bool? isLoading,
    List<Price>? allPrices,
    List<Price>? selectedPrices,
    String? error,
  }) {
    return PricesSelectorState(
      isLoading: isLoading ?? this.isLoading,
      allPrices: allPrices ?? this.allPrices,
      selectedPrices: selectedPrices == null
          ? this.selectedPrices
          : selectedPrices.map((e) => e).toList(),
      error: error,
    );
  }

  factory PricesSelectorState.initial() => const PricesSelectorState(
        isLoading: false,
        allPrices: [],
        selectedPrices: [],
        error: null,
      );
}
