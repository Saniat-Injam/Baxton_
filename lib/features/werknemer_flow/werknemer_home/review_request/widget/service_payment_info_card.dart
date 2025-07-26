import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/widget/info_card_row.dart';
import 'package:flutter/material.dart';

class ServicePaymentInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color valueColor;

  const ServicePaymentInfoCard({
    super.key,
    required this.title,
    required this.children,
    this.valueColor = Colors.blue, // default blue for payment info
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
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
          SizedBox(height: 12),
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
    );
  }
}
