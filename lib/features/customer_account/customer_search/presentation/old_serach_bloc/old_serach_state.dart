// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'old_serach_bloc.dart';

class OldSearchState extends Equatable {
  final List<String> oldSearch;
  final String? searchTerm;
  const OldSearchState({
    required this.oldSearch,
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [oldSearch, searchTerm];

  factory OldSearchState.initial({required List<String> values}) =>
      OldSearchState(
        oldSearch: values,
        searchTerm: null,
      );

  OldSearchState copyWith({
    List<String>? oldSearch,
    String? searchTerm,
  }) {
    return OldSearchState(
      oldSearch: oldSearch ?? this.oldSearch,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
