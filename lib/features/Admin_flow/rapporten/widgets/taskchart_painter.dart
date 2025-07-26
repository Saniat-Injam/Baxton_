import 'dart:math' as math;

import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TaskChartPainter extends CustomPainter {
  final double inBehandeling;
  final double nietToegewezen;
  final double voltooid;

  TaskChartPainter({
    required this.inBehandeling,
    required this.nietToegewezen,
    required this.voltooid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 30;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle (remaining portion)
    final backgroundPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // In Behandeling (50%, Blue)
    final inBehandelingPaint =
        Paint()
          ..color = Color(0xff62B2FD)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      (inBehandeling / 100) * 2 * math.pi,
      false,
      inBehandelingPaint,
    );

    // Niet Toegewezen (25%, Light Green)
    final nietToegewezenPaint =
        Paint()
          ..color = Color(0xff9BDFC4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + (inBehandeling / 100) * 2 * math.pi,
      (nietToegewezen / 100) * 2 * math.pi,
      false,
      nietToegewezenPaint,
    );

    // Voltooid (20%, Dark Grey)
    final voltooidPaint =
        Paint()
          ..color = AppColors.textThird
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + ((inBehandeling + nietToegewezen) / 100) * 2 * math.pi,
      (voltooid / 100) * 2.5 * math.pi,
      false,
      voltooidPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}