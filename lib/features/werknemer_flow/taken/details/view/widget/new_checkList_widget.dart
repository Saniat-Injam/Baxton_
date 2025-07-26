// ignore_for_file: file_names

import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/task_details_model.dart';
import 'package:flutter/material.dart';

class NewChecklistWidget extends StatelessWidget {
  final TaskItem item;
  final ValueChanged<bool?> onChanged;

  const NewChecklistWidget({
    super.key,
    required this.item,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool checked = item.done ?? false;

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: checked ? AppColors.secondaryGold : AppColors.primaryWhite,
        border: Border.all(
          color: checked ? AppColors.primaryGold : AppColors.secondaryWhite,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        value: checked,
        onChanged: onChanged,
        title: Text(item.name ?? ''), // 🔥 using TaskItem.name
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColors.primaryBlue,
        checkColor: Colors.white,
        side: const BorderSide(color: AppColors.primaryBlue, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
