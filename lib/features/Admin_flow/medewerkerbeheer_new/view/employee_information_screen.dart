import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer_new/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/employee_info_controller.dart';

class EmployeeInfoScreen extends StatelessWidget {
  final EmployeeInfoController controller = Get.put(EmployeeInfoController());

  EmployeeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final e = controller.employee;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medewerker Gegevens"),
        centerTitle: true,
        leading: BackButton(),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Employee Image
            CircleAvatar(radius: 40, backgroundImage: NetworkImage(e.imageUrl)),
            const SizedBox(height: 8),

            // Employee Name
            Text(
              e.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            // Employee ID
            Text(
              'ID: ${e.id}',
              style: getTextStyle(color: AppColors.primaryGold),
            ),
            const SizedBox(height: 12),

            // Assign Task Button --> Taak Toewijzen Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: AppColors.primaryWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(51),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text("Taak Toewijzen"),
              ),
            ),
            SizedBox(height: 10),

            // Message Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryWhite,
                  foregroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(51),
                  ),
                  side: BorderSide(color: AppColors.primaryBlue),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text("Bericht"),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Expertise", e.expertise ?? "-"),
                  _infoRow("Telefoonnummer", e.phone ?? '—'),
                  _infoRow("E-mail", e.email ?? "-"),
                  _infoRow("Locatie", e.location ?? "-"),
                  _infoRow("Toegevoegd", e.joinDate ?? "-"),
                ],
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 4,
                    ), // Optional spacing
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha:  0.2),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _countBox("Totaal", e.totalTasks.toString()),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha:  0.2),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _countBox(
                      "In Afwachting",
                      e.pendingTasks.toString(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha:  0.2),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _countBox("Voltooid", e.completedTasks.toString()),
                  ),
                ),
              ],
            ),

            Card(
              color: AppColors.primaryWhite,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: const Text("Beoordeling"),
                subtitle: Text(
                  "${e.rating}/5",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: const [
                  Text(
                    "Alle Taken",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Spacer(),
                  Icon(Icons.filter_list),
                ],
              ),
            ),
            Obx(
              () => ListView.builder(
                itemCount: controller.tasks.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (_, i) => EmployeeTaskCard(task: controller.tasks[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.blue)),
        ),
      ],
    ),
  );

  Widget _countBox(String label, String value) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(label),
    ],
  );
}
