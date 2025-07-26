import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/controllers/employee_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/widget/employee_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController empController = Get.find<EmployeeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Werknemer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Search + Filter Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange),
                  ),
                  child: const Icon(Icons.tune, color: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // List of Employees
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: empController.employeeList.length,
                  itemBuilder: (context, index) {
                    final employee = empController.employeeList[index];
                    final isSelected =
                        empController.selectedEmployeeIndex.value == index;
                    return EmployeeTile(
                      employee: employee,
                      isSelected: isSelected,
                      onTap: () => empController.selectEmployee(index),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
