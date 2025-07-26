import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'stat_card.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer_new/controller/employee_management_controller.dart';

class StatsSection extends StatelessWidget {
  final EmployeeManagementController controller;

  const StatsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Actieve Werknemer',
                    count: controller.activeCount.value,
                    imagePath: IconPath.activeWerknemer,
                    countColor: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: StatCard(
                    title: 'Inactieve Werknemer',
                    count: controller.inactiveCount.value,
                    imagePath: IconPath.inactiveWerknemer,
                    countColor: AppColors.primaryGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            StatCard(
              title: 'Totaal Aantal Werknemers',
              count: controller.totalCount,
              imagePath: IconPath.totalAantalWerknemer,
              isFullWidth: true,
              countColor: AppColors.primaryGreen,
            ),
          ],
        ),
      ),
    );
  }
}
