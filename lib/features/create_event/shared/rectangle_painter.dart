import 'package:flutter/material.dart';

class RRectanglePainter extends CustomPainter {
  RRectanglePainter({super.repaint, required this.isClicked});
  final bool isClicked;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isClicked ? Colors.blueAccent : Colors.grey.shade400
      ..style = PaintingStyle.fill;

    final roundRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(4));

    canvas.drawRRect(roundRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
