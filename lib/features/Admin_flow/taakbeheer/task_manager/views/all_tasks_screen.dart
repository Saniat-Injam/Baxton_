import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/all_task_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/widgets/all_tasks_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTasksScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AllTasksController allTasksController = Get.put(AllTasksController());

  AllTasksScreen({super.key});

  // Function to show the filter dialog
  void _showFilterDialog(BuildContext context) {
    if (allTasksController.tasks.isEmpty) {
      Get.snackbar(
        'No Tasks',
        'No tasks available to filter.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(controller: allTasksController);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text(
          "Task Management / Alle Taken",
          style: getTextStyle(fontSize: 16, color: AppColors.textPrimary),
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: AppColors.textPrimary),
            onPressed: () => allTasksController.loadTasks(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(IconPath.search),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor2),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      hintText: 'Search tasks...',
                    ),
                    onChanged: (value) {
                      allTasksController.searchQuery.value = value;
                      allTasksController.filterTasks();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Image.asset(IconPath.filter, height: 28, width: 28),
                  onPressed: () => _showFilterDialog(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (allTasksController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (allTasksController.filteredTasks.isEmpty) {
                return Center(
                  child: Text(
                    'No tasks available.',
                    style: getTextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: allTasksController.filteredTasks.length,
                itemBuilder: (_, index) {
                  return AllTaskCard(
                    task: allTasksController.filteredTasks[index],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Filter Dialog Widget
class FilterDialog extends StatelessWidget {
  final AllTasksController controller;

  const FilterDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 360,
        height: 463,
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter',
              textAlign: TextAlign.center,
              style: getTextStyle(
                color: const Color(0xFF333333),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      _buildDropdownField(
                        label: 'Locatie',
                        value: controller.selectedLocation.value,
                        items: controller.locations,
                        onChanged: (value) {
                          controller.selectedLocation.value = value ?? '';
                          controller.filterTasks();
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        label: 'Maand',
                        value: controller.selectedMonth.value,
                        items: controller.months,
                        onChanged: (value) {
                          controller.selectedMonth.value = value ?? '';
                          controller.filterTasks();
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        label: 'Year',
                        value: controller.selectedYear.value,
                        items: controller.years,
                        onChanged: (value) {
                          controller.selectedYear.value = value ?? '';
                          controller.filterTasks();
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        label: 'Taaktype',
                        value: controller.selectedTaskType.value,
                        items: controller.taskTypes,
                        onChanged: (value) {
                          controller.selectedTaskType.value = value ?? '';
                          controller.filterTasks();
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildDropdownField(
                        label: 'Taakstatus',
                        value: controller.selectedTaskStatus.value,
                        items: controller.taskStatuses,
                        onChanged: (value) {
                          controller.selectedTaskStatus.value = value ?? '';
                          controller.filterTasks();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    controller.resetFilters();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: getTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.filterTasks();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD9A300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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

  Widget _buildDropdownField({
    required String label,
    required String value,
    required RxList<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyle(
            color: const Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value.isEmpty ? null : value,
            hint: Text(
              'Select $label',
              style: getTextStyle(
                color: const Color(0xFFD9A300),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            items:
                items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: getTextStyle(
                        color: const Color(0xFFD9A300),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }).toList(),
            onChanged: items.isEmpty ? null : onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFD9A300)),
          ),
        ),
      ],
    );
  }
}
