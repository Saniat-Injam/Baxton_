import 'dart:convert';

import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/werknemer_flow/authentication/views/worker_login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkerRegistrationController extends GetxController {
  // // Declare the controllers for text fields
  // TextEditingController nameController = TextEditingController();
  // TextEditingController phoneController1 = TextEditingController();
  // TextEditingController emailController1 = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController retypepasswordController = TextEditingController();
  // // TextEditingController pinController = TextEditingController();
  // final isLoading = false.obs;
  // final responseMessage = ''.obs;
  // var isPasswordVisible = false.obs;
  // void togglePasswordVisibility() {
  //   isPasswordVisible.value = !isPasswordVisible.value;
  // }

  // var isPasswordVisible1 = false.obs;
  // void togglePasswordVisibility1() {
  //   isPasswordVisible1.value = !isPasswordVisible1.value;
  // }

  // var isFromValid = false.obs;
  // void validateFrom() {
  //   isFromValid.value =
  //       nameController.text.isNotEmpty &&
  //       phoneController1.text.isNotEmpty &&
  //       emailController1.text.isNotEmpty &&
  //       passwordController.text.isNotEmpty &&
  //       retypepasswordController.text.isNotEmpty;
  // }

  // Declare the controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmedPasswordController = TextEditingController();
  // TextEditingController pinController = TextEditingController();
  final isLoading = false.obs;
  final responseMessage = ''.obs;
  var isPasswordVisible = false.obs;
  var isConfirmedPasswordVisible = false.obs;
  var isPasswordFieldEmpty = true.obs;
  var isConfirmedPasswordFieldEmpty = true.obs;
  var isFromValid = false.obs;
  get togglePasswordVisibility1 => null;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmedPasswordVisibility() {
    isConfirmedPasswordVisible.value = !isConfirmedPasswordVisible.value;
  }

  void onPasswordChanged(String value) {
    isPasswordFieldEmpty.value = value.isEmpty;
  }

  void onConfirmedPasswordChanged(String value) {
    isConfirmedPasswordFieldEmpty.value = value.isEmpty;
  }

  void validateForm() {
    isFromValid.value =
        nameController.text.isNotEmpty &&
        phoneController1.text.isNotEmpty &&
        emailController1.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmedPasswordController.text.isNotEmpty;
  }

  Future<void> registerUser() async {
    debugPrint('Starting registerUser function');

    try {
      // Show loading indicator before the actual work begins
      EasyLoading.show(status: 'Loading...');
      debugPrint('EasyLoading.show called');

      final user = {
        'email': emailController1.text.trim(),
        'password': passwordController.text,
        'name': nameController.text.trim(),
        'phone': phoneController1.text.trim(),
        'UserType': 'WORKER',
      };

      debugPrint('User data prepared: ${jsonEncode(user)}');

      final response = await http.post(
        Uri.parse(Urls.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );

      debugPrint('HTTP POST request sent to ${Urls.register}');
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      debugPrint('Parsed response data: $responseData');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Successful response received, navigating to LoginScreen');
        EasyLoading.showSuccess('Registration successful!');
        Get.offAll(() => WorkerLoginScreen());
      } else {
        if (responseData['message'] != null &&
            responseData['message'].contains('User already exist')) {
          // Handle user already exists error
          EasyLoading.showError('Email or phone number already in use.');
        } else {
          responseMessage.value = _parseError(responseData);
          EasyLoading.showError(responseMessage.value);
        }
        debugPrint('Error message: ${responseMessage.value}');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
      EasyLoading.showError('An unexpected error occurred');
    } finally {
      // Always dismiss loading indicator, even on error
      EasyLoading.dismiss();
      debugPrint('EasyLoading.dismiss called');
    }

    debugPrint('registerUser function completed');
  }

  String _parseError(dynamic data) {
    try {
      if (data is Map) {
        if (data['error'] != null) return data['error'].toString();
        if (data['message'] != null) return data['message'].toString();
        if (data['errors'] != null) {
          return data['errors'].values.first.join('\n');
        }
      }
      return 'Registration failed. Please try again.';
    } catch (e) {
      return 'Registration failed. Please try again.';
    }
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  // Properly dispose of controllers when the controller is disposed
}
