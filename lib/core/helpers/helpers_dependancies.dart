//

import 'package:epsilon_api/core/helpers/safe.dart';
import 'package:get_it/get_it.dart';

import 'api_helper/data/http_api_helper.dart';
import 'api_helper/domain/api_helper.dart';
import 'network_info/network_info.dart';

initHelpers(GetIt locator) {
  // NetworkInfo
  locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(checker: locator()));

  // ApiHelper
  locator.registerLazySingleton<ApiHelper>(
    () => HttpApiHelper(client: locator(), networkInfo: locator()),
  );

  // Safe
  locator.registerLazySingleton(
    () => Safe(storage: locator()),
  );
}
