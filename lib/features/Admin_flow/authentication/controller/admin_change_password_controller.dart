import 'package:baxton/core/urls/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminChangePasswordController extends GetxController {
  final newPasswordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    newPasswordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    super.onClose();
  }

  void clearErrors() {
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  bool validatePasswords() {
    clearErrors();
    bool isValid = true;

    if (newPasswordEditingController.text.isEmpty) {
      newPasswordError.value = 'Password cannot be empty';
      isValid = false;
    } else if (newPasswordEditingController.text.length < 8) {
      newPasswordError.value = 'Password must be at least 8 characters';
      isValid = false;
    }

    if (confirmPasswordEditingController.text.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      isValid = false;
    } else if (newPasswordEditingController.text !=
        confirmPasswordEditingController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    return isValid;
  }

  Future<void> changePassword(String email, String code) async {
    if (!validatePasswords()) {
      debugPrint('Password validation failed.');
      return;
    }

    try {
      EasyLoading.show(status: 'Changing Password...');

      final newPassword = newPasswordEditingController.text;

      final requestBody = {
        'email': email,
        'newPassword': newPassword,
        'code': code,
      };

      final response = await http.post(
        Uri.parse(Urls.resetpassword),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          EasyLoading.showSuccess(responseData['message'] ?? 'Password changed successfully!');
          Get.offAllNamed('/adminloginscreen');
        } else {
          EasyLoading.showError(responseData['message'] ?? 'Failed to change password');
        }
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] ?? 'Failed to change password';
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      debugPrint('Exception occurred: $e');
      EasyLoading.showError('Error changing password: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}