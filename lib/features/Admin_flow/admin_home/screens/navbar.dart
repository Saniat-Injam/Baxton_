import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';

import 'package:baxton/features/Admin_flow/betalingsbeheer/screen/betalingsbeheer_screen.dart';

import 'package:baxton/features/Admin_flow/admin_home/screens/admin_home_screens.dart';
import 'package:baxton/features/Admin_flow/instellingen/settings/view/settings_screen.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/views/medewerkerbeheer_screen.dart';
import 'package:baxton/features/Admin_flow/meldingen/view/notification_screen.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/task_manager_screen.dart';
import 'package:baxton/features/Admin_flow/rapporten/screen/rapporten_screen.dart';
import 'package:baxton/features/klant_flow/message_screen/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;
}

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavbarController controller = Get.put(NavbarController());

    return Drawer(
      backgroundColor: Color(0xffFBF6E6),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(""),
            accountEmail: Text(""),
            currentAccountPicture: Center(child: Image.asset(IconPath.logo1)),
            decoration: BoxDecoration(color: Color(0xffFBF6E6)),
          ),
          buildListTile(
            controller: controller,
            index: 0,
            title: "Dashboard",
            iconPath: [
              IconPath.activatedashboard,
              IconPath.deactivatedashboard,
            ],
            onTapCallback: () {
              Get.to(AdminHomeScreen());
            },
          ),
          buildListTile(
            controller: controller,
            index: 1,
            title: "Taakbeheer",
            iconPath: [
              IconPath.activatetaakbeheer,
              IconPath.deactivatetaakbeheer,
            ],
            onTapCallback: () {
              Get.to(TaskManagerScreen());
            },
          ),

          // Navigating to -> Employee Management Screen
          buildListTile(
            controller: controller,
            index: 2,
            title: "Medewerkerbeheer",
            iconPath: [
              IconPath.activatemedewerkerbeheer,
              IconPath.deactivatemedewerkerbeheer,
            ],
            onTapCallback: () {
              //Get.to(() => EmployeeManagementScreen());
              Get.to(() => MedewerkerbeheerScreen());
            },
          ),
          buildListTile(
            controller: controller,
            index: 3,
            title: "Betalingsbeheer",
            iconPath: [
              IconPath.activatebetalingsbeheer,
              IconPath.deactivatebetalingsbeheer,
            ],
            onTapCallback: () {
              Get.to(BetalingsbeheerScreen());
            },
          ),
          buildListTile(
            controller: controller,
            index: 4,
            title: "Rapporten & Analytics",
            iconPath: [
              IconPath.activaterapporten,
              IconPath.deactivaterapporten,
            ],
            onTapCallback: () {
              Get.to(RapportenScreen());
            },
          ),
          buildListTile(
            controller: controller,
            index: 5,
            title: "Bericht",
            iconPath: [IconPath.activatebericht, IconPath.deactivatebericht],
            onTapCallback: () {
              Get.to(MessageScreen());
            },
          ),
          buildListTile(
            controller: controller,
            index: 6,
            title: "Meldingen",
            iconPath: [
              IconPath.activatemeldingen,
              IconPath.deactivatemeldingen,
            ],
            onTapCallback: () {
              Get.to(NotificationScreen());
            },
          ),
          buildListTile(
            controller: controller,
            index: 7,
            title: "Instellingen",
            iconPath: [
              IconPath.activateinstellingen,
              IconPath.deactivateinstellingen,
            ],
            onTapCallback: () {
              Get.to(SettingsScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile({
    required NavbarController controller,
    required int index,
    required String title,
    required List<String> iconPath,
    required VoidCallback onTapCallback, // Add a custom onTapCallback parameter
  }) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return ListTile(
        leading: Image.asset(isSelected ? iconPath[0] : iconPath[1]),
        title: Text(
          title,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppColors.primaryGold : AppColors.textPrimary,
          ),
        ),
        onTap: () {
          // First, update the selected index
          controller.selectedIndex.value = index;

          // Then, call the custom onTap callback
          onTapCallback(); // Execute the passed in onTap callback
        },
      );
    });
  }
}
