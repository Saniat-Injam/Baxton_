// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/Admin_flow/authentication/controller/admin_login_controller.dart';
import 'package:baxton/features/Admin_flow/authentication/screens/admin_forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});
  AdminLoginController adminloginController = Get.put(AdminLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Inloggen',
          style: getTextStyle(
            color: AppColors.primaryBlack,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: getTextStyle(
                        color: AppColors.primaryBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: AuthCustomTextField(
                    onChanged: (value) {},
                    controller: adminloginController.emailController,
                    text: 'Voer uw e-mail in',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Incorrect email or password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wachtwoord',
                      style: getTextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Obx(() {
                //   return SizedBox(
                //     height: 50,
                //     child: AuthCustomTextField(
                //       onChanged: (value) {
                //         adminloginController.validateFrom();
                //       },
                //       text: 'Voer uw wachtwoord in',
                //       controller: adminloginController.passwordControler,
                //       obscureText: adminloginController.isPasswordVisible.value,
                //       borderColor: AppColors.borderColor,
                //       validator: (value) {
                //         if (value == null || value.isEmpty) {
                //           return 'Incorrect email or password';
                //         }
                //         return null;
                //       },
                //     ),
                //   );
                // }),
                Obx(
                  () => AuthCustomTextField(
                    text: 'Voer uw wachtwoord in',
                    controller: adminloginController.passwordController,
                    obscureText:
                        adminloginController.isPasswordVisible.value
                            ? false
                            : true,
                    onChanged: (value) {
                      adminloginController.onPasswordChanged(value);
                      adminloginController.validateForm();
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        adminloginController.isPasswordFieldEmpty.value
                            ? Icons
                                .visibility_outlined // field empty → show normal visibility icon
                            : (!adminloginController.isPasswordVisible.value
                                ? Icons
                                    .visibility_off_outlined // field not empty and visible → show off icon
                                : Icons
                                    .visibility_outlined // field not empty and hidden → show normal
                                    ),
                        color: Color(0xff37B874),
                      ),
                      onPressed: adminloginController.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wachtwoord is vereist';
                      }
                      if (value.length < 8) {
                        return 'Wachtwoord moet minimaal 8 tekens lang zijn';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 32),
                CustomContinueButton(
                  onTap: () {
                    adminloginController.login();
                  },
                  textColor: Colors.white,
                  title: "Inloggen",
                  backgroundColor: AppColors.buttonPrimary,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(AdminForgetPasswordScreen());
                    },
                    child: Text(
                      'Wachtwoord vergeten?',
                      style: getTextStyle2(
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
