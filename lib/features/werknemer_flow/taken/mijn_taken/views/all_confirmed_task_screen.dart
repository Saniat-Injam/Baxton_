import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/confirm_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/complete_task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllConfirmedTasksScreen extends StatelessWidget {
  final ConfirmedTaskController controller =
      Get.find<ConfirmedTaskController>();

  @override
  Widget build(BuildContext context) {
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
          "Bevestigde taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: controller.confirmedTasks.length,
          itemBuilder: (context, index) {
            return CompleteTaskCard(task: controller.confirmedTasks[index]);
          },
        ),
      ),
    );
  }
}
