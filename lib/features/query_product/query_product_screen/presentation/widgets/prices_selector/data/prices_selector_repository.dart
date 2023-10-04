//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/features/login_screen/domain/failures/login_failure.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/data/prices_selector_service.dart';

import '../domain/i_prices_selector_repository.dart';

final class PricesSelectorRepository implements IPricesSelectorRepository {
  final PricesSelectorService _service;

  PricesSelectorRepository({required PricesSelectorService service})
      : _service = service;

  @override
  Future<Either<HttpFailure, List<Price>>> fetchPrices(
      String searchTerm) async {
    try {
      final data = await _service.fetchPrices(searchTerm);
      final prices = data.map((e) => e.toPrice()).toList();
      return right(prices);
    } catch (e) {
      return left(HttpFailure.unExpected(message: e.toString()));
    }
  }
}
