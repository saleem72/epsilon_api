//

import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

enum LoginValidationStatus {
  valid,
  emptyUsername,
  shortUsername,
  emptyPassword,
  shortPassword;

  String message(BuildContext context) {
    switch (this) {
      case LoginValidationStatus.valid:
        return '';
      case LoginValidationStatus.emptyUsername:
        return context.translate.empty_username;
      case LoginValidationStatus.shortUsername:
        return context.translate.short_username;
      case LoginValidationStatus.emptyPassword:
        return context.translate.empty_password;
      case LoginValidationStatus.shortPassword:
        return context.translate.short_password;
    }
  }
}
