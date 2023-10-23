//

import 'package:epsilon_api/configuration/app_constants.dart';
import 'package:epsilon_api/core/domian/models/login_validation_status.dart';

class ValidateUsername {
  LoginValidationStatus call(String username) {
    if (username.trim().isEmpty) {
      return LoginValidationStatus.emptyUsername;
    }
    if (username.length < AppConstants.usernameMinLength) {
      return LoginValidationStatus.shortUsername;
    }
    return LoginValidationStatus.valid;
  }
}
