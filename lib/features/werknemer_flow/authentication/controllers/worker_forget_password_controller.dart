// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ForgetPasswordController extends GetxController {
//   // Controllers - GetX will manage disposal automatically
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final pinController = TextEditingController();

//   // Observables
//   var resendEnabled = true.obs;
//   var isFormValid = false.obs;
//   var errorColor = false.obs;
//   var toggleValue = 0.obs;
//   var countdown = 120.obs;
//   Timer? timer;

//   void toggle() {
//     toggleValue.value = toggleValue.value == 0 ? 1 : 0;
//   }

//   void validateForm() {
//     isFormValid.value = pinController.text.length == 6;
//   }

//   void startCountdown() {
//     resendEnabled.value = false;
//     countdown.value = 120;
//     timer?.cancel(); // Cancel any existing timer
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (countdown.value > 0) {
//         countdown.value--;
//       } else {
//         resendEnabled.value = true;
//         timer.cancel();
//       }
//     });
//   }

//     Future<void> forgetpasswordValidatepin(String email) async {

//     Get.snackbar(
//       'Success',
//       'OTP Verified for $email',
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );
//   }

//   @override
//   void onClose() {
//     timer?.cancel();
//     super.onClose();
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'package:baxton/core/utils/constants/api_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class WorkerForgetPasswordController extends GetxController {
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final pinController = TextEditingController();

//   var resendEnabled = true.obs;
//   var isFormValid = false.obs;
//   var errorColor = false.obs;
//   var toggleValue = 0.obs;
//   var countdown = 120.obs;
//   Timer? timer;

//   void toggle() {
//     toggleValue.value = toggleValue.value == 0 ? 1 : 0;
//   }

//   void validateForm() {
//     isFormValid.value = pinController.text.length == 6;
//   }

//   void startCountdown() {
//     resendEnabled.value = false;
//     countdown.value = 120;
//     timer?.cancel();
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (countdown.value > 0) {
//         countdown.value--;
//       } else {
//         resendEnabled.value = true;
//         timer.cancel();
//       }
//     });
//   }

//   Future<void> sendResetCode() async {
//     final email = emailController.text.trim();

//     if (email.isEmpty || !GetUtils.isEmail(email)) {
//       EasyLoading.showError("Voer een geldig e-mailadres in");
//       return;
//     }

//     try {
//       EasyLoading.show(status: "Bezig met verzenden...");
//       final response = await http.post(
//         Uri.parse(ApiConstants.resetPasswordUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email}),
//       );

//       if (response.statusCode == 200) {
//         EasyLoading.dismiss();
//         EasyLoading.showSuccess("Code verzonden naar $email");
//         Get.toNamed(
//           '/forget-password-otp',
//         ); // Or use: Get.to(ForgetPasswordOtpScreen());
//       } else {
//         EasyLoading.dismiss();
//         EasyLoading.showError("Fout: ${response.body}");
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       EasyLoading.showError("Er is iets misgegaan. Probeer opnieuw.");
//     }
//   }

//   @override
//   void onClose() {
//     timer?.cancel();
//     super.onClose();
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:baxton/core/utils/constants/api_constants.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/worker_change_password_screen.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/worker_otp_varification_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkerForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final pinController = TextEditingController();

  var resendEnabled = true.obs;
  var isFormValid = false.obs;
  var errorColor = false.obs;
  var toggleValue = 0.obs; // Keep for UI toggle only
  var countdown = 120.obs;
  Timer? timer;

  void toggle() {
    toggleValue.value = toggleValue.value == 0 ? 1 : 0;
  }

  void validateForm() {
    isFormValid.value = pinController.text.length == 6;
  }

  void startCountdown() {
    resendEnabled.value = false;
    countdown.value = 120;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> forgetPassword() async {
    try {
      EasyLoading.show(status: 'Sending OTP…');

      final email = emailController.text.trim();
      if (email.isEmpty || !GetUtils.isEmail(email)) {
        EasyLoading.showError('Please enter a valid email');
        return;
      }

      final res = await http.post(
        Uri.parse(ApiConstants.resetPasswordUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final body = jsonDecode(res.body) as Map<String, dynamic>;

      if ((res.statusCode == 200 || res.statusCode == 201) &&
          body['success'] == true) {
        EasyLoading.showSuccess(body['message'] ?? 'OTP sent successfully');
        startCountdown();

        Get.to(
          () => WorkerOtpVarificationScreen(),
          arguments: {'email': email},
        );
      } else {
        EasyLoading.showError(body['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> verifyOtp(String email) async {
    try {
      EasyLoading.show(status: 'Verifying OTP…');

      final code = pinController.text.trim();
      if (code.length != 6) {
        EasyLoading.showError('Please enter a valid 6-digit OTP');
        return;
      }

      final res = await http.post(
        Uri.parse(ApiConstants.verifyResetCodeUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': code}),
      );

      final body = jsonDecode(res.body) as Map<String, dynamic>;

      if ((res.statusCode == 200 || res.statusCode == 201) &&
          body['success'] == true) {
        EasyLoading.showSuccess(body['message'] ?? 'OTP verified successfully');
        Get.to(
          () => WorkerChangePasswordScreen(
            email: email,
            code: pinController.text,
          ),
        );
      } else {
        EasyLoading.showError(body['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    emailController.dispose();
    pinController.dispose();
    super.onClose();
  }
}
