import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/payment_pending_task_model.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/payment_pending_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PaymentPendingTaskController extends GetxController {
  final PaymentPendingRepository repository = PaymentPendingRepository();

  var paymentPendingTasks = <PaymentPendingTaskModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentPendingTasks();
  }

  Future<void> fetchPaymentPendingTasks() async {
    try {
      isLoading.value = true;
      error.value = '';
      EasyLoading.show(status: 'Loading payment pending tasks...');
      final tasks = await repository.fetchPaymentPendingTasks();
      paymentPendingTasks.assignAll(tasks);
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }
}
