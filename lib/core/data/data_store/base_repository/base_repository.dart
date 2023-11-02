//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/data/data_store/base_service/base_service.dart';
import 'package:epsilon_api/core/domian/data_store/base_repository/i_base_repository.dart';
import 'package:epsilon_api/core/domian/models/compact_customer.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';

class BaseRepository implements IBaseRepository {
  final BaseService _service;

  BaseRepository({
    required BaseService service,
  }) : _service = service;

  String? _products;
  bool isFetchingProducts = false;
  Future<void>? gettingProducts;

  List<CompactCustomer>? _customers;
  bool isFetchingCustomers = false;
  Future<void>? gettingCustomers;

  DateTime? _currencies;
  bool isFetchingCurrencies = false;
  Future<void>? gettingCurrencies;

  Future<void> _fetchCustomers() async {
    isFetchingCustomers = true;
    final data = await _service.fetchCustomers();
    _customers = data;
    isFetchingCustomers = false;
  }

  Future<void> _fetchProducts() async {
    isFetchingProducts = true;
    final data = await _service.fetchProducts();
    _products = data;
    isFetchingProducts = false;
  }

  Future<void> _fetchCurrencies() async {
    isFetchingCurrencies = true;
    final data = await _service.fetchCurrencies();
    _currencies = data;
    isFetchingCurrencies = false;
  }

  void fetchData() {
    gettingProducts = _fetchProducts().then((value) => value);

    gettingCustomers = _fetchCustomers().then((value) => value);

    gettingCurrencies = _fetchCurrencies().then((value) => value);
  }

  @override
  Future<Either<Failure, String>> getProducts() async {
    try {
      if (isFetchingProducts && gettingProducts != null) {
        final _ = await gettingProducts!;

        gettingProducts = null;
      }
      return _products == null
          ? left(const UnExpectedFailure(message: 'Not ready'))
          : right(_products!);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<CompactCustomer>>> getCustomers() async {
    try {
      if (isFetchingCustomers && gettingCustomers != null) {
        final _ = await gettingCustomers!;

        gettingCustomers = null;
      }
      return _customers == null
          ? left(const UnExpectedFailure(message: 'Not ready'))
          : right(_customers!);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  @override
  Future<Either<Failure, DateTime>> getCurrencies() async {
    try {
      if (isFetchingCurrencies && gettingCurrencies != null) {
        final _ = await gettingCurrencies!;

        gettingCustomers = null;
      }
      return _currencies == null
          ? left(const UnExpectedFailure(message: 'Not ready'))
          : right(_currencies!);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
