//\\

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/configuration/routing/route_generator.dart';
import 'package:epsilon_api/configuration/styling/colors/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EpsilonApp extends StatelessWidget {
  const EpsilonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epsilon',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      theme: appLightTheme,
      onGenerateRoute: RouteGenerator.generate,
      initialRoute: AppScreens.initial,
    );
  }
}
