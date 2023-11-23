//

import 'package:epsilon_api/features/customer_account/customer_search/data/data_source/customer_search_service.dart';
import 'package:epsilon_api/features/customer_account/customer_search/data/repository/customer_search_repository.dart';
import 'package:epsilon_api/features/customer_account/customer_search/presentation/customer_search_bloc/customer_search_bloc.dart';
import 'package:epsilon_api/features/customer_account/customer_search/presentation/old_serach_bloc/old_serach_bloc.dart';
import 'package:get_it/get_it.dart';

import 'domain/repository/i_customer_search_repository.dart';

initCustomersDependancies(GetIt locator) {
  // service
  locator.registerLazySingleton(() => CustomerSearchService(
        apiHelper: locator(),
        safe: locator(),
      ));

  // repository
  locator.registerLazySingleton<ICustomerSearchRepository>(
      () => CustomerSearchRepository(
            service: locator(),
          ));

  // bloc
  locator.registerFactory(() => CustomerSearchBloc(
        repository: locator(),
      ));

  locator.registerFactory(() => OldSearchBloc(
        safe: locator(),
      ));
}
