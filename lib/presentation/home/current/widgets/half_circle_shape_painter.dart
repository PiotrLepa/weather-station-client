import 'package:flutter/material.dart';

class HalfCircleShapePainter extends CustomPainter {
  final Color color;

  HalfCircleShapePainter({@required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 6;

    final halfOvalPath = Path()
      ..moveTo(0, size.height - radius)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + radius,
        size.width,
        size.height - radius,
      );

    final squarePath = Path()
      ..lineTo(0, size.height - radius)
      ..lineTo(size.width, size.height - radius)
      ..lineTo(size.width, 0);

    final paint = Paint()..color = color;
    canvas.drawPath(halfOvalPath, paint);
    canvas.drawPath(squarePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
