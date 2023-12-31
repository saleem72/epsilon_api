//

import 'dart:convert';

import 'package:epsilon_api/core/domian/models/company.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeKeys {
  SafeKeys._();

  static const String languageCode = 'languageCode';
  static const String english = 'en';
  static const String arabic = 'ar';

  static const String themeKey = 'themeKey';
  static const String isFirstRun = 'is_first_run';

  static const String token = 'epsilon_token';
  static const String tokenExpireDate = 'epsilon_token_expire';

  static const String onBoarding = 'epsilon_onboarding';

  static const String host = 'epsilon_host';
  static const String company = 'epsilon_company';
  static const String oldSearch = 'epsilpon_old_search';
  static const String savedPrices = 'epsilon_saved_prices';
}

enum AuthOption { none, home, login }

class Safe {
  final SharedPreferences _storage;
  Safe({
    required SharedPreferences storage,
  }) : _storage = storage;

  // Localization
  Future<Locale> setLocal(String languageCode) async {
    await _storage.setString(SafeKeys.languageCode, languageCode);
    return _locale(languageCode);
  }

  String getLanguageCode() {
    return _storage.getString(SafeKeys.languageCode) ?? SafeKeys.english;
  }

  Locale getLocal() {
    final languageCode =
        _storage.getString(SafeKeys.languageCode) ?? SafeKeys.english;
    return _locale(languageCode);
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case SafeKeys.english:
        return const Locale(SafeKeys.english, '');
      case SafeKeys.arabic:
        return const Locale(SafeKeys.arabic, '');
      default:
        return const Locale(SafeKeys.english, '');
    }
  }

  // Themeing
  Future<String> setThemeMode(String mode) async {
    await _storage.setString(SafeKeys.themeKey, mode);
    return mode;
  }

  ThemeMode getThemeMode() {
    final string = _storage.getString(SafeKeys.themeKey);
    if (string == null) {
      return ThemeMode.system;
    }
    if (string == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  bool get isFirstRun => _storage.getBool(SafeKeys.isFirstRun) ?? true;
  Future updateFirstRun() async {
    await _storage.setBool(SafeKeys.isFirstRun, false);
  }

  bool getOnBoardingStatus() {
    return _storage.getBool(SafeKeys.onBoarding) ?? false;
  }

  Future endOnBoardingStatus() async {
    await _storage.setBool(
        SafeKeys.onBoarding, true); //.getBool(SafeKeys.onBoarding) ?? false;
  }

  String? getToken() {
    return _storage.getString(SafeKeys.token);
  }

  Future<bool> setToken(String token) async {
    return _storage.setString(SafeKeys.token, token);
  }

  Future clearToken() async {
    await _storage.remove(SafeKeys.token);
  }

  bool isAuthorized() {
    final token = _storage.getString(SafeKeys.token);
    return (token != null) && (token.isNotEmpty);
  }

  AuthOption getAuthStatus() {
    if (isAuthorized()) {
      return AuthOption.home;
    } else {
      return AuthOption.login;
    }
  }

  Future setHost(String host) {
    return _storage.setString(SafeKeys.host, host);
  }

  String getHost() {
    final host = _storage.getString(SafeKeys.host);
    return host ?? '';
  }

  Future setCompany(Company company) {
    return _storage.setInt(SafeKeys.company, company.value);
  }

  Company getCompany() {
    final companyId = _storage.getInt(SafeKeys.company) ?? 1;
    return Company.fromValue(companyId);
  }

  Future setOldSearch(List<String> oldSeach) async {
    final str = jsonEncode(oldSeach);
    await _storage.setString(SafeKeys.oldSearch, str);
  }

  List<String> getOldSearch() {
    final str = _storage.getString(SafeKeys.oldSearch);
    final result =
        str == null ? List<String>.empty() : List<String>.from(jsonDecode(str));

    return result.map((e) => e).toList();
  }

  Future clearOldSearch() async {
    await _storage.remove(SafeKeys.oldSearch);
  }

  Future savePrices({required List<int> pricesIds}) async {
    final str = jsonEncode(pricesIds);
    await _storage.setString(SafeKeys.savedPrices, str);
  }

  List<int> getSavedPrices() {
    final str = _storage.getString(SafeKeys.savedPrices);
    final result =
        str == null ? List<int>.empty() : List<int>.from(jsonDecode(str));

    return result.map((e) => e).toList();
  }
}
