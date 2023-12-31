//

import 'package:flutter/material.dart';

class GeneralLoadingView extends StatelessWidget {
  const GeneralLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: const Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
