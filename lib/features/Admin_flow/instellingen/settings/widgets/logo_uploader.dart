import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class LogoUploader extends StatelessWidget {
  const LogoUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 321,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 110),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImagePath.baxton),
          const SizedBox(height: 16),
          Text(
            'Logo Uploaden',
            style: getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'JPG, SVG, JPEG, PNG minder dan 1MB',
            style: getTextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryGrey,
            ),
          ),
        ],
      ),
    );
  }
}
