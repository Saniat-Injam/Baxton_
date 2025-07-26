// lib/controllers/task_settings_controller.dart

import 'package:baxton/features/Admin_flow/instellingen/task_settings/model/task_settings_model.dart';
import 'package:get/get.dart';

class TaskSettingsController extends GetxController {
  var model =
      TaskSettingsModel(
        categories: [
          'Dakinspectie',
          'Schimmelbehandeling',
          'Loodgieterswerk',
          'Elektrisch Werk',
          'Algonderhoud',
        ],
        statuses: ['In Afwachting', 'Bezig', 'Voltooid'],
      ).obs;

  void addCategory(String category) {
    model.update((val) {
      val?.categories.add(category);
    });
  }

  void addStatus(String status) {
    model.update((val) {
      val?.statuses.add(status);
    });
  }

  void toggleReminder() {
    model.update((val) {
      val?.reminderEnabled = !(val.reminderEnabled);
    });
  }

  void saveChanges() {
    // Handle save logic (e.g., API call or local persistence)
    Get.snackbar('Succes', 'Wijzigingen zijn opgeslagen.');
  }
}
