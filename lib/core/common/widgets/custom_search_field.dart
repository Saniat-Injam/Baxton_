// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomSearchTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final Widget prefixIcon;
//   final double borderRadius;

//   const CustomSearchTextField({
//     super.key,
//     required this.hintText,
//     required this.controller,
//     required this.prefixIcon,
//     this.borderRadius = 44, // Default value of 44
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(width: 1, color: Color(0xffEBEBEB)),
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//       child: TextField(
//         controller: controller,
//         style: GoogleFonts.poppins(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//           color: Colors.black,
//         ),
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xFFABB7C2),
//           ),
//           prefixIcon: prefixIcon,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: 12,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             borderSide: BorderSide(color: Colors.transparent),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget prefixIcon;
  final double borderRadius;

  const CustomSearchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.borderRadius = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xffEBEBEB)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFABB7C2),
          ),
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}