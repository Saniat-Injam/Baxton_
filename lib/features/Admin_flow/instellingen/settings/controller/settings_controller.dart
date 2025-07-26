import 'package:baxton/features/Admin_flow/instellingen/settings/model/settings_model.dart';
import 'package:baxton/features/Admin_flow/instellingen/task_settings/view/task_settings_screen.dart';
import 'package:baxton/features/Admin_flow/instellingen/user_management/view/user_management_screen.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var settings =
      <SettingModel>[
        SettingModel(
          title: "Gebruikersbeheer",
          onTap: () => Get.to(() => UserManagementScreen()),
        ),
        SettingModel(
          title: "Taakinstellingen",
          onTap: () => Get.to(() => TaskSettingsScreen()),
        ),

        SettingModel(title: "Betalingsinstellingen"),
        SettingModel(title: "Meldingsinstellingen"),
        SettingModel(title: "Accountinstellingen"),
        SettingModel(title: "Algemene App-instellingen"),
      ].obs;
}
