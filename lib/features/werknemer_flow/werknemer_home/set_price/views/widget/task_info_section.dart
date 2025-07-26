import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskInfoCard extends StatelessWidget {
  final SetPriceTaskModel setPriceInfoScreentask;

  const TaskInfoCard({super.key, required this.setPriceInfoScreentask});

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat(
      'hh:mm a',
    ).format(setPriceInfoScreentask.dateTime);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryWhite),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryWhite,
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Task Title
          Center(
            child: Text(
              setPriceInfoScreentask.title,
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Task Description
          Text(
            setPriceInfoScreentask.description ?? 'No description available',

            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryBlack,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Task Time and Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(IconPath.clock),
              const SizedBox(width: 4),
              Text(timeStr),
              const SizedBox(width: 16),
              Image.asset(IconPath.location),
              const SizedBox(width: 4),
              Text(setPriceInfoScreentask.location),
            ],
          ),
        ],
      ),
    );
  }
}
