//

import 'package:epsilon_api/configuration/app_constants.dart';
import 'package:epsilon_api/core/domian/models/login_validation_status.dart';

class ValidatePassword {
  LoginValidationStatus call(String password) {
    if (password.isEmpty) {
      return LoginValidationStatus.emptyPassword;
    }
    if (password.length < AppConstants.passwordMinLength) {
      return LoginValidationStatus.shortPassword;
    }
    return LoginValidationStatus.valid;
  }
}
