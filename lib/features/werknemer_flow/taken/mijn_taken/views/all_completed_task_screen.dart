import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/complete_task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/completed_task_controller.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';

class AllCompletedTasksScreen extends StatelessWidget {
  const AllCompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CompletedTaskController completedTaskController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(IconPath.arrowBack),
            ],
          ),
        ),
        title: Text(
          "Alle Voltooide Taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryBlack),
      ),
      backgroundColor: AppColors.containerColor,
      body: Obx(() {
        final tasks = completedTaskController.completeTasks;

        if (tasks.isEmpty) {
          return Center(
            child: Text(
              "Geen voltooide taken.",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryGreen,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return CompleteTaskCard(
              task: completedTaskController.completeTasks[index],
            );
          },
        );
      }),
    );
  }
}
