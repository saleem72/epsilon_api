//

import 'package:epsilon_api/features/login_screen/presentation/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/blocs/auth_bloc/auth_bloc.dart';
import 'data/data_source/i_login_service.dart';
import 'data/data_source/login_service.dart';
import 'data/repository/login_repository_impl.dart';
import 'domain/repository/login_repository.dart';
import 'domain/usecases/validate_password.dart';
import 'domain/usecases/validate_username.dart';

initLoginDependancies(GetIt locator) {
  // Bloc
  locator.registerFactory(() => LoginBloc(
        repository: locator(),
        usernameValidator: locator(),
        passwordValidator: locator(),
      ));

  // Repository
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        service: locator(),
      ));

  // Service
  locator.registerLazySingleton<ILoginService>(
      () => LoginService(apiHelper: locator()));

  locator.registerLazySingleton(() => ValidateUsername());
  locator.registerLazySingleton(() => ValidatePassword());

  locator.registerLazySingleton(() => AuthBloc(safe: locator()));
}
