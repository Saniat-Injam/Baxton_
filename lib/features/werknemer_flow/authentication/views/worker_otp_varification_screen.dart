// import 'package:baxton/core/common/widgets/custom_continue_button.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/features/werknemer_flow/authentication/controllers/worker_forget_password_controller.dart';
// import 'package:baxton/features/werknemer_flow/authentication/views/worker_change_password_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class WorkerOtpVarificationScreen extends StatelessWidget {
//   WorkerOtpVarificationScreen({super.key});
//   final WorkerForgetPasswordController workerForgetPasswordController =
//       Get.find<WorkerForgetPasswordController>();

//   @override
//   Widget build(BuildContext context) {
//     //final args = Get.arguments as Map<String, dynamic>? ?? {};
//     final Map<String, dynamic> args = Get.arguments ?? {};
//     final String email = args['email'] ?? '';

//     return Scaffold(
//       backgroundColor: const Color(0xffF9FAFB),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 const SizedBox(height: 40),
//                 Text(
//                   'Voer de \nbevestigingscode in',
//                   style: TextStyle(
//                     color: const Color(0xFF333333),
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 32),
//                 _buildPinCodeTextField(context),
//                 const SizedBox(height: 20),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'De verificatiecode is verzonden naar het email',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   email,
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Obx(
//                   () => GestureDetector(
//                     onTap:
//                         workerForgetPasswordController.resendEnabled.value
//                             ? () =>
//                                 workerForgetPasswordController.startCountdown()
//                             : null,
//                     child: Text(
//                       workerForgetPasswordController.resendEnabled.value
//                           ? "Code opnieuw verzenden"
//                           : "Code opnieuw verzenden in ${workerForgetPasswordController.countdown.value}s",
//                       style: TextStyle(
//                         color: Color(0xff1E90FF),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 40),
//                 // CustomContinueButton(
//                 //   onTap: () {
//                 //     Get.to(WorkerChangePasswordScreen());
//                 //   },
//                 //   title: "Doorgaan",
//                 //   backgroundColor: AppColors.buttonPrimary,
//                 //   textColor: Colors.white,
//                 // ),
//                 CustomContinueButton(
//                   onTap: () {
//                     workerForgetPasswordController.verifyResetCode(email);
//                   },
//                   title: "Doorgaan",
//                   backgroundColor: AppColors.buttonPrimary,
//                   textColor: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPinCodeTextField(BuildContext context) {
//     return PinCodeTextField(
//       length: 6,
//       obscureText: false,
//       animationType: AnimationType.fade,
//       keyboardType: TextInputType.number,
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(8),
//         fieldHeight: 40,
//         fieldWidth: 40,
//         activeFillColor: Colors.grey[200],
//         selectedFillColor: Colors.grey[200],
//         inactiveFillColor: Colors.grey[200],
//         inactiveColor: AppColors.buttonPrimary.withValues(alpha: 0.25),
//         selectedColor: Colors.grey[200],
//         activeColor: Colors.grey[200],
//       ),
//       animationDuration: const Duration(milliseconds: 300),
//       backgroundColor: Colors.transparent,
//       controller: workerForgetPasswordController.pinController,
//       onCompleted: (v) => workerForgetPasswordController.validateForm(),
//       onChanged: (value) => workerForgetPasswordController.validateForm(),
//       appContext: context,
//     );
//   }
// }

// import 'package:baxton/core/common/widgets/custom_continue_button.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/features/werknemer_flow/authentication/controllers/worker_forget_password_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class WorkerOtpVarificationScreen extends StatelessWidget {
//   WorkerOtpVarificationScreen({super.key});
//   final WorkerForgetPasswordController controller = Get.find<WorkerForgetPasswordController>();

//   @override
//   Widget build(BuildContext context) {
//     final args = Get.arguments ?? {};
//     final String email = args['email'] ?? '';

//     return Scaffold(
//       backgroundColor: const Color(0xffF9FAFB),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               const SizedBox(height: 40),
//               Text(
//                 'Voer de \nbevestigingscode in',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: const Color(0xFF333333),
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               _buildPinCodeTextField(context),
//               const SizedBox(height: 20),
//               Text(
//                 'De verificatiecode is verzonden naar:',
//                 style: TextStyle(color: Colors.grey[600], fontSize: 16),
//               ),
//               Text(email, style: TextStyle(color: Colors.red, fontSize: 16)),
//               const SizedBox(height: 20),
//               Obx(
//                 () => GestureDetector(
//                   onTap:
//                       controller.resendEnabled.value
//                           ? controller.startCountdown
//                           : null,
//                   child: Text(
//                     controller.resendEnabled.value
//                         ? "Code opnieuw verzenden"
//                         : "Opnieuw verzenden in ${controller.countdown.value}s",
//                     style: TextStyle(
//                       color: Color(0xff1E90FF),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               CustomContinueButton(
//                 onTap: () {
//                   Get.toNamed('/set-password', arguments: {"email": email});
//                 },
//                 title: "Doorgaan",
//                 backgroundColor: AppColors.buttonPrimary,
//                 textColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPinCodeTextField(BuildContext context) {
//     return PinCodeTextField(
//       appContext: context,
//       length: 6,
//       obscureText: false,
//       controller: controller.pinController,
//       onCompleted: (v) {},
//       onChanged: (value) {},
//       animationType: AnimationType.fade,
//       keyboardType: TextInputType.number,
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(8),
//         fieldHeight: 40,
//         fieldWidth: 40,
//         inactiveColor: AppColors.buttonPrimary.withOpacity(0.3),
//         selectedColor: Colors.grey[200],
//         activeColor: Colors.grey[200],
//         activeFillColor: Colors.grey[200],
//         selectedFillColor: Colors.grey[200],
//         inactiveFillColor: Colors.grey[200],
//       ),
//     );
//   }
// }

import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/authentication/controllers/worker_forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WorkerOtpVarificationScreen extends StatelessWidget {
  WorkerOtpVarificationScreen({super.key});
  final controller = Get.find<WorkerForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final email = args['email'] ?? '';

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Voer de \nbevestigingscode in',
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildPinCodeTextField(context),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'De verificatiecode is verzonden naar het email',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => GestureDetector(
                    onTap:
                        controller.resendEnabled.value
                            ? () => controller.startCountdown()
                            : null,
                    child: Text(
                      controller.resendEnabled.value
                          ? "Code opnieuw verzenden"
                          : "Code opnieuw verzenden in ${controller.countdown.value}s",
                      style: TextStyle(
                        color: Color(0xff1E90FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                CustomContinueButton(
                  onTap: () => controller.verifyOtp(email),
                  title: "Doorgaan",
                  backgroundColor: AppColors.buttonPrimary,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 40,
        fieldWidth: 40,
        activeFillColor: Colors.grey[200],
        selectedFillColor: Colors.grey[200],
        inactiveFillColor: Colors.grey[200],
        inactiveColor: AppColors.buttonPrimary.withValues(alpha: 0.25),
        selectedColor: Colors.grey[200],
        activeColor: Colors.grey[200],
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      controller: controller.pinController,
      onCompleted: (v) => controller.validateForm(),
      onChanged: (value) => controller.validateForm(),
      appContext: context,
    );
  }
}
