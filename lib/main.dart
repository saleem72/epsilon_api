//

import 'package:epsilon_api/configuration/styling/colors/app_theme.dart';
import 'package:epsilon_api/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:epsilon_api/features/pre_launch/epsilon_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependancy_injection.dart' as di;

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
      ],
      child: const EpsilonApp(),
    );
  }
}
