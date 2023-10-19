// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:math' as math;

import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    this.color = Colors.black,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _DashedLinePainter(color: color),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Paint painter;
  _DashedLinePainter({
    required Color color,
  }) : painter = Paint()
          ..style = PaintingStyle.stroke
          ..color = color;
  @override
  void paint(Canvas canvas, Size size) {
    drawDashedLine(
      canvas: canvas,
      p1: Offset(0, size.height),
      p2: Offset(size.width, size.height),
      dashWidth: 4,
      dashSpace: 2,
      paint: painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawDashedLine(
      {required Canvas canvas,
      required Offset p1,
      required Offset p2,
      required int dashWidth,
      required int dashSpace,
      required Paint paint}) {
    // Get normalized distance vector from p1 to p2
    var dx = p2.dx - p1.dx;
    var dy = p2.dy - p1.dy;
    final magnitude = math.sqrt(dx * dx + dy * dy);
    dx = dx / magnitude;
    dy = dy / magnitude;

    // Compute number of dash segments
    final steps = magnitude ~/ (dashWidth + dashSpace);

    var startX = p1.dx;
    var startY = p1.dy;

    for (int i = 0; i < steps; i++) {
      final endX = startX + dx * dashWidth;
      final endY = startY + dy * dashWidth;
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      startX += dx * (dashWidth + dashSpace);
      startY += dy * (dashWidth + dashSpace);
    }
  }
}
