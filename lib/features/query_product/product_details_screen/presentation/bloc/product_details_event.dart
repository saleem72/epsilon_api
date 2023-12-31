//

part of 'product_details_bloc.dart';

class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
  factory ProductDetailsEvent.getProduct({required BarcodeOrSerial product}) =>
      _GetProduct(product: product);
  factory ProductDetailsEvent.getProductBySerial({required Serial serial}) =>
      _GetProductBySerial(serial: serial);
  factory ProductDetailsEvent.getProductByBarcode({required Barcode barcode}) =>
      _GetProductByBarcode(barcode: barcode);
  factory ProductDetailsEvent.clearError() = _ClearError;

  @override
  List<Object?> get props => [];
}

class _GetProduct extends ProductDetailsEvent {
  final BarcodeOrSerial product;
  const _GetProduct({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}

class _GetProductBySerial extends ProductDetailsEvent {
  final Serial serial;
  const _GetProductBySerial({
    required this.serial,
  });
  @override
  List<Object?> get props => [serial];
}

class _GetProductByBarcode extends ProductDetailsEvent {
  final Barcode barcode;
  const _GetProductByBarcode({
    required this.barcode,
  });
  @override
  List<Object?> get props => [barcode];
}

class _ClearError extends ProductDetailsEvent {}
