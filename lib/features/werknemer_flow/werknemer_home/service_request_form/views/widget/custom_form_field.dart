import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final Function(String) onChanged;
  final int maxLines;
  final String? initial;
  final double? height;
  final Color? borderColor;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    required this.onChanged,
    this.maxLines = 1,
    this.initial,
    this.height,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        borderColor ?? AppColors.formFieldBorderColor;
    return Column(
      // Removed outer Padding here
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryBlack,
            ),
          ),
          const SizedBox(height: 12), // Match with MyDropdown
        ],
        SizedBox(
          height: height,
          child: TextFormField(
            initialValue: initial,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: effectiveBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: effectiveBorderColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryRed),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryRed, width: 2),
              ),
            ),
            onChanged: onChanged,
            validator:
                (val) =>
                    val == null || val.isEmpty
                        ? 'please fill up the form correctly'
                        : null,
          ),
        ),
      ],
    );
  }
}
