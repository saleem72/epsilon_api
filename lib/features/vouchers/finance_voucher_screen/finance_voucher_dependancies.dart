//

import 'package:epsilon_api/features/vouchers/finance_voucher_screen/data/datasource/finance_voucher_service.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/data/repository/finance_voucher_repository.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/domain/repository/i_finance_voucher_repository.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/presentation/finance_voucher_bloc/finance_voucher_bloc.dart';
import 'package:get_it/get_it.dart';

initFinanceVoucherDependancies(GetIt locator) {
  locator.registerLazySingleton(() => FinanceVoucherService(
        apiHelper: locator(),
        safe: locator(),
      ));
  // repository
  locator.registerLazySingleton<IFinanceVoucherRepository>(
      () => FinanceVoucherRepository(
            service: locator(),
            miscService: locator(),
          ));

  // bloc
  locator.registerFactory(() => FinanceVoucherBloc(
        repository: locator(),
      ));
}
