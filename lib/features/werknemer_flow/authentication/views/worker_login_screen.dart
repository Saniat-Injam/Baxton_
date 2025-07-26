// import 'dart:io';
// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
// import 'package:baxton/core/common/widgets/custom_continue_button.dart';
// import 'package:baxton/core/utils/constants/colors.dart';

// import 'package:baxton/features/werknemer_flow/authentication/controllers/login_controller.dart';
// import 'package:baxton/features/werknemer_flow/authentication/views/forget_password_screen.dart';
// import 'package:baxton/features/werknemer_flow/authentication/views/worker_registration_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WorkerLoginScreen extends StatelessWidget {
//   WorkerLoginScreen({super.key});
//   final WorkerLoginScreenController wloginController = Get.put(
//     WorkerLoginScreenController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         forceMaterialTransparency: true,
//         title: Text(
//           'Inloggen',
//           style: getTextStyle(
//             color: AppColors.textPrimary,
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//           child: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 32),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'E-mail',
//                       style: getTextStyle(
//                         color: AppColors.textPrimary,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 AuthCustomTextField(
//                   onChanged: (value) {},
//                   controller: wloginController.emailController,
//                   text: 'Voer uw telefoonnummer in',
//                   borderColor: AppColors.borderColor,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Incorrect email or password';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Wachtwoord',
//                       style: getTextStyle(
//                         color: AppColors.textPrimary,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Obx(() {
//                   return AuthCustomTextField(
//                     onChanged: (value) {
//                       wloginController.validateFrom();
//                     },
//                     text: 'Voer uw telefoonnummer in',
//                     borderColor: AppColors.borderColor,
//                     controller: wloginController.passwordControler,
//                     obscureText: wloginController.isPasswordVisible.value,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Incorrect email or password';
//                       }
//                       return null;
//                     },
//                   );
//                 }),
//                 SizedBox(height: 40),
//                 CustomContinueButton(
//                   onTap: () {
//                     //Get.offAll(BottomNavbar());
//                     wloginController.login();
//                   },
//                   textColor: Colors.white,
//                   title: "Inloggen",
//                   backgroundColor: AppColors.buttonPrimary,
//                 ),
//                 SizedBox(height: 25),
//                 Align(
//                   alignment: Alignment.center,
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(ForgetPasswordScreen());
//                     },
//                     child: Text(
//                       'Wachtwoord vergeten?',
//                       style: getTextStyle(
//                         color: AppColors.textFourth,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 36),

//                 SizedBox(height: 32),
//                 if (Platform.isAndroid || Platform.isIOS) ...[],
//                 SizedBox(height: 16),
//                 if (Platform.isIOS) ...[],
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Heeft u geen account?",
//                       style: getTextStyle(
//                         color: Color(0xFF333333),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(() => WorkerRegistrationScreen());
//                       },
//                       child: Text(
//                         "Aanmelden",
//                         style: getTextStyle(
//                           color: AppColors.primaryGold,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/authentication/controllers/worker_login_controller.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/worker_forget_password_screen.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/worker_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerLoginScreen extends StatelessWidget {
  WorkerLoginScreen({super.key});

  final WorkerLoginScreenController wloginController = Get.put(
    WorkerLoginScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Inloggen',
          style: getTextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),

                // Email label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E-mail',
                    style: getTextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Email input
                AuthCustomTextField(
                  onChanged: (value) {
                    wloginController.validateFrom();
                  },
                  controller: wloginController.emailController,
                  text: 'Voer uw e-mail in',
                  borderColor: AppColors.borderColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ongeldig e-mail of wachtwoord';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),

                // Password label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Wachtwoord',
                    style: getTextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Password input
                Obx(() {
                  return AuthCustomTextField(
                    onChanged: (value) {
                      wloginController.validateFrom();
                    },
                    controller: wloginController.passwordControler,
                    text: 'Voer uw wachtwoord in',
                    borderColor: AppColors.borderColor,
                    obscureText: !wloginController.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        wloginController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: wloginController.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ongeldig e-mail of wachtwoord';
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(height: 40),

                // Login Button
                CustomContinueButton(
                  onTap: () {
                    wloginController.login();
                  },
                  textColor: Colors.white,
                  title: "Inloggen",
                  backgroundColor: AppColors.buttonPrimary,
                ),
                SizedBox(height: 25),

                // Forgot Password
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => WorkerForgetPasswordScreen());
                    },
                    child: Text(
                      'Wachtwoord vergeten?',
                      style: getTextStyle(
                        color: AppColors.textFourth,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36),

                SizedBox(height: 32),
                if (Platform.isAndroid || Platform.isIOS) ...[],
                SizedBox(height: 16),
                if (Platform.isIOS) ...[],
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),

                // Registration Redirect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Heeft u geen account?",
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => WorkerRegistrationScreen());
                      },
                      child: Text(
                        "Aanmelden",
                        style: getTextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
