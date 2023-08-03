//

import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
    required this.isLoading,
    this.color = Colors.white,
  });

  final bool isLoading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: color,
            ),
          )
        : const SizedBox.shrink();
  }
}
