import 'package:animation_aba/const/appcolor.dart';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = AppColor.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * -0.0024250);
    path_0.lineTo(size.width * 0.0118200, size.height * 0.6150750);
    path_0.lineTo(size.width * 0.3038200, size.height * 1.0022750);
    path_0.lineTo(size.width * 0.7000000, size.height * 1.0022750);
    path_0.lineTo(size.width * 0.9823600, size.height * 0.6228000);
    path_0.lineTo(size.width * 1.0038200, size.height * 0.0001500);
    path_0.lineTo(0, size.height * -0.0024250);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = AppColor.primary
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
