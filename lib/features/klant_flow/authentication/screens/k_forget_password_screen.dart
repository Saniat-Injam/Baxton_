import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/auth_custom_textfield.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/authentication/controller/k_forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KForgetPasswordScreen extends StatelessWidget {
  KForgetPasswordScreen({super.key});
  final controller = Get.put(KForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 65),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Wachtwoord vergeten",
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlack,
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  "Voer uw e-mailadres of telefoonnummer in voor de code.",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryBlack,
                    lineHeight: 12,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (controller.toggleValue.value != 0) {
                        controller.toggle();
                      }
                    },
                    child: Container(
                      width: 84,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryGold,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: Text(
                            "Email",
                            style: getTextStyle(
                              color:
                                  controller.toggleValue.value == 0
                                      ? Colors.white
                                      : Color(0xFF3A4C67),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "E-mail",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Obx(
                  () => AuthCustomTextField(
                    controller: controller.emailController,
                    text:
                        controller.toggleValue.value == 0
                            ? "Voer uw e-mail in"
                            : "Enter your phone number",
                  ),
                ),
                const SizedBox(height: 40),
                CustomContinueButton(
                  onTap: controller.forgetPassword,
                  title: 'Verzenden',
                  textColor: Colors.white,
                  backgroundColor: const Color(0xff1E90FF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}