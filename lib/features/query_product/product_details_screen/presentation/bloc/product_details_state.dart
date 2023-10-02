// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  factory ProductDetailsState.initial() => ProductDetailsInitial();
  factory ProductDetailsState.loading() => ProductDetailsLoading();
  factory ProductDetailsState.withSuccess(ProductDetails product) =>
      ProductDetailsWithSuccess(product: product);
  factory ProductDetailsState.withFailure(GetProductFailure failure) =>
      ProductDetailsWithFailure(failure: failure);
  factory ProductDetailsState.withSearchSuccess(
          List<ProductDetails> products) =>
      ProductDetailsSearchName(products: products);

  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsWithSuccess extends ProductDetailsState {
  final ProductDetails product;
  const ProductDetailsWithSuccess({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}

class ProductDetailsWithFailure extends ProductDetailsState {
  final GetProductFailure failure;
  const ProductDetailsWithFailure({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

class ProductDetailsSearchName extends ProductDetailsState {
  final List<ProductDetails> products;
  const ProductDetailsSearchName({
    required this.products,
  });

  @override
  List<Object?> get props => [products];
}
