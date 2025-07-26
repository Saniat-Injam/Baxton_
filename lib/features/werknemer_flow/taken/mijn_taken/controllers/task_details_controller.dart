import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TaskDetailsController extends GetxController {
  // Observable variables for state management
  var progress = 20.0.obs;
  var signatureImage = Rx<File?>(null);
  var checklistImages = List<File?>.filled(2, null, growable: true).obs;
  var noteText = "".obs;

  final ImagePicker _picker = ImagePicker();

  // Function to pick image for checklist items
  Future<void> pickImageForChecklist(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      checklistImages[index] = File(pickedFile.path);
    }
  }

  // Function to take client signature image
  Future<void> takeClientSignature() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      signatureImage.value = File(pickedFile.path);
    }
  }

  // Function to update note
  void updateNoteText(String text) {
    noteText.value = text;
  }

  // Task completion handler
  void completeTask() {
    progress.value = 100.0;
    // Handle task completion logic
  }

  // Pause task handler
  void pauseTask() {
    // Handle task pause logic
  }
}
