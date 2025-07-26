import 'package:flutter/cupertino.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart'; // Assuming your color constants are here

class CommonButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final double height;
  final double width;
  final double borderRadius;

  // Constructor to initialize values
  // ignore: use_super_parameters
  const CommonButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.fontSize = 16.0,
    this.textColor = AppColors.textWhite,
    this.backgroundColor = AppColors.buttonPrimary,
    this.height = 44.0,
    this.width = double.infinity,
    this.borderRadius = 62.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(), // Calling the passed onTap function
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: getTextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
