import 'package:flutter/material.dart';

class BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    Path path = Path();

    path.moveTo(w * 0.15, h * 0.95);

    // Left side
    path.cubicTo(
      w * -0.05,
      h * 0.70,
      w * 0.02,
      h * 0.25,
      w * 0.30,
      h * 0.08,
    );

    // Top curve
    path.cubicTo(
      w * 0.55,
      h * -0.02,
      w * 0.82,
      h * 0.00,
      w * 0.95,
      h * 0.15,
    );

    // Right side
    path.cubicTo(
      w * 1.05,
      h * 0.40,
      w * 0.95,
      h * 0.78,
      w * 0.72,
      h * 0.93,
    );

    // Bottom curve
    path.cubicTo(
      w * 0.50,
      h * 1.06,
      w * 0.30,
      h * 1.02,
      w * 0.15,
      h * 0.95,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BlobBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = BlobClipper().getClip(size);

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}