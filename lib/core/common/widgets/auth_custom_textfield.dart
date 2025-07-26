import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class AuthCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;
  final double? borderRadius;

  AuthCustomTextField({
    super.key,
    required this.controller,
    required this.text,
    this.suffixIcon,
    this.onTap,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.borderColor,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? const Color(0xFF333333);
    final effectiveBorderRadius = borderRadius ?? 32.0;
    return TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: obscureText!,
      style: getTextStyle(
        color: obscureText! ? Color(0xFF0047AB) : Color(0xFF1F1F1F),
        fontWeight: obscureText! ? FontWeight.bold : FontWeight.w400,
      ),
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintText: text,
        suffixIcon: suffixIcon,
        hintStyle: getTextStyle(
          color: Color(0xFF898989),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          borderSide: BorderSide(width: 1, color: effectiveBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(width: 1, color: Color(0xFF333333)),
        ),
        errorStyle: getTextStyle(color: Color(0xFFE53935), fontSize: 12),
        errorMaxLines: 1,
        isDense: true,
      ),
      cursorHeight: 25,
    );
  }
}
