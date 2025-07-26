import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:get/get.dart';

class TaskDetailController extends GetxController {
  final SetPriceTaskModel task;
  TaskDetailController(this.task);

  RxString price = ''.obs;

  void submitPrice() {
    if (price.isEmpty) {
      Get.snackbar('Fout', 'Voer een prijs in');
      return;
    }
    Get.snackbar(
      'Prijs Ingediend',
      'Je hebt €$price ingesteld voor "${task.title}"',
    );
    // Add submission logic here (API call, etc.)
  }
}
