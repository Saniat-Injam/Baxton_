import 'dart:convert';

import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/admin_home_screens.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminLoginController extends GetxController {
  // TextEditingController passwordControler = TextEditingController();
  // TextEditingController emailController = TextEditingController();

  // var isFromValid = false.obs;
  // void validateFrom() {
  //   isFromValid.value =
  //       emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  // }

  // var isPasswordVisible = false.obs;
  // void togglePasswordVisibility() {
  //   isPasswordVisible.value = !isPasswordVisible.value;
  // }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  Future<void> login() async {
    EasyLoading.show(status: 'Logging in...');
    try {
      Map<String, dynamic> requestBody = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };
      final response = await http.post(
        Uri.parse(Urls.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      debugPrint("================1${response.body}");
      debugPrint("===============${response.statusCode}");
      final responseData = jsonDecode(response.body);

      // Check if the status code is success
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Extract relevant data from response
        String token = responseData["data"]["token"] ?? "";
        String userId = responseData["data"]["user"]["id"] ?? "";
        String role = responseData["data"]["user"]["UserType"] ?? "";
        String isProfileCreated =
            responseData["data"]["user"]["isProfileCreated"]?.toString() ??
            "false";
        String profileId =
            responseData["data"]["user"]["adminProfile"] != null
                ? responseData["data"]["user"]["adminProfile"]["id"] ?? ""
                : "";

        // Save the authentication data using AuthService
        await AuthService.saveAuthData(
          token,
          userId,
          role,
          isProfileCreated,
          profileId,
        );
        EasyLoading.showSuccess("Login Successful");
        Get.offAll(AdminHomeScreen());
      } else {
        // Safely access message or provide a fallback if null
        String message = responseData["message"] ?? "Login Failed";
        EasyLoading.showError(message);
      }
    } catch (e) {
      EasyLoading.showError("An error occurred");
      debugPrint("Login Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
