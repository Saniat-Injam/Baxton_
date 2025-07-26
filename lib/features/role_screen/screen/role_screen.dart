import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/authentication/screens/admin_login_screen.dart';
import 'package:baxton/features/role_screen/controller/role_controller.dart';
import 'package:baxton/features/role_screen/widgets/role_custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleController roleController = Get.put(RoleController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Selecteer uw rol",
                style: getTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Kies een rol om te begin",
                textAlign: TextAlign.left,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  RoleCustomContainer(
                    imagePath: IconPath.weknermer,
                    title: "Werknemer",
                    index: 0,
                  ),
                  SizedBox(height: 8),
                  RoleCustomContainer(
                    imagePath: IconPath.klant,
                    title: "Klant",
                    index: 1,
                  ),
                ],
              ),
              SizedBox(height: 100),

              // Continue / Proceed Button --> Doorgan
              GestureDetector(
                onTap: () {
                  debugPrint(
                    "Selected Role Index: ${roleController.selectedIndex.value}",
                  );
                  roleController.navigateToRolePage();
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(51),
                  ),
                  child: Center(
                    child: Text(
                      "Doorgaan",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),

              // Admin Button
              GestureDetector(
                onTap: () {
                  Get.to(AdminLoginScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inloggen als Admin",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 6),

                        Image.asset(IconPath.arrowRight4),
                      ],
                    ),

                    //Icon(Icons.arrow_right_alt_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
