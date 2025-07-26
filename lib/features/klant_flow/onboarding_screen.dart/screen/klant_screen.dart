import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/common_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:baxton/features/klant_flow/authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KonboardingScreen extends StatelessWidget {
  const KonboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 40),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(ImagePath.klantonboarding),
                ),
              ),
              Text(
                "Welkom bij Baxton",
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Klantenservice",
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Vraag eenvoudig diensten aan, volg de voortgang",
                style: getTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textThird,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "en beheer onderhoudstaken allemaal op één plek.",
                style: getTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textThird,
                ),
              ),
              SizedBox(height: 48),
              CommonButton(
                buttonText: "Aan de slag",
                onTap: () {
                  Get.to(LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
