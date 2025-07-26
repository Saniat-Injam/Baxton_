import 'dart:async';
import 'dart:convert';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/authentication/screens/admin_otp_screen.dart';
import 'package:baxton/features/klant_flow/authentication/screens/k_chnage_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminForgetPasswordController extends GetxController {
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
        Uri.parse(Urls.forgetpassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final body = jsonDecode(res.body) as Map<String, dynamic>;

      if ((res.statusCode == 200 || res.statusCode == 201) &&
          body['success'] == true) {
        EasyLoading.showSuccess(body['message'] ?? 'OTP sent successfully');
        startCountdown();

        Get.to(() => AdminOtpScreen(), arguments: {'email': email});
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
        Uri.parse(Urls.verifycode),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'code': code,
        }),
      );

      final body = jsonDecode(res.body) as Map<String, dynamic>;

      if ((res.statusCode == 200 || res.statusCode == 201) &&
          body['success'] == true) {
        EasyLoading.showSuccess(body['message'] ?? 'OTP verified successfully');
        Get.to(() => KChnagePasswordScreen(email: email, code: pinController.text));
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