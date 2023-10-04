//

import 'package:epsilon_api/core/helpers/helpers_dependancies.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/customer_account_dependancies.dart';
import 'package:epsilon_api/features/customer_account/customer_search/customers_dependancies.dart';
import 'package:epsilon_api/features/login_screen/login_dependancies.dart';
import 'package:epsilon_api/features/query_product/product_details_dependancies.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/prices_selector_dependancies.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initDependancies() async {
  // Features
  // Login
  initLoginDependancies(locator);

  // Customers
  initCustomersDependancies(locator); //

  initCustomerAccountDependancies(locator);

  // // Product Details
  initProductDetails(locator);

  initPricesSelectorDependancies();

  // // App common Helpers
  initHelpers(locator);

  // External
  // Shared Preferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);

  // http.Client
  locator.registerLazySingleton(() => http.Client());

  // Internet Checker
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
