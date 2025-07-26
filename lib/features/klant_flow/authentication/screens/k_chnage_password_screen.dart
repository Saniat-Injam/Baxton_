import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/authentication/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KChnagePasswordScreen extends StatelessWidget {
  final String? email;
  final String? code;
  const KChnagePasswordScreen({super.key, this.email, this.code});

  @override
  Widget build(BuildContext context) {
    final KChangePasswordController controller = Get.put(
      KChangePasswordController(),
    );

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Wachtwoord instellen',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Wachtwoord',
                  style: getTextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                  () => AuthCustomTextField(
                    controller: controller.newPasswordEditingController,
                    text: '',
                    obscureText: !controller.isPasswordVisible.value,
                    onChanged: (value) {
                controller.newPasswordError.value = '';
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xff37B874),
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (controller.newPasswordError.value.isNotEmpty) {
                        return controller.newPasswordError.value;
                      }
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Herhaal wachtwoord',
                  style: getTextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                  () => AuthCustomTextField(
                    controller: controller.confirmPasswordEditingController,
                    text: '',
                    obscureText: !controller.isPasswordVisible.value,
                    onChanged: (value) {
                      controller.confirmPasswordError.value = '';
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xff37B874),
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (controller.confirmPasswordError.value.isNotEmpty) {
                        return controller.confirmPasswordError.value;
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value !=
                          controller.newPasswordEditingController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 44.0),
                CustomContinueButton(
                  title: 'Wijzigingen opslaan',
                  backgroundColor: AppColors.buttonPrimary,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (controller.validatePasswords()) {
                        if (email != null && code != null) {
                          controller.changePassword(email!, code!);
                        } else {
                          Get.snackbar(
                            'Error',
                            'Email or OTP code is missing',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    }
                  },
                  textColor: Color(0xffffffff),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}