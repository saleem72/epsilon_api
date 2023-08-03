//

import 'package:flutter/services.dart';

class TextFieldFormmaters {
  TextFieldFormmaters._();

  static final List<TextInputFormatter> doubleTextField = [
    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
  ];

  static final List<TextInputFormatter> letterAndNumbersTextField = [
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
  ];
}
