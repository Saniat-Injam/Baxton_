import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/instellingen/task_settings/controller/task_settings_controller.dart';
import 'package:baxton/features/Admin_flow/instellingen/task_settings/widget/category_chip.dart';
import 'package:baxton/features/Admin_flow/instellingen/task_settings/widget/selection_tile.dart';
import 'package:baxton/features/Admin_flow/instellingen/task_settings/widget/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskSettingsScreen extends StatelessWidget {
  final TaskSettingsController taskSettingsController = Get.put(
    TaskSettingsController(),
  );

  TaskSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Taakinstellingen',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        leading: const BackButton(),
      ),
      body: Obx(() {
        final model = taskSettingsController.model.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Taakcategorieën'),
              Wrap(
                children:
                    model.categories
                        .map((cat) => CategoryChip(label: cat))
                        .toList(),
              ),
              const SizedBox(height: 8),

              // Add New Category Button
              SizedBox(
                height: 48,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    taskSettingsController.addCategory('Nieuwe Categorie');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(51),
                    ),
                    side: BorderSide(color: AppColors.primaryBlue),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Nieuwe Categorie Toevoegen',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 8), // space between text and icon
                      Image.asset(IconPath.add),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              const SectionTitle(title: 'Standaard Taakstatus'),
              Wrap(
                children:
                    model.statuses
                        .map((status) => StatusChip(label: status))
                        .toList(),
              ),
              const SizedBox(height: 12),

              // Add New Status Button
              SizedBox(
                height: 48,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    taskSettingsController.addCategory('Nieuwe Categorie');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(51),
                    ),
                    side: BorderSide(color: AppColors.primaryBlue),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Nieuwe Status Toevoegen',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 8), // space between text and icon
                      Image.asset(IconPath.add),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Toggle Option
              Container(
                height: 64,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderColor2),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Herinnering voor taakdeadlines',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black3,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Switch(
                      value: model.reminderEnabled,
                      activeColor: AppColors.primaryGold,
                      onChanged:
                          (val) => taskSettingsController.toggleReminder(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Save Changes Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => taskSettingsController.saveChanges(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Wijzigingen Opslaan',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
