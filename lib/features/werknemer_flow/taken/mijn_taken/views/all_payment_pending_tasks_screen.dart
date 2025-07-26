import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/payment_pending_task_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/controller/employee_home_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/payment_all_task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPaymentPendingTasksScreen extends StatelessWidget {
  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();
  final PaymentPendingTaskController paymentPendingTaskController = Get.find();

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
          "Alle Betaling In Afwachting Taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: paymentPendingTaskController.paymentPendingTasks.length,
            itemBuilder: (context, index) {
              final task =
                  paymentPendingTaskController.paymentPendingTasks[index];
              return PaymentAllTaskCard(task: task);
            },
          );
        }),
      ),
    );
  }
}
