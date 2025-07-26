import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/task_status_model.dart';
import 'package:flutter/material.dart';

class CompleteTaskCard extends StatelessWidget {
  final TaskStatusModel task;
  final VoidCallback? onPressed;
  const CompleteTaskCard({super.key, required this.task, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.secondaryWhite),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Location
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(IconPath.location),
                const SizedBox(width: 4),
                Text(
                  task.location,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              task.description,
              style: commonText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            const SizedBox(height: 8),

            // Price
            Container(
              height: 34,
              width: 90,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.secondaryBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "\$${task.basePrice.toStringAsFixed(0)}",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Date and time
            Row(
              children: [
                Text(
                  "${task.dateTime.day.toString().padLeft(2, '0')}/"
                  "${task.dateTime.month.toString().padLeft(2, '0')}/"
                  "${task.dateTime.year}  "
                  "${task.dateTime.hour.toString().padLeft(2, '0')}:"
                  "${task.dateTime.minute.toString().padLeft(2, '0')} uur",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 140,
                  height: 44,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        return AppColors.primaryBlue;
                      }),
                      side: WidgetStateProperty.resolveWith<BorderSide>((
                        states,
                      ) {
                        return BorderSide(
                          color:
                              states.contains(WidgetState.disabled)
                                  ? AppColors.primaryBlueWithShadow
                                  : AppColors.primaryBlue,
                        );
                      }),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(62),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    // you can decide whether to enable/disable:
                    onPressed: onPressed,
                    //  () {
                    //   // your action for payment-pending tasks
                    //   Get.snackbar("Payment Pending", "Invoice: ${task.id}");
                    //   Get.to(WorkerTaskExecutionScreen());
                    // },
                    child: Center(
                      child: Text(
                        "Bekijk Factuur", // or any action
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryWhite,
                        ),
                      ),
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
