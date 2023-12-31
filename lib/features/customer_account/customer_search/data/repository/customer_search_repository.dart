// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/domian/models/customer.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';

import 'package:epsilon_api/features/customer_account/customer_search/data/data_source/customer_search_service.dart';

import '../../domain/repository/i_customer_search_repository.dart';

class CustomerSearchRepository implements ICustomerSearchRepository {
  final CustomerSearchService _service;
  CustomerSearchRepository({
    required CustomerSearchService service,
  }) : _service = service;
  @override
  Future<Either<Failure, List<Customer>>> searchCustomersByName(
      String searchTerm) async {
    try {
      final list = await _service.searchCustomersByName(searchTerm);
      final result = list.map((e) => e.toCustomer()).toList();
      return right(result);
    } catch (e) {
      return left(e.toFailure());
    }
  }
}
