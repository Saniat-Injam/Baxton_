import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Adjusted data points to match the approximate shape and scale of the chart (0 to 40k)
    final dataPoints = [15.0, 40.0, 20.0, 30.0, 25.0]; // in thousands (k)
    final maxYValue = 40.0; // Maximum value on Y-axis (40k)
    final padding = 5.0; // Minimal padding for full width
    final leftPadding = 30.0; // Increased left padding for Y-axis labels
    final availableWidth = size.width - padding * 2 - leftPadding;
    final labelHeight = 16.0;
    final chartHeight = size.height - labelHeight;

    // Line paint (Thicker line with the correct color from the image)
    final paint = Paint()
      ..color = const Color(0xff1E90FF) // Dark blue line color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 // Thicker line for bold visibility
      ..strokeCap = StrokeCap.round;

    // Area paint (Gradient fill matching the image)
    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xff0054FD), 
          const Color(0xffDADEFF).withAlpha(40), // Very faint at the bottom
        ],
      ).createShader(
        Rect.fromLTRB(leftPadding, 0, size.width - padding, chartHeight),
      );

    // Create list of points based on data
    final points = List<Offset>.generate(dataPoints.length, (i) {
      final x = leftPadding + availableWidth * (i / (dataPoints.length - 1));
      final y = chartHeight - (chartHeight * (dataPoints[i] / maxYValue));
      return Offset(x, y);
    });

    // Create curved path and area path
    final path = Path();
    final areaPath = Path();

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      areaPath.moveTo(points.first.dx, chartHeight);
      areaPath.lineTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length; i++) {
        final p0 = points[i - 1];
        final p1 = points[i];

        // Calculate control points for smooth curve
        final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
        final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);

        path.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          p1.dx,
          p1.dy,
        );

        areaPath.cubicTo(
          controlPoint1.dx,
          controlPoint1.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          p1.dx,
          p1.dy,
        );
      }

      areaPath.lineTo(points.last.dx, chartHeight);
      areaPath.close();
    }

    // Draw the area first
    canvas.drawPath(areaPath, areaPaint);
    // Then draw the line on top of the area
    canvas.drawPath(path, paint);

    // Grid line paint (Subtle lines with reduced opacity)
    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha:  0.2) // Faint grid lines
      ..strokeWidth = 0.5;

    // Horizontal grid lines (with minimal side padding)
    for (double y = 0.0; y <= 1.0; y += 0.25) {
      final yPos = chartHeight - (chartHeight * y);
      canvas.drawLine(
        Offset(leftPadding, yPos),
        Offset(size.width - padding, yPos),
        gridPaint,
      );
    }

    // Y-axis labels (Fixed: 0 at the bottom, 40k at the top)
    const textStyle = TextStyle(color: Colors.black54, fontSize: 10);
    for (double y = 0.0; y <= 1.0; y += 0.25) {
      final yPos = chartHeight - (chartHeight * y);
      final labelValue = (maxYValue * y).toInt();
      final textSpan = TextSpan(
        text: labelValue == 0 ? '0' : '${labelValue}k',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      // Position labels with some space from the graph
      textPainter.paint(canvas, Offset(5, yPos - textPainter.height / 2));
    }

    // X-axis labels (Updated to match the image: Week-1, Week-2, etc.)
    const weekLabels = ['Week-1', 'Week-2', 'Week-3', 'Week-4'];
    for (int i = 0; i < weekLabels.length; i++) {
      final x = leftPadding + availableWidth * (i / (weekLabels.length - 1));
      final textSpan = TextSpan(text: weekLabels[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - textPainter.height),
      );
    }

    // Find the peak point to place the "40k" label (at index 1 in this case)
    final peakIndex = 1; // Hardcoded based on the image (40k at Week-2)
    final peakPoint = points[peakIndex];
    final peakLabel = TextSpan(
      text: '40k',
      style: getTextStyle(
        color: AppColors.primaryGold,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
    final peakLabelPainter = TextPainter(
      text: peakLabel,
      textDirection: TextDirection.ltr,
    );
    peakLabelPainter.layout();

    // Draw a small circle at the peak point
    final circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final circleBorderPaint = Paint()
      ..color = const Color(0xff1E90FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(peakPoint, 5, circlePaint);
    canvas.drawCircle(peakPoint, 5, circleBorderPaint);

    // Draw the "40k" label above the peak point
    peakLabelPainter.paint(
      canvas,
      Offset(
        peakPoint.dx - peakLabelPainter.width / 2,
        peakPoint.dy - peakLabelPainter.height - 10,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}