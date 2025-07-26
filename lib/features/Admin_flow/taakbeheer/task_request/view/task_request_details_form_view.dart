// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_request_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/task_details_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/employee_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskRequestDetailView extends StatelessWidget {
  final Data task; // Data model from the new task_details_model.dart
  TaskRequestController taskRequestController = Get.put(TaskRequestController());

  TaskRequestDetailView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Taakverzoekdetails"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              task.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // City (Location)
            Text(
              task.city,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              task.problemDescription,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Category
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryBlue),
                borderRadius: BorderRadius.circular(12),
                color: AppColors.secondaryBlue,
              ),
              child: Center(
                child: Text(
                  task.taskType.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Form details
            _buildLabel("Naam van de klant"),
            _buildTextField(task.clientProfile.userName),

            _buildLabel("Locatie van de klant"),
            _buildTextField(task.city),

            _buildLabel("Telefoonnummer van de klant"),
            _buildTextField(task.phoneNumber),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Gewenste datum"),
                      _buildTextField(
                        task.preferredDate.toString().split(' ')[0],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Gewenste tijd"),
                      _buildTextField(
                        task.preferredTime.toString().split(' ')[1].split('.')[0],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      // Call the rejectTask function from the controller
                      bool success = await taskRequestController.rejectTask(
                        task.id,
                      );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Task rejected successfully')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to reject task')),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryBlue),
                      foregroundColor: AppColors.primaryBlue,
                      fixedSize: const Size(173, 48),
                    ),
                    child: const Text("Afwijzen"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => EmployeeSelectionView(
                          serviceRequestId: task.id,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(51),
                      ),
                      fixedSize: const Size(173, 48),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    child: const Text("Accepteren"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryBlack,
        ),
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryBlack,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        filled: true,
        fillColor: AppColors.primaryWhite,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.secondaryWhite),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}