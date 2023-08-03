//

import 'package:flutter/material.dart';

class RoutingError extends StatelessWidget {
  final String errorMessage;
  const RoutingError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
