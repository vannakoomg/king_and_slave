import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5145000, size.height * 0.2000000);
    path_0.lineTo(size.width * 0.3394000, size.height * 0.0002000);
    path_0.lineTo(size.width * 0.1245000, size.height * 0.0461000);
    path_0.lineTo(size.width * 0.0305000, size.height * 0.1555000);
    path_0.lineTo(size.width * 0.0054000, size.height * 0.3173000);
    path_0.lineTo(size.width * 0.0247000, size.height * 0.4704000);
    path_0.lineTo(size.width * 0.5051000, size.height * 0.9996000);
    path_0.lineTo(size.width * 0.9755000, size.height * 0.4951000);
    path_0.lineTo(size.width * 0.9991000, size.height * 0.2381000);
    path_0.lineTo(size.width * 0.8790000, size.height * 0.0498000);
    path_0.lineTo(size.width * 0.7000000, size.height * 0.0100000);
    path_0.lineTo(size.width * 0.5145000, size.height * 0.2000000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
