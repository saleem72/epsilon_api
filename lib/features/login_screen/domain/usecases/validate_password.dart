//

import 'package:epsilon_api/configuration/app_constants.dart';

import '../models/validation_status.dart';

class ValidatePassword {
  ValidationStatus call(String password) {
    if (password.isEmpty) {
      return ValidationStatus.emptyPassword;
    }
    if (password.length < AppConstants.passwordMinLength) {
      return ValidationStatus.shortPassword;
    }
    return ValidationStatus.valid;
  }
}
