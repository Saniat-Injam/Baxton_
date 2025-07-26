import 'package:flutter/material.dart';

class RequestTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLines; // Added maxLines parameter

  RequestTextfield({
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines, // Optional maxLines parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines, // Apply maxLines here
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xffC0C0C0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 1, color: Color(0xffC0C0C0)),
        ),
      ),
    );
  }
}
