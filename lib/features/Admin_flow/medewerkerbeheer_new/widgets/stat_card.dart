import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final int count;

  final Color? countColor;
  final bool isFullWidth;

  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.imagePath,

    this.countColor,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isCentered = isFullWidth;

    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment:
            isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textninth,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: countColor,
            ),
          ),
        ],
      ),
    );
  }
}
