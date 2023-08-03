//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/data/data_source/product_details_service.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/product_datails.dart';

import '../../../../../../core/helpers/network_info/network_info.dart';
import '../../domain/failures/get_product_failure.dart';
import '../../domain/repository/i_product_fetcher_repository.dart';

class ProductFetcherRepository implements IProductFetcherRepository {
  final NetworkInfo _networkInfo;
  final ProductDetailsService _service;

  ProductFetcherRepository({
    required NetworkInfo networkInfo,
    required ProductDetailsService service,
  })  : _networkInfo = networkInfo,
        _service = service;

  @override
  Future<Either<GetProductFailure, ProductDetails>> getProductByBarcode({
    required String barcode,
  }) async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      return Left(GetProductFailure.noInternet());
    }

    try {
      final result = await _service.getProductDetails(barcode);
      return right(result.toProduct());
    } catch (e) {
      return left(GetProductFailure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<GetProductFailure, ProductDetails>> getProductBySerial({
    required String serial,
  }) async {
    // final isConnected = await _networkInfo.isConnected;
    // if (!isConnected) {
    //   return const Left(GetProductFailure.noInternet());
    // }
    // final query = await _sqlProvider.statementForSerial(serial);

    // final eitherConnection = await _connectionGetter.get();

    // return eitherConnection.fold(
    //   (l) => const Left(GetProductFailure.connectionFailure(message: '')),
    //   (cachedConnection) async {
    //     final result = await _connectionManager.executeStatmet(
    //         query: query, params: cachedConnection);
    //     return result.fold(
    //       (failure) {
    //         return Left(GetProductFailure.connectionFailure(
    //             message: failure.toString()));
    //       },
    //       (records) {
    //         return _mapToProductDetails(records);
    //       },
    //     );
    //   },
    // );

    throw UnimplementedError();
  }
}
