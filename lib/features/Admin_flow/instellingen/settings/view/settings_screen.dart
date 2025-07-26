import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/instellingen/settings/controller/settings_controller.dart';
import 'package:baxton/features/Admin_flow/instellingen/settings/widgets/logo_uploader.dart';
import 'package:baxton/features/Admin_flow/instellingen/settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SettingsController controller = Get.put(SettingsController());

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Instellnigen",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => ListView(
                children:
                    controller.settings
                        .map(
                          (setting) => SettingsTile(
                            title: setting.title,
                            onTap: setting.onTap,
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Branding en Aanpassing",
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlack,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          const LogoUploader(),
        ],
      ),
    );
  }
}
