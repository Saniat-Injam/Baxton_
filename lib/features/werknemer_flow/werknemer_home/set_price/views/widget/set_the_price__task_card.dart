import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class SetThePriceTaskCard extends StatelessWidget {
  final SetPriceTaskModel setPriceTask;
  final VoidCallback onSetPrice;

  const SetThePriceTaskCard({
    super.key,
    required this.setPriceTask,
    required this.onSetPrice,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd/MM/yyyy').format(setPriceTask.dateTime);
    final timeStr = DateFormat('hh:mm a').format(setPriceTask.dateTime);

    return Card(
      color: AppColors.primaryWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.secondaryWhite),
        borderRadius: BorderRadius.circular(8),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title and Location
            Row(
              children: [
                Expanded(
                  child: Text(
                    setPriceTask.title,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                Image.asset(IconPath.location),
                const SizedBox(width: 4),
                Text(
                  setPriceTask.location,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Short Description
            Text(
              setPriceTask.shortDescription ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryBlack,
              ),
            ),
            const SizedBox(height: 12),

            // Date, Time and Set Price Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateStr,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeStr,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryBlack,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                SizedBox(
                  width: 141,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onSetPrice,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                    ),
                    child: const Text('Stel Prijs In'),
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
