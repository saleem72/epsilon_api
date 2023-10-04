//

import 'package:epsilon_api/core/errors/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Translation on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  NavigatorState get navigator => Navigator.of(this);
  TextDirection get directionality => Directionality.of(this);

  String getFailureMessageFor(Failure failure) {
    return switch (failure) {
      NoInternetFailure() => translate.no_internet_connection,
      ConnectionFailure() => translate.connection_failure,
      DecodingFailure() => translate.decoding_failure,
      UnAuthorizedFailure() => translate.unauthorized_failure,
      ForbiddenFailure() => translate.forbidden_failure,
      ServerFailure() => translate.unauthorized_failure,
      UnExpectedFailure() => translate.unexpected_failure,
      ProductNotFoundFailure() => failure.message ?? '',
    };
  }
}
