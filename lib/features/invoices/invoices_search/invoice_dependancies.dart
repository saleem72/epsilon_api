//

import 'package:epsilon_api/features/invoices/invoices_search/data/repository/invoice_repository.dart';
import 'package:epsilon_api/features/invoices/invoices_search/data/service/invoice_service.dart';
import 'package:epsilon_api/features/invoices/invoices_search/domain/repository/i_invoice_repository.dart';
import 'package:get_it/get_it.dart';

initInvoiceDependancies() {
  final locator = GetIt.instance;

  locator.registerLazySingleton(
    () => InvoiceService(
      apiHelper: locator(),
      safe: locator(),
    ),
  );

  locator.registerLazySingleton<IInvoiceRepository>(
    () => InvoiceRepository(
      service: locator(),
    ),
  );
}
