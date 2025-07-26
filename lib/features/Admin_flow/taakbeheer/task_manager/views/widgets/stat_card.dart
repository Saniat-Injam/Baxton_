import 'package:flutter/material.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';

class StatCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final int count;
  final TextStyle? countTextStyle;
  final double? width;
  final CrossAxisAlignment crossAxisAlignment;

  const StatCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.count,
    this.countTextStyle,
    this.width,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 172,
      height: 135,
      padding: EdgeInsets.only(left: 12, top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryWhite,
        border: Border.all(color: AppColors.borderColor2, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          // Grid Image
          Image.asset(iconPath,height: 40,width: 40,),
          SizedBox(height: 4),

          // Grid Text
          Text(
            title,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textninth,
            ),
          ),

          // Grid Count Value
          Text(
            // '$count',
            // style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            '$count',
            style:
                countTextStyle ??
                const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
