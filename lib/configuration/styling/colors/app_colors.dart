//

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryLight = Color(0xFF4F7694);
  static const Color primaryDark = Color(0xFF226184);
  static const Color textLight = Colors.white;
  static const Color textDark = Colors.black;
  static const Color secondary = Color(0xFFAEAAAE);
  static const Color gradientStart = Color(0xFF0083AB);
  static const Color gradientEnd = Color(0xFF27587E);
  static const Color navbar = Color(0xFF4F7694);
  static const Color green = Color(0xFF44C4A1);

  static const Color tertiary = Color(0xFF575095);
  static const Color error = Color(0xFFBA1B1B);
  static const Color neutralVarient = Color(0xFFBECFDC);
  static const Color neutral10 = Color(0XFF1a1a1a);
  static const Color neutral20 = Color(0XFF333333); // 333333
  static const Color neutral95 = Color(0XFFF1F1F1);
  static const Color neutral90 = Color(0XFFe6e6e6);

  static const gradient = LinearGradient(
    begin: Alignment(-1.4534885883331299, -8.366897485260393e-17),
    end: Alignment(1.006429672241211, -0.37631702423095703),
    colors: [
      Color(0xFF0083AB), // Color.fromRGBO(0, 131, 171, 1),
      Color(0xFF27587E), // Color.fromRGBO(39, 88, 126, 1),
    ],
  );

  static const buttonGradient = LinearGradient(
      begin: Alignment(-1.4534885883331299, -8.366897485260393e-17),
      end: Alignment(1.006429672241211, -0.37631702423095703),
      colors: [
        Color(0xFF1091DA),
        Color(0xFF3B464D),
      ]);
}
