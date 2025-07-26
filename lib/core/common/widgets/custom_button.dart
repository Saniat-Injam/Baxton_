import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.backgroundColor = Colors.red,
    this.borderColor = Colors.green,
    this.textStyle,
    required this.onPress,
    this.textcolor = Colors.yellowAccent,
    SizedBox? child,
  });
  final Color textcolor;
  final String title;
  final Color backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Center(
        child: Container(
          width: double.infinity,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? backgroundColor),
            borderRadius: BorderRadius.circular(32),
            color: backgroundColor,
          ),
          child: Center(
            child: Text(
              title,
              style: getTextStyle(
                fontSize: 16,
                color: textcolor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
