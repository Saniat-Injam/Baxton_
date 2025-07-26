import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color buttonColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final Color textColor;
  final Color iconColor;
  final Color? borderColor;
  final double borderWidth;
  final bool isPrefix; // New parameter to control icon position

  const CustomIconButton({
    required this.text,
    required this.icon,
    required this.onTap,
    this.buttonColor = const Color(0xFF1E90FF),
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.height = 48.0,
    this.width = double.infinity,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.borderColor,
    this.borderWidth = 0.0,
    this.isPrefix = true, // Default to prefix icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(48),
          border: borderWidth > 0
              ? Border.all(color: borderColor ?? Colors.transparent, width: borderWidth)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isPrefix
              ? [
                  Icon(icon, color: iconColor, size: 20),
                  SizedBox(width: 8),
                  Text(
                    text,
                    style: getTextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  ),
                ]
              : [
                  Text(
                    text,
                    style: getTextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(icon, color: iconColor, size: 20),
                ],
        ),
      ),
    );
  }
}
