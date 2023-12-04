//

import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.image,
    required this.onPress,
    required this.label,
  });
  final String image;
  final Function() onPress;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onPress(),
      child: Row(
        children: [
          Material(
            shape: const CircleBorder(),
            elevation: 4,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  image,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(label),
        ],
      ),
    );
  }
}
