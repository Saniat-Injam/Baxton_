import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/taken/details/model/task_checklist_item.dart';
import 'package:flutter/material.dart';

class ChecklistItemWidget extends StatelessWidget {
  final TaskCheckItem item;
  final ValueChanged<bool?> onChanged;

  const ChecklistItemWidget({
    required this.item,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color:
            item.isChecked ? AppColors.secondaryGold : AppColors.primaryWhite,
        border: Border.all(
          color:
              item.isChecked ? AppColors.primaryGold : AppColors.secondaryWhite,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,

        //dense: true,
        visualDensity: VisualDensity.compact,
        value: item.isChecked,
        onChanged: onChanged,
        title: Text(item.title),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColors.primaryBlue, // fill color when checked
        checkColor: Colors.white, // checkmark color
        side: BorderSide(color: AppColors.primaryBlue, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
