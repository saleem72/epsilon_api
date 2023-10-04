// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_search_bloc.dart';

abstract class CustomerSearchState extends Equatable {
  const CustomerSearchState();

  @override
  List<Object> get props => [];
}

class CustomerSearchInitial extends CustomerSearchState {}

class CustomerSearchLoading extends CustomerSearchState {}

class CustomerSearchSuccess extends CustomerSearchState {
  final List<Customer> customers;
  const CustomerSearchSuccess({
    required this.customers,
  });

  @override
  List<Object> get props => [customers];
}

class CustomerSearchFailureState extends CustomerSearchState {
  final Failure failure;
  const CustomerSearchFailureState({
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}
