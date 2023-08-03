//

import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

enum ValidationStatus {
  valid,
  emptyUsername,
  shortUsername,
  emptyPassword,
  shortPassword;

  String message(BuildContext context) {
    switch (this) {
      case ValidationStatus.valid:
        return '';
      case ValidationStatus.emptyUsername:
        return context.translate.empty_username;
      case ValidationStatus.shortUsername:
        return context.translate.short_username;
      case ValidationStatus.emptyPassword:
        return context.translate.empty_password;
      case ValidationStatus.shortPassword:
        return context.translate.short_password;
    }
  }
}
