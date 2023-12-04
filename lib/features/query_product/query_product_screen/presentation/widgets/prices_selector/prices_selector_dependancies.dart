//

import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/data/prices_selector_repository.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/data/prices_selector_service.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/presentation/prices_selector_bloc/prices_selector_bloc.dart';
import 'package:get_it/get_it.dart';

import 'domain/i_prices_selector_repository.dart';

initPricesSelectorDependancies() {
  final locator = GetIt.instance;
  locator.registerLazySingleton(() => PricesSelectorService(
        apiHelper: locator(),
        safe: locator(),
      ));
  locator.registerLazySingleton<IPricesSelectorRepository>(
    () => PricesSelectorRepository(
      service: locator(),
    ),
  );
  locator.registerFactory(
      () => PricesSelectorBloc(repository: locator(), safe: locator()));
}
