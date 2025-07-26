import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/note_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NoteController extends GetxController {
  final NoteRepository repository;
  final String taskId;
  final TextEditingController noteTextController = TextEditingController();
  NoteController({required this.repository, required this.taskId});

  Future<void> completeTaskWithNote(String note) async {
    final note = noteTextController.text.trim();

    if (note.isEmpty) {
      EasyLoading.showError('Notitie mag niet leeg zijn');
      return;
    }

    try {
      EasyLoading.show(status: 'Taak voltooien...');
      final result = await repository.completeTask(
        taskId: taskId,
        note: note.trim(),
      );
      EasyLoading.dismiss();

      if (result['success'] == true) {
        EasyLoading.showSuccess(result['message'] ?? 'Taak voltooid!');
        // 👉 hier kun je navigeren of refreshen
        // Get.back(); // bijvoorbeeld
      } else {
        EasyLoading.showError(result['message'] ?? 'Kon taak niet voltooien');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Fout: $e');
    }
  }
}
