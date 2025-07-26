// info_section_widget.dart

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/widget/info_card_row.dart';
import 'package:flutter/material.dart';

class CustomerWorkerInfoCard extends StatelessWidget {
  final double height;
  final String title;
  final List<Widget> children;
  final Color valueColor;

  const CustomerWorkerInfoCard({
    super.key,

    required this.height,
    required this.title,
    required this.children,
    this.valueColor = Colors.black, // default black for customer info
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryBlack,
              ),
            ),
            SizedBox(height: 16),
            // Override valueColor for all InfoCardRow children
            ...children.map((child) {
              if (child is InfoCardRow) {
                return InfoCardRow(
                  label: child.label,
                  value: child.value,
                  valueColor: valueColor,
                );
              }
              return child;
            }),
          ],
        ),
      ),
    );
  }
}
