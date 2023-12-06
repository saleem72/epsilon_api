//

import 'package:epsilon_api/features/invoices/new_invoice/data/service/invoice_service.dart';
import 'package:epsilon_api/features/invoices/new_invoice/data/service/save_file_service.dart';
import 'package:epsilon_api/features/invoices/new_invoice/domain/repository/i_invoice_repository.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/invoice_repository.dart';

initInvoiceDependancies() {
  final locator = GetIt.instance;

  locator.registerLazySingleton(
    () => InvoiceService(
      apiHelper: locator(),
      safe: locator(),
    ),
  );

  locator.registerLazySingleton(() => SaveFileService());

  locator.registerLazySingleton<IInvoiceRepository>(
    () => InvoiceRepository(
      service: locator(),
    ),
  );
}
