//

import 'package:epsilon_api/configuration/app_constants.dart';

import '../models/validation_status.dart';

class ValidateUsername {
  ValidationStatus call(String username) {
    if (username.trim().isEmpty) {
      return ValidationStatus.emptyUsername;
    }
    if (username.length < AppConstants.usernameMinLength) {
      return ValidationStatus.shortUsername;
    }
    return ValidationStatus.valid;
  }
}
