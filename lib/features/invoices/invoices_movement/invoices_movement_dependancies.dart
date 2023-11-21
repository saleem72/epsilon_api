//

import 'package:epsilon_api/features/invoices/invoices_movement/data/repositoty/invoices_movement_repository.dart';
import 'package:epsilon_api/features/invoices/invoices_movement/data/service/invoices_movment_service.dart';
import 'package:epsilon_api/features/invoices/invoices_movement/domian/repository/i_invoices_movement_repository.dart';
import 'package:epsilon_api/features/invoices/invoices_movement/presentation/invoices_movement_bloc/invoices_movement_bloc.dart';
import 'package:get_it/get_it.dart';

initInvoicesMovementDependancies() {
  final locator = GetIt.instance;

  locator.registerLazySingleton(
    () => InvoicesMovementService(
      apiHelper: locator(),
      safe: locator(),
    ),
  );

  locator.registerLazySingleton<IInvoicesMovementRepository>(
    () => InvoicesMovementRepository(
      service: locator(),
    ),
  );

  locator.registerFactory(
    () => InvoicesMovementBloc(
      repository: locator(),
    ),
  );
}
