import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/photo_repository.dart';
import 'package:image_picker/image_picker.dart';

class PhotoController extends GetxController {
  final PhotoRepository repository;
  final String taskId;
  final ImagePicker _picker = ImagePicker();
  PhotoController({required this.repository, required this.taskId});

  /// 📸 Pick and upload BEFORE photo
  Future<void> pickBeforePhoto() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      _showImageDialog(picked.path, isBefore: true);
    }
  }

  /// 📸 Pick and upload AFTER photo
  Future<void> pickAfterPhoto() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      _showImageDialog(picked.path, isBefore: false);
    }
  }

  /// 🖼️ Dialog to enter description and confirm upload
  void _showImageDialog(String imagePath, {required bool isBefore}) {
    final TextEditingController descriptionController = TextEditingController();

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Foto Informatie',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(imagePath),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLength: 30,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Beschrijving',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final caption = descriptionController.text.trim();

                    // ✅ Call upload with caption
                    if (isBefore) {
                      await uploadBeforePhoto(File(imagePath), caption);
                    } else {
                      await uploadAfterPhoto(File(imagePath), caption);
                    }
                    Get.back(); // close dialog after upload
                  },
                  child: const Text('Toevoegen'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Annuleren'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadBeforePhoto(File file, String caption) async {
    await _uploadPhoto(file: file, caption: caption, isPrev: true);
  }

  Future<void> uploadAfterPhoto(File file, String caption) async {
    await _uploadPhoto(file: file, caption: caption);
  }

  Future<void> _uploadPhoto({
    required File file,
    required String caption,
    bool? isPrev,
  }) async {
    try {
      EasyLoading.show(status: 'Foto uploaden...');
      final result = await repository.uploadPhoto(
        taskId: taskId,
        file: file,
        isPrev: isPrev,
        caption: caption,
      );
      EasyLoading.dismiss();

      if (result['success'] == true) {
        EasyLoading.showSuccess(result['message'] ?? 'Succesvol geüpload');
        await Get.find<UpcomingTaskController>().fetchTaskDetails(taskId);
      } else {
        EasyLoading.showError(result['message'] ?? 'Upload mislukt');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Fout: $e');
    }
  }
}
