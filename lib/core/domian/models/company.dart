//

import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

enum Company {
  epsilon,
  alameen;
  // almanarah;

  String title(BuildContext context) {
    switch (this) {
      case Company.epsilon:
        return context.translate.epsilon;
      case Company.alameen:
        return context.translate.alameen;
      // case Company.almanarah:
      //   return context.translate.almanarah;
    }
  }

  int get value {
    switch (this) {
      case Company.epsilon:
        return 1;
      case Company.alameen:
        return 2;
      // case Company.almanarah:
      //   return 3;
    }
  }

  String get baseUrl {
    switch (this) {
      case Company.alameen:
        return 'http://epsilondemo.dyndns.org:14545/api/';
      case Company.epsilon:
        return 'http://epsilondemo.dyndns.org:13131/api/';
      // case Company.almanarah:
      //   return 3;
    }
  }

  factory Company.fromValue(int value) {
    switch (value) {
      case 1:
        return Company.epsilon;
      case 2:
        return Company.alameen;
      // case 3:
      //   return Company.almanarah;
      default:
        return Company.epsilon;
    }
  }
}
