import 'package:baxton/features/Admin_flow/admin_home/model/home_data_model.dart';
import 'package:flutter/material.dart';

class TaskOverviewChart extends StatelessWidget {
  final TaskStatistics taskStatistics;

  const TaskOverviewChart({super.key, required this.taskStatistics});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: CustomPaint(
        painter: PieChartPainter(taskStatistics: taskStatistics),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final TaskStatistics taskStatistics;

  PieChartPainter({required this.taskStatistics});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    double total = taskStatistics.totalTaskRequests.toDouble() +
        taskStatistics.totalAssignedTasks.toDouble() +
        taskStatistics.totalConfirmedTasks.toDouble() +
        taskStatistics.totalCompletedTasks.toDouble() +
        taskStatistics.totalLateWork.toDouble();

    if (total == 0) total = 1; // Prevent division by zero

    double angle1 = (taskStatistics.totalAssignedTasks / total) * 2 * 3.14159265359;
    double angle2 = (taskStatistics.totalConfirmedTasks / total) * 2 * 3.14159265359;
    double angle3 = (taskStatistics.totalCompletedTasks / total) * 2 * 3.14159265359;
    double angle4 = (taskStatistics.totalLateWork / total) * 2 * 3.14159265359;
    double angle5 = (taskStatistics.totalTaskRequests / total) * 2 * 3.14159265359;

    paint.color = const Color(0xff62B2FD);
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

    paint.color = const Color(0xff9BDFC4);
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

    paint.color = const Color(0xffF99BAB);
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

    paint.color = const Color(0xff9F97F7);
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

    paint.color = const Color(0xffFFB44F);
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}