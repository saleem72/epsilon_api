//

import 'package:get_it/get_it.dart';

import 'product_details_screen/data/data_source/product_details_service.dart';
import 'product_details_screen/data/repository/product_fetcher_repository.dart';
import 'product_details_screen/domain/repository/i_product_fetcher_repository.dart';
import 'product_details_screen/presentation/bloc/product_details_bloc.dart';

initProductDetails(GetIt locator) {
  locator.registerFactory(() => ProductDetailsBloc(repository: locator()));

  locator.registerLazySingleton(
      () => ProductDetailsService(apiHelper: locator(), safe: locator()));

  locator.registerLazySingleton<IProductFetcherRepository>(
    () => ProductFetcherRepository(
      networkInfo: locator(),
      service: locator(),
    ),
  );
}
