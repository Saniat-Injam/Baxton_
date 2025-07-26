import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool enabled;

  const CustomProfileTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              color: AppColors.textSixth,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        Expanded(
          child: TextField(
            cursorHeight: 20,
            controller: controller,
            enabled: enabled,
            textAlign: TextAlign.right,
            style: getTextStyle(
              fontSize: 14,
              color: AppColors.primaryGold,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: getTextStyle(
                fontSize: 14,
                color: AppColors.primaryGold,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
