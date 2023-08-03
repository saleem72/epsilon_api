//

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Translation on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  NavigatorState get navigator => Navigator.of(this);
  TextDirection get directionality => Directionality.of(this);
}
