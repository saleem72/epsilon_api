//

import 'package:dartz/dartz.dart';
import 'package:epsilon_api/core/data/dtos/search_invoices_request.dart';
import 'package:epsilon_api/core/domian/models/Invoices_movement_primary_data.dart';
import 'package:epsilon_api/core/domian/models/searched_invoice.dart';
import 'package:epsilon_api/core/errors/failure.dart';

abstract class IInvoicesMovementRepository {
  Future<Either<Failure, InvoicesMovementPrimaryData>> fetchData();
  Future<Either<Failure, List<SearchedInvoice>>> searchForInvoices(
      SearchInvoicesRequest request);
}
