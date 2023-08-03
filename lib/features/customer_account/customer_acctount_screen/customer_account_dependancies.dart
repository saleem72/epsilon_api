//

import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/data_source/customer_account_service.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/data/repository/account_balance_repository.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/domain/repository/i_account_balance_repository.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/presnstaion/customer_account_bloc/customer_account_bloc.dart';
import 'package:get_it/get_it.dart';

initCustomerAccountDependancies(GetIt locator) {
  locator.registerLazySingleton(() => CustomerAccountService(
        apiHelper: locator(),
      ));

  locator.registerLazySingleton<IAccountBalanceRepository>(
      () => AccountBalanceRepository(
            service: locator(),
          ));

  locator.registerFactory(() => CustomerAccountBloc(
        repository: locator(),
      ));
}
