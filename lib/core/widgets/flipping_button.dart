//

import 'package:flutter/material.dart';

class FlippingButton extends StatefulWidget {
  const FlippingButton({
    super.key,
    required this.onPress,
    this.isEnabled = true,
    required this.initialValue,
  });
  final Function(bool) onPress;
  final bool isEnabled;
  final bool initialValue;
  @override
  State<FlippingButton> createState() => _FlippingButtonState();
}

class _FlippingButtonState extends State<FlippingButton> {
  double turns = 0.125;
  bool isForeward = true;
  @override
  void didUpdateWidget(covariant FlippingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != isForeward) {
      setState(() {
        turns += widget.initialValue ? -0.625 : 0.625;
        isForeward = widget.initialValue;
      });
    }
  }

  void _changeRotation() {
    setState(() {
      turns += isForeward ? 0.625 : -0.625;
      isForeward = !isForeward;
    });
    widget.onPress(isForeward);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.isEnabled ? _changeRotation() : null,
      child: Material(
        shape: const CircleBorder(),
        elevation: 6,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: widget.isEnabled ? 1 : 0.2,
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Center(
              child: AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 500),
                child: const Icon(
                  Icons.close,
                  size: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
