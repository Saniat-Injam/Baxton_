import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/splash_screen/controller/splash_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());

    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(color: AppColors.primaryGold),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconPath.logo, width: double.infinity),
            Text(
              "Welkom bij Baxton",
              style: getTextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xffF3E2B0),
              ),
            ),
            Text(
              "Onderhoud",
              style: getTextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xffF3E2B0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
