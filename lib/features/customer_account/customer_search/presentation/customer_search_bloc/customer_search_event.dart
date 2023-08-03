// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_search_bloc.dart';

abstract class CustomerSearchEvent extends Equatable {
  const CustomerSearchEvent();

  @override
  List<Object?> get props => [];

  factory CustomerSearchEvent.searchByName({required String searchTerm}) =>
      _SearchByName(searchTerm: searchTerm);
}

class _SearchByName extends CustomerSearchEvent {
  final String searchTerm;
  const _SearchByName({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}
