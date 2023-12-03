//

import 'package:epsilon_api/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

void setStatusBarAndNavigationBarColor(ThemeMode themeMode) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:
        themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
    systemNavigationBarIconBrightness:
        themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
    systemNavigationBarColor:
        AppColors.neutralVarient.toMaterialColor().shade600,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
}

final ColorScheme appLightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // cardTheme: CardTheme(
  //     color: Colors.pink,
  //     surfaceTintColor: Colors.green,
  //     shadowColor: Colors.blue,
  //   ),
  primary: AppColors.primaryDark.toMaterialColor().shade400,
  onPrimary: Colors.white,
  primaryContainer: AppColors.primaryDark.toMaterialColor().shade900,
  onPrimaryContainer: AppColors.primaryDark.toMaterialColor().shade100,
  inversePrimary: AppColors.primaryDark.toMaterialColor().shade800,
  secondary: AppColors.primaryLight.toMaterialColor().shade400,
  onSecondary: Colors.white,
  secondaryContainer: AppColors.primaryLight.toMaterialColor().shade900,
  onSecondaryContainer: AppColors.primaryLight.toMaterialColor().shade100,
  tertiary: AppColors.tertiary.toMaterialColor().shade400,
  onTertiary: Colors.white,
  tertiaryContainer: AppColors.tertiary.toMaterialColor().shade900,
  onTertiaryContainer: AppColors.tertiary.toMaterialColor().shade100,
  error: AppColors.error.toMaterialColor().shade400,
  onError: Colors.white,
  errorContainer: AppColors.error.toMaterialColor().shade900,
  onErrorContainer: AppColors.error.toMaterialColor().shade100,
  // light
  background: Colors.white,
  onBackground: AppColors.neutral10,
  inverseSurface: AppColors.neutral20,
  onInverseSurface: AppColors.neutral95,
  surfaceVariant: AppColors.neutralVarient.toMaterialColor().shade900,
  onSurfaceVariant: AppColors.neutralVarient.toMaterialColor().shade300,
  surface: AppColors.neutralVarient.toMaterialColor().shade900,
  onSurface: AppColors.neutralVarient.toMaterialColor().shade300,
  outline: AppColors.neutralVarient.toMaterialColor().shade500,
  surfaceTint: AppColors.primaryDark.toMaterialColor().shade400,
  shadow: Colors.black,
);

ThemeData appLightTheme = ThemeData(
  useMaterial3: false,
  // primarySwatch: Colors.grey,
  // cardTheme: CardTheme(
  //   color: Colors.pink,
  //   surfaceTintColor: Colors.green,
  //   shadowColor: Colors.blue,
  // ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark), // appLightColorScheme,
  scaffoldBackgroundColor: const Color(0xFFF1F1F1), // AppColors.neutral90,
  fontFamily: 'Tajawal',
);


/*
const ColorScheme appDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary80,
  onPrimary: AppColors.primary20,
  primaryContainer: AppColors.primary30,
  onPrimaryContainer: AppColors.primary90,
  inversePrimary: AppColors.primary40,
  secondary: AppColors.secondary80,
  onSecondary: AppColors.secondary20,
  secondaryContainer: AppColors.secondary30,
  onSecondaryContainer: AppColors.secondary90,
  tertiary: AppColors.tertiary80,
  onTertiary: AppColors.tertiary20,
  tertiaryContainer: AppColors.tertiary30,
  onTertiaryContainer: AppColors.tertiary90,
  error: AppColors.error80,
  onError: AppColors.error20,
  errorContainer: AppColors.error30,
  onErrorContainer: AppColors.error90,
  // dark
  background: AppColors.neutral10,
  onBackground: AppColors.neutral90,
  inverseSurface: AppColors.neutral90,
  onInverseSurface: AppColors.neutral10,

  surface: AppColors.neutralVarient30,
  onSurface: AppColors.neutralVarient80,
  surfaceVariant: AppColors.neutralVarient30,
  onSurfaceVariant: AppColors.neutralVarient80,
  outline: AppColors.neutralVarient80,
  surfaceTint: AppColors.primary80,
);

ThemeData appDarkTheme = ThemeData(
  colorScheme: appDarkColorScheme,
  scaffoldBackgroundColor: AppColors.neutral10,
);
*/
