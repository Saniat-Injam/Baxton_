import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/checklist_repository.dart';

class ChecklistController extends GetxController {
  final ChecklistRepository checklistRepository;
  final String taskId;

  ChecklistController({
    required this.checklistRepository,
    required this.taskId,
  });

  Future<void> addChecklistItem(String name) async {
    if (name.trim().isEmpty) {
      EasyLoading.showError('Voer een naam in');
      return;
    }
    try {
      EasyLoading.show(status: 'Toevoegen...');
      final result = await checklistRepository.addChecklistItem(
        serviceRequestId: taskId,
        name: name,
      );
      EasyLoading.dismiss();

      if (result['success'] == true) {
        EasyLoading.showSuccess(result['message'] ?? 'Succesvol toegevoegd');
        // 🔥 refresh the main details
        await Get.find<UpcomingTaskController>().fetchTaskDetails(taskId);
      } else {
        EasyLoading.showError(result['message'] ?? 'Toevoegen mislukt');
      }
    } catch (e) {
      EasyLoading.showError('Fout: $e');
    }
  }

  Future<void> toggleChecklistDone(String checklistId, bool done) async {
    debugPrint(
      'toggleChecklistDone called with checklistId: $checklistId, done: $done',
    );
    try {
      EasyLoading.show(status: 'Bijwerken...');
      final result = await checklistRepository.updateChecklistDone(
        serviceRequestId: taskId,
        taskId: checklistId,
        done: done,
      );
      EasyLoading.dismiss();

      debugPrint('API response: $result');

      if (result['success'] == true) {
        debugPrint(
          'Checklist item updated successfully, refreshing task details...',
        );
        // 🔥 refresh the main details
        await Get.find<UpcomingTaskController>().fetchTaskDetails(taskId);
      } else {
        EasyLoading.showError(result['message'] ?? 'Bijwerken mislukt');
        debugPrint('Error updating checklist item: ${result['message']}');
      }
    } catch (e) {
      EasyLoading.showError('Fout: $e');
      debugPrint('Exception caught in toggleChecklistDone: $e');
    }
  }
}
