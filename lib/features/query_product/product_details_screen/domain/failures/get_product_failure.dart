// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

abstract class GetProductFailure extends Equatable {
  const GetProductFailure();
  factory GetProductFailure.noInternet() => _NoInternt();
  factory GetProductFailure.connectionFailure({required String message}) =>
      _ConnectionFailure(message: message);
  factory GetProductFailure.productNotFound() => _ProductNotFound();
  factory GetProductFailure.invalidResponse() = _InvalidResponse;
  factory GetProductFailure.unexpected({required String message}) =>
      _Unexpected(message: message);
  factory GetProductFailure.fromException(Object exception) {
    return _Unexpected(message: exception.toString());
  }
  @override
  List<Object?> get props => [];
}

class _NoInternt extends GetProductFailure {}

class _ConnectionFailure extends GetProductFailure {
  final String message;
  const _ConnectionFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class _ProductNotFound extends GetProductFailure {}

class _InvalidResponse extends GetProductFailure {}

class _Unexpected extends GetProductFailure {
  final String message;
  const _Unexpected({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
