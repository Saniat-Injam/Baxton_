import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/all_task_model.dart';
import 'package:flutter/material.dart';

class AllTaskCard extends StatelessWidget {
  final Task task;

  AllTaskCard({super.key, required this.task});

  Color getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.bezig:
        return AppColors.primaryBlue;
      case TaskStatus.voltooid:
        return AppColors.textPrimary;
      case TaskStatus.teLaat:
        return AppColors.secondaryRed;
      case TaskStatus.nietToegewezen:
        return AppColors.primaryGold;
    }
  }

  String getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.bezig:
        return 'Bezig';
      case TaskStatus.voltooid:
        return 'Voltooid';
      case TaskStatus.teLaat:
        return 'Te laat';
      case TaskStatus.nietToegewezen:
        return 'Niet toegewezen';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 111,
        width: double.infinity,

        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                //const SizedBox(width: 4),
                Row(
                  children: [
                    Image.asset(IconPath.location),
                    SizedBox(width: 4),
                    Text(
                      task.location,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textThird,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 4),
            Row(
              children: [
                Image.asset(IconPath.employee),
                // const SizedBox(width: 4),
                Spacer(),
                Text(task.assignee),
                // const SizedBox(width: 8),
                Spacer(),
                Text(task.date.toLocal().toString().split(' ')[0]),

                 Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(task.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    getStatusText(task.status),
                    style: TextStyle(
                      color: getStatusColor(task.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
