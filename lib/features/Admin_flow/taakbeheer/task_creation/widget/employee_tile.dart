import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  final bool isSelected;
  final VoidCallback onTap;

  const EmployeeTile({
    super.key,
    required this.employee,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isSelected ? Border.all(color: Colors.blue) : null,
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(employee.imageUrl),
              radius: 25,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  employee.role,
                  style: const TextStyle(color: Colors.orange, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
