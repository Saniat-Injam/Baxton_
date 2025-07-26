// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_request_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/controller/employee_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/task_request_details_form_submission_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EmployeeSelectionView extends StatelessWidget {
  final String? serviceRequestId; // Made optional
  EmployeeSelectionView({super.key, this.serviceRequestId});

  final EmployeeController employeeController = Get.put(EmployeeController());
  final TaskRequestController taskRequestController = Get.put(TaskRequestController());

  @override
  Widget build(BuildContext context) {
    employeeController.fetchEmployees();
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        title: const Text("Selecteer Medewerker"),
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => _selectedHeader()),
            const SizedBox(height: 24),
            _searchAndFilterBar(context),
            const SizedBox(height: 12),
            Obx(() => Expanded(child: _employeeList())),
            const SizedBox(height: 16),
            Obx(() => _assignButton(context)),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _selectedHeader() {
    final emp = employeeController.selectedEmployee.value;
    return Row(
      children: [
        Expanded(
          child: Chip(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            label: Text(
              emp?.name ?? "Select an employee",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGold,
              ),
            ),
            backgroundColor: AppColors.primaryWhite,
          ),
        ),
        Expanded(
          child: Chip(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            label: Text(
              emp?.expertise ?? "No expertise selected",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGold,
              ),
            ),
            backgroundColor: AppColors.secondaryGold,
          ),
        ),
      ],
    );
  }

  Widget _searchAndFilterBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: employeeController.searchEmployee,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(IconPath.search),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderColor2),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Image.asset(IconPath.filter, height: 28, width: 28),
          onPressed: () {
            _showExpertiseFilterDialog(context);
          },
        ),
      ],
    );
  }

  void _showExpertiseFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Expertise'),
          content: Obx(() {
            final expertiseList = employeeController.getExpertiseList();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (expertiseList.isEmpty) const Text('No expertise available'),
                ...expertiseList.map(
                  (expertise) => ListTile(
                    title: Text(expertise),
                    onTap: () {
                      employeeController.filterByExpertise(expertise);
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Clear Filter'),
                  onTap: () {
                    employeeController.filterByExpertise('');
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _employeeList() {
    if (employeeController.filteredEmployees.isEmpty) {
      return Center(
        child: Text(
          'No employees found',
          style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }
    return ListView.builder(
      itemCount: employeeController.filteredEmployees.length,
      itemBuilder: (context, index) {
        final emp = employeeController.filteredEmployees[index];
        final isSelected = emp == employeeController.selectedEmployee.value;
        return ListTile(
          tileColor: AppColors.primaryWhite,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(emp.imageUrl),
            onBackgroundImageError: (_, __) => const Icon(Icons.person),
          ),
          title: Text(
            emp.name,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlack,
            ),
          ),
          subtitle: Text(
            emp.expertise,
            style: getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryGold,
            ),
          ),
          selected: isSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? AppColors.primaryBlue : Colors.transparent,
            ),
          ),
          onTap: () => employeeController.selectEmployee(emp),
        );
      },
    );
  }

  Widget _assignButton(BuildContext context) {
    final isEnabled = employeeController.selectedEmployee.value != null;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () async {
                final selectedEmployee = employeeController.selectedEmployee.value;
                if (selectedEmployee != null) {
                  if (serviceRequestId != null) {
                    // Task assignment scenario
                    await EasyLoading.show(
                      status: 'Assigning task...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    bool success = await taskRequestController.assignTask(
                      serviceRequestId!,
                      selectedEmployee.workerId,
                    );
                    await EasyLoading.dismiss();
                    if (success) {
                      // Fetch task details using serviceRequestId
                      final taskDetails = await taskRequestController.fetchTaskDetails(serviceRequestId!);
                      if (taskDetails != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Task assigned successfully')),
                        );
                        Get.to(() => TaskConfirmationView(task: taskDetails));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to fetch task details')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to assign task')),
                      );
                    }
                  } else {
                    // Task creation scenario: Return selected employee
                    Navigator.of(context).pop(selectedEmployee);
                  }
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(51),
          ),
          fixedSize: const Size.fromHeight(48),
          padding: const EdgeInsets.all(10),
        ),
        child: Text(serviceRequestId != null ? "Toewijzen" : "Selecteren"),
      ),
    );
  }
}