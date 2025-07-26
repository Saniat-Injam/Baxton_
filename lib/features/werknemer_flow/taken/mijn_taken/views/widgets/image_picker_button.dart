// task/widgets/image_picker_button.dart

import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/task_details_controller.dart';
import 'package:flutter/material.dart';

class ImagePickerButton extends StatelessWidget {
  final TaskDetailsController controller;
  final int index;

  ImagePickerButton({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickImageForChecklist(index),
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue),
        ),
        child:
            controller.checklistImages[index] != null
                ? Image.file(
                  controller.checklistImages[index]!,
                  fit: BoxFit.cover,
                )
                : Icon(Icons.camera_alt, color: Colors.blue),
      ),
    );
  }
}
