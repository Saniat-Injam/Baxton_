import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_request_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/task_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/task_request_details_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baxton/core/utils/constants/colors.dart';

class TaskRequestCard extends StatelessWidget {
  final TaskRequest req;

  const TaskRequestCard({super.key, required this.req});

  @override
  Widget build(BuildContext context) {
    final taskRequestController = Get.find<TaskRequestController>();

    return Container(
      height: 103,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: AppColors.secondaryWhite),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  req.title,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                    lineHeight: 14,
                  ),
                ),
              ),
              Text(
                req.timeAgo,
                style: getTextStyle(color: AppColors.secondaryBlack),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(IconPath.person),
                  const SizedBox(width: 6),
                  Text(req.user),
                ],
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: ElevatedButton(
                  onPressed: () async {
                    if (req.id.isNotEmpty) {
                      final detail = await taskRequestController.fetchTaskDetails(req.id);
                      if (detail != null) {
                        Get.to(() => TaskRequestDetailView(task: detail));
                      } else {
                        Get.snackbar(
                          'Error',
                          'Task details not found',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Error',
                        'Task ID not available',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Details",
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}