import 'package:flutter/material.dart';

import '../styles/global_text_style.dart' show getTextStyle;

class CustomContinueButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  const CustomContinueButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Text(
            title,
            style: getTextStyle(
              color: textColor!,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
