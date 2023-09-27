import 'package:flutter/material.dart';

class RoomStyle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0977000, size.height * 0.0003000);
    path_0.lineTo(size.width * 0.0007764, size.height * 0.4996186);
    path_0.lineTo(size.width * 0.1009750, size.height * 0.9889000);
    path_0.lineTo(size.width * 0.8898000, size.height * 0.9927000);
    path_0.lineTo(size.width * 0.9975000, size.height * 0.5196031);
    path_0.lineTo(size.width * 0.8855375, size.height * 0.0022000);
    path_0.lineTo(size.width * 0.0977000, size.height * 0.0003000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 193, 3, 101)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
