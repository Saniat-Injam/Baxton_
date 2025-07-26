import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer_new/view/employee_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(employee.imageUrl)),
        title: Text(
          employee.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          employee.role,
          style: const TextStyle(color: AppColors.primaryGold),
        ),
        trailing: Image.asset(IconPath.arrowRight5),
        onTap: () {
          Get.to(() => EmployeeInfoScreen(), arguments: employee);
        },
      ),
    );
  }
}
