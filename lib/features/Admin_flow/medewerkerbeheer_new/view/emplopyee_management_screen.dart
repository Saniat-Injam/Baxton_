import 'package:baxton/features/Admin_flow/medewerkerbeheer_new/widgets/employee_card.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer_new/widgets/search_and_filter_bar.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer_new/widgets/stats_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/employee_management_controller.dart';

class EmployeeManagementScreen extends StatelessWidget {
  final EmployeeManagementController employeeManagementController = Get.put(
    EmployeeManagementController(),
  );

  EmployeeManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Werknemersbeheer'),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            StatsSection(controller: employeeManagementController),
            const SizedBox(height: 12),
            const SearchAndFilterBar(),
            const SizedBox(height: 12),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: employeeManagementController.employees.length,
                itemBuilder: (context, index) {
                  return EmployeeCard(
                    employee: employeeManagementController.employees[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
