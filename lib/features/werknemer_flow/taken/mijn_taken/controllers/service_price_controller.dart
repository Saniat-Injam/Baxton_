import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/task_details_model.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/service_price_repository.dart';

class ServicePriceController extends GetxController {
  final ServicePriceRepository repository;
  final String taskId;

  // text controllers for dialog
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController servicePriceController = TextEditingController();

  // ✅ use the existing model
  var serviceDetails = <ServiceDetailsItem>[].obs;

  ServicePriceController({required this.repository, required this.taskId});

  Future<void> addWorkItem() async {
    final name = serviceNameController.text.trim();
    final priceText = servicePriceController.text.trim();

    if (name.isEmpty || priceText.isEmpty) {
      EasyLoading.showError('Vul alle velden in');
      return;
    }

    final double? parsedPrice = double.tryParse(priceText);
    if (parsedPrice == null) {
      EasyLoading.showError('Ongeldige prijs');
      return;
    }

    try {
      EasyLoading.show(status: 'Toevoegen...');
      final result = await repository.addServicePriceBreakdown(
        serviceRequestId: taskId,
        serviceName: name,
        servicePrice: parsedPrice,
      );

      EasyLoading.dismiss();

      if (result['success'] == true) {
        EasyLoading.showSuccess(result['message'] ?? 'Succesvol toegevoegd');

        // ✅ re-fetch details instead of manually appending
        await Get.find<UpcomingTaskController>().fetchTaskDetails(taskId);

        // clear input fields
        serviceNameController.clear();
        servicePriceController.clear();
      } else {
        EasyLoading.showError(result['message'] ?? 'Er ging iets mis');
      }
    } catch (e) {
      EasyLoading.showError('Fout: $e');
    }
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    servicePriceController.dispose();
    super.onClose();
  }
}
