import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/set_price_task_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/upcoming_task_card.dart';

class AllUpcomingTaskScreen extends StatelessWidget {
  AllUpcomingTaskScreen({super.key});

  final UpcomingTaskController upcomingTaskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
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
        backgroundColor: Colors.transparent,
        title: Text(
          "Stel de Prijzen In",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (upcomingTaskController.upcomingTasks.isEmpty) {
            return Center(
              child: Text(
                "Geen aankomende taken.",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryGreen,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: upcomingTaskController.upcomingTasks.length,
            itemBuilder: (context, index) {
              final task = upcomingTaskController.upcomingTasks[index];
              return UpcomingTaskCard(
                onPressed: () {
                  upcomingTaskController.fetchTaskDetails(task.id);
                  Get.to(
                    SetPriceTaskDetails(),
                    transition: Transition.leftToRight,
                  );
                },
                upcomingTask: upcomingTaskController.upcomingTasks[index],
              );
            },
          );
        }),
      ),
    );
  }
}
