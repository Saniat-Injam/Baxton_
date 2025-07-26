import 'package:flutter/material.dart';

class SalesAnalysisChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: CustomPaint(painter: PieChartPainter()),
    );
  }
}

// Custom Painter for Pie Chart
class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    double total = 45 + 25 + 15 + 10 + 5;

    double angle1 = (45 / total) * 2 * 3.14159265359;
    double angle2 = (25 / total) * 2 * 3.14159265359;
    double angle3 = (15 / total) * 2 * 3.14159265359;
    double angle4 = (10 / total) * 2 * 3.14159265359;
    double angle5 = (5 / total) * 2 * 3.14159265359;

    paint.color = Color(0xff62B2FD);
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -3.14159265359 / 2,
      angle1,
      true,
      paint,
    );

    paint.color = Colors.green;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -3.14159265359 / 2 + angle1,
      angle2,
      true,
      paint,
    );

    paint.color = Colors.pink;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -3.14159265359 / 2 + angle1 + angle2,
      angle3,
      true,
      paint,
    );

    paint.color = Colors.purple;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -3.14159265359 / 2 + angle1 + angle2 + angle3,
      angle4,
      true,
      paint,
    );

    paint.color = Colors.orange;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -3.14159265359 / 2 + angle1 + angle2 + angle3 + angle4,
      angle5,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
