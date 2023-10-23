//

import 'package:epsilon_api/configuration/styling/colors/app_theme.dart';
import 'package:epsilon_api/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:epsilon_api/features/pre_launch/epsilon_app.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/presentation/prices_selector_bloc/prices_selector_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependancy_injection.dart' as di;

// http://epsilondemo.dyndns.org:14545
// مدير

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setStatusBarAndNavigationBarColor(ThemeMode.dark);
  await di.initDependancies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.locator()..add(AuthEvent.checkAuthStatus()),
        ),
        BlocProvider<PricesSelectorBloc>(
          lazy: false,
          create: (_) => di.locator(),
        )
      ],
      child: const EpsilonApp(),
    );
  }
}
