// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/features/werknemer_flow/onboarding/controller/werknemer_onboarding_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WOnbScreen extends StatelessWidget {
//   final WOnbController wOnbController = Get.put(WOnbController());

//   WOnbScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         final page = wOnbController.wOnbPages[wOnbController.currentPage.value];
//         final topPadding =
//             wOnbController.topPaddings[wOnbController.currentPage.value];

//         return Padding(
//           padding: EdgeInsets.only(top: topPadding, left: 16, right: 16),
//           child: Column(
//             children: [
//               // Onboarding Image
//               Image.asset(page.imagePath),
//               SizedBox(height: 20),

//               // Title
//               Text(
//                 page.title,
//                 style: getTextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primaryBlack,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 12),

//               //Description
//               Text(
//                 page.description,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.secondaryBlack,
//                   letterSpacing: 0.2,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),

//               // Page Indicator
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   wOnbController.wOnbPages.length,
//                   (index) => Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     width: wOnbController.currentPage.value == index ? 8 : 7,
//                     height: wOnbController.currentPage.value == index ? 8 : 7,
//                     decoration: BoxDecoration(
//                       color:
//                           wOnbController.currentPage.value == index
//                               ? AppColors.primaryBlue
//                               : AppColors.primaryGrey,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 48),

//               // Button
//               SizedBox(
//                 height: 44,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: wOnbController.goToNextPage,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1E90FF),

//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(62),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                   ),
//                   child: Text(
//                     'Aan de slag',
//                     style: getTextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.primaryWhite,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 69),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/features/werknemer_flow/onboarding/controller/werknemer_onboarding_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WOnbScreen extends StatelessWidget {
//   final WOnbController wOnbController = Get.put(WOnbController());

//   WOnbScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final screenHeight = size.height;
//     final screenWidth = size.width;

//     return Scaffold(
//       body: Obx(() {
//         final page = wOnbController.wOnbPages[wOnbController.currentPage.value];
//         final topPadding =
//             wOnbController.topPaddings[wOnbController.currentPage.value];

//         return Padding(
//           padding: EdgeInsets.only(
//             top:
//                 screenHeight *
//                 (topPadding / screenHeight), // normalize top padding
//             left: screenWidth * 0.04,
//             right: screenWidth * 0.04,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Image
//               Column(
//                 children: [
//                   Image.asset(
//                     page.imagePath,
//                     height:
//                         screenHeight *
//                         wOnbController.imageHeights[wOnbController
//                             .currentPage
//                             .value],
//                     fit: BoxFit.contain,
//                   ),

//                   SizedBox(height: screenHeight * 0.03),

//                   // Title
//                   Text(
//                     page.title,
//                     style: getTextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.primaryBlack,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: screenHeight * 0.012),

//                   // Description
//                   Text(
//                     page.description,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.secondaryBlack,
                      
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: screenHeight * 0.011),

//                   // Page Indicator
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       wOnbController.wOnbPages.length,
//                       (index) => Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 3),
//                         width:
//                             wOnbController.currentPage.value == index ? 8 : 7,
//                         height:
//                             wOnbController.currentPage.value == index ? 8 : 7,
//                         decoration: BoxDecoration(
//                           color:
//                               wOnbController.currentPage.value == index
//                                   ? AppColors.primaryBlue
//                                   : AppColors.primaryGrey,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   )
//                 ],
//               ),

//               // Button at bottom
//               Padding(
//                 padding: EdgeInsets.only(bottom: screenHeight * 0.10),
//                 child: SizedBox(
//                   height: 44,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: wOnbController.goToNextPage,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E90FF),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(62),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                     ),
//                     child: Text(
//                       'Aan de slag',
//                       style: getTextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.primaryWhite,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }


import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/onboarding/controller/werknemer_onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WOnbScreen extends StatelessWidget {
  final WOnbController wOnbController = Get.put(WOnbController());

  WOnbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    return Scaffold(
      body: Obx(() {
        final page = wOnbController.wOnbPages[wOnbController.currentPage.value];
        final topPadding =
            wOnbController.topPaddings[wOnbController.currentPage.value];

        return Padding(
          padding: EdgeInsets.only(
            top: screenHeight * (topPadding / screenHeight), // normalize top padding
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image
              Column(
                children: [
                  Image.asset(
                    page.imagePath,
                    height: screenHeight *
                        wOnbController.imageHeights[wOnbController
                            .currentPage
                            .value], // Adjust image height
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Title
                  Text(
                    page.title,
                    style: getTextStyle(
                      fontSize: screenWidth * 0.065, // Adjust font size for responsiveness
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.012),

                  // Description
                  Text(
                    page.description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, // Adjust font size for responsiveness
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.011),

                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      wOnbController.wOnbPages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: wOnbController.currentPage.value == index ? 8 : 7,
                        height: wOnbController.currentPage.value == index ? 8 : 7,
                        decoration: BoxDecoration(
                          color: wOnbController.currentPage.value == index
                              ? AppColors.primaryBlue
                              : AppColors.primaryGrey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),

              // Button at bottom
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.10),
                child: SizedBox(
                  height: screenHeight * 0.07, // Adjust button height for responsiveness
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: wOnbController.goToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E90FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Adjust padding
                    ),
                    child: Text(
                      'Aan de slag',
                      style: getTextStyle(
                        fontSize: screenWidth * 0.045, // Adjust font size for button text
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
