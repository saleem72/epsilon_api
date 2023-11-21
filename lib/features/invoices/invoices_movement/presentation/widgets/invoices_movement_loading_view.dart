//

import 'package:epsilon_api/core/widgets/general_loading_view.dart';
import 'package:flutter/material.dart';

class InvoicesMovementLoadingView extends StatelessWidget {
  const InvoicesMovementLoadingView({
    super.key,
    required this.isLoading,
  });
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return isLoading ? const GeneralLoadingView() : const SizedBox.shrink();
  }
}
