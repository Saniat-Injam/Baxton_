// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WorkerLoginScreenController extends GetxController {
//   TextEditingController passwordControler = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   var isPasswordVisible = false.obs;
//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   // Controller for the text field
//   TextEditingController categoryController = TextEditingController();

//   // Dummy userId for new category (replace with actual userId)
//   String userId = "user123";

//   var isFromValid = false.obs;
//   void validateFrom() {
//     isFromValid.value =
//         emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
//   }

//   void clearFields() {
//     emailController.clear();
//     passwordControler.clear();
//   }

// }

import 'dart:convert';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/werknemer_flow/profile_setup/view/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:baxton/features/werknemer_flow/bottom_navigation_bar/screens/bottom_navbar.dart';

class WorkerLoginScreenController extends GetxController {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Controller for the text field
  TextEditingController categoryController = TextEditingController();

  // Dummy userId for new category (replace with actual userId)
  String userId = "user123";

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  }

  Future<void> login() async {
    EasyLoading.show(status: 'Logging in...');
    try {
      Map<String, dynamic> requestBody = {
        'email': emailController.text.trim(),
        'password': passwordControler.text.trim(),
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
        String role = responseData["data"]["user"]["role"] ?? "";
        String isProfileCreated =
            responseData["data"]["user"]["isProfileCreated"]?.toString() ??
            "false";
        String profileId =
            responseData["data"]["user"]["workerProfile"] != null
                ? responseData["data"]["user"]["workerProfile"]["id"] ?? ""
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

        // Navigate based on isProfileCreated
        // if (isProfileCreated == "true") {
        //   Get.offAll(() => BottomNavbar());
        // } else {
        //   Get.offAll(() => ProfileSetupView());
        // }
        if (isProfileCreated == "true") {
          Get.offAll(() => BottomNavbar());
        } else {
          // Navigate to profile setup screen
          //Get.offAllNamed('/worker-profile-setup');
          Get.offAll(() => WorkerProfileSetupScreen());
        }
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

  void clearFields() {
    emailController.clear();
    passwordControler.clear();
  }

  // Fetch categories from the API
}
