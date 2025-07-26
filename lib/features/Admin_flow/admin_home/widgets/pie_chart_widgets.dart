import 'package:baxton/features/Admin_flow/admin_home/model/home_data_model.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/task_overview_chart.dart';
import 'package:baxton/features/Admin_flow/admin_home/widgets/task_status_widget.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final TaskStatistics taskStatistics;

  const PieChartWidget({super.key, required this.taskStatistics});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 362,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffFFFFFF),
        border: Border.all(width: 1, color: const Color(0xffE1E7EC)),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Taak Overzicht",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff666666),
            ),
          ),
          const SizedBox(height: 11),
          Align(
            alignment: Alignment.center,
            child: TaskOverviewChart(taskStatistics: taskStatistics),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              TaskStatusRow(
                color: const Color(0xff62B2FD),
                label: "Toegewezen Taken",
                data: taskStatistics.totalAssignedTasks.toString(),
              ),
              const SizedBox(width: 15),
              TaskStatusRow(
                color: const Color(0xff9BDFC4),
                label: "In Behandeling",
                data: taskStatistics.totalAssignedTasks.toString(),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              TaskStatusRow(
                color: const Color(0xffF99BAB),
                label: "Voltooide Taak",
                data: taskStatistics.totalCompletedTasks.toString(),
              ),
              const SizedBox(width: 15),
              TaskStatusRow(
                color: const Color(0xff9F97F7),
                label: "Te Laat Taken",
                data: taskStatistics.totalLateWork.toString(),
              ),
            ],
          ),
          const SizedBox(height: 13),
          TaskStatusRow(
            color: const Color(0xffFFB44F),
            label: "Niet-Toegewezen Taken",
            data: taskStatistics.totalUnAssignedTask.toString(),
          ),
        ],
      ),
    );
  }
}