import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

class RecentTaskItem extends StatelessWidget {
  final String taskName;
  final String location;
  final String workerName;
  final String timeAgo;
  final String status;
  final Color statusColor;
  final Color statusTextColor;

  const RecentTaskItem({
    super.key,
    required this.taskName,
    required this.location,
    required this.workerName,
    required this.timeAgo,
    required this.status,
    this.statusColor = const Color(0xffE9F4FF),
    this.statusTextColor = AppColors.buttonPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: const Color(0xffEBEBEB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 165,
                  child: Text(
                    taskName,
                    style: getTextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 17,
                      color: AppColors.buttonPrimary,
                    ),
                    SizedBox(
                      width: 132,
                      child: Text(
                        location,
                        style: getTextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(IconPath.worker, height: 17.5, width: 17.5),
                    const SizedBox(width: 3),
                    SizedBox(
                      width: 100,
                      child: Text(
                        workerName,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textThird,
                          lineHeight: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      timeAgo,
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textThird,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 29,
                  width: 109,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      status,
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: statusTextColor,
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
