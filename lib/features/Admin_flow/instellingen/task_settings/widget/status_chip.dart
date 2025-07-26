// lib/widgets/status_chip.dart

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String label;

  const StatusChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: getTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryGold,
        ),
      ),
    );
  }
}
