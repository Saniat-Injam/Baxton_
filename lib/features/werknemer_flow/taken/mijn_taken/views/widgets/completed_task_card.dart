import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/completed_task_model.dart';
import 'package:flutter/material.dart';

class CompletedTaskCard extends StatelessWidget {
  final CompletedTaskModel employeesCompletedTask;
  const CompletedTaskCard({super.key, required this.employeesCompletedTask});

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
            Row(
              children: [
                // Title
                Text(
                  employeesCompletedTask.title,
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                  ),
                ),
                const Spacer(),

                // Location
                Image.asset(IconPath.location),
                SizedBox(width: 4),
                Text(
                  employeesCompletedTask.location,
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
              employeesCompletedTask.description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            const SizedBox(height: 8),

            // Confirmed Price
            Row(
              children: [
                // Price Label
                Container(
                  height: 34,
                  width: 69,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      employeesCompletedTask.price,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Date, Time and view-details Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      // date and time with space in between
                      "${employeesCompletedTask.dateTime.day}/${employeesCompletedTask.dateTime.month}/${employeesCompletedTask.dateTime.year}   "
                      "${employeesCompletedTask.dateTime.hour.toString().padLeft(2, '0')}:${employeesCompletedTask.dateTime.minute.toString().padLeft(2, '0')} AM",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),

                Spacer(),

                // start-task button
                SizedBox(
                  width: 140,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Bekijk details'),
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
