import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/task_manager_screen.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/task_request_controller2.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/task_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskConfirmationView extends StatelessWidget {
  final EmployeeController empController = Get.find<EmployeeController>();
  final TaskRequestViewAllController taskRequestViewAllController = Get.put(
    TaskRequestViewAllController(),
  );
  final Data task;

  TaskConfirmationView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final emp = empController.selectedEmployee.value;

    // Format date and time
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        title: const Text("Taakdetails"),
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              task.city,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Text(
              task.problemDescription,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildChip(task.taskType.name),
            const SizedBox(height: 12),

            // Name, Location, and Telephone Number
            _infoLabel("Naam van de klant", task.clientProfile.userName),
            _infoLabel("Locatie van de klant", task.city),
            _infoLabel("Telefoonnummer van de klant", task.phoneNumber),

            // Date and Time
            Row(
              children: [
                Expanded(
                  child: _infoLabel(
                    "Voorkeursdatum",
                    dateFormat.format(task.preferredDate),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _infoLabel(
                    "Voorkeurstijd",
                    timeFormat.format(task.preferredTime),
                  ),
                ),
              ],
            ),

            // Assigned to, and Expertise
            Row(
              children: [
                Expanded(
                  child: _infoLabel(
                    "Toegewezen aan",
                    emp?.name ?? task.workerProfile?.name ?? "Geen medewerker toegewezen",
                    textColor: AppColors.primaryGold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _infoLabel(
                    "Expertise",
                    emp?.expertise ?? task.workerProfile?.expertise ?? "Geen expertise",
                    boxColor: AppColors.secondaryGold,
                    textColor: AppColors.primaryGold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Get.off(() => TaskManagerScreen(), preventDuplicates: true); // Replace screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(51),
              ),
              fixedSize: const Size.fromHeight(48),
            ),
            child: const Text("Doorgaan"),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        border: Border.all(color: AppColors.primaryBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }

  Widget _infoLabel(
    String label,
    String value, {
    Color? boxColor,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: value,
            readOnly: true,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.primaryBlack,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: boxColor ?? AppColors.primaryWhite,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.secondaryWhite),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}