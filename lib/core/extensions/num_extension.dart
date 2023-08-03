//

import 'dart:math';

extension DegreesRoRadians on num {
  double toRadians() {
    return (this * pi) / 180; // 1° = π/180°
  }
}
