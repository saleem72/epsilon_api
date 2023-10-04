//\\
import "dart:math" as math;

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/configuration/routing/route_generator.dart';
import 'package:epsilon_api/configuration/styling/colors/app_theme.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EpsilonApp extends StatefulWidget {
  const EpsilonApp({super.key});

  @override
  State<EpsilonApp> createState() => _EpsilonAppState();
}

class _EpsilonAppState extends State<EpsilonApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epsilon',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      theme: appLightTheme,
      home: WillPopScope(
        onWillPop: () async =>
            !((await _navigatorKey.currentState?.maybePop()) ?? false),
        child: LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _insertOverlay(context));
            return Navigator(
              key: _navigatorKey,
              onGenerateRoute: RouteGenerator.generate,
              initialRoute: AppScreens.initial,
            );
          },
        ),
      ),
    );
  }

  void _insertOverlay(BuildContext context) {
    return Overlay.of(context).insert(
      OverlayEntry(builder: (context) {
        final size = MediaQuery.of(context).size;

        return Positioned(
          width: 250,
          // height: 56,
          top: 72,
          left: size.width - 260,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {},
              child: Transform.translate(
                offset: const Offset(72, -40),
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.translate.demo,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'CodersDC',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
