import 'package:animation_aba/const/appcolor.dart';
import 'package:flutter/material.dart';

class Customsetting extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = AppColor.primary
      ..style = PaintingStyle.fill
      ..strokeWidth = 200
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0001500, size.height * 1.0241000);
    path_0.quadraticBezierTo(size.width * 0.0253500, size.height * 0.6383000,
        size.width * 0.1162000, size.height * 0.4951500);
    path_0.cubicTo(
        size.width * 0.2583000,
        size.height * 0.4049000,
        size.width * 0.4018500,
        size.height * 0.4038500,
        size.width * 0.4906000,
        size.height * 0.3863500);
    path_0.quadraticBezierTo(size.width * 0.5802000, size.height * 0.2523500,
        size.width * 0.6938000, size.height * 0.1316500);
    path_0.lineTo(size.width * 0.8962000, size.height * 0.0650000);
    path_0.lineTo(size.width * 1.0336500, size.height * -0.0089500);
    path_0.lineTo(size.width * 1.0241000, size.height * 1.0047000);
    path_0.lineTo(size.width * 0.0001500, size.height * 1.0241000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      // ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
