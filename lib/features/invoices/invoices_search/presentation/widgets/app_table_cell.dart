//

import 'package:flutter/material.dart';

class AppTableCell extends StatelessWidget {
  const AppTableCell({
    super.key,
    required this.text,
    this.alignment = Alignment.center,
    this.hasEdge = true,
  });
  final String text;
  final AlignmentGeometry alignment;
  final bool hasEdge;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 4, right: 4),
      decoration: BoxDecoration(
        border: hasEdge ? const Border(left: BorderSide()) : null,
      ),
      alignment: alignment,
      child: Text(text),
    );
  }
}
