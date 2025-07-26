import 'dart:io';

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/profile_setup/controller/klant_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KlantProfileSetup extends StatelessWidget {
  KlantProfileSetup({super.key});
  final KlantProfileController klantProfileController = Get.put(
    KlantProfileController(),
  );

  Widget _buildProfileImage() {
    if (klantProfileController.selectedImagePath.value.isNotEmpty) {
      return CircleAvatar(
        radius: 80,
        backgroundImage: FileImage(
          File(klantProfileController.selectedImagePath.value),
        ),
      );
    } else if (klantProfileController.selectedImagePath.value.isNotEmpty) {
      return CircleAvatar(
        radius: 80,
        backgroundImage: NetworkImage(
          klantProfileController.selectedImagePath.value,
        ),
      );
    }
    return CircleAvatar(
      radius: 80,
      backgroundImage: const AssetImage(IconPath.profileicon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profielinstelling',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: Colors.white,
                            child: _buildProfileImage(),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(15, 95),
                        child: GestureDetector(
                          onTap: () {
                            klantProfileController.showImagePicker(context);
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 12,
                              color: Color(0xff37BB74),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Form Fields
              _buildTextField(
                label: 'Naam',
                controller: klantProfileController.name,
              ),
              SizedBox(height: 12),
              _buildTextField(
                label: 'Locatie',
                controller: klantProfileController.location,
              ),
              SizedBox(height: 50),

              // Action Buttons
              _buildActionButton(
                label: 'Doorgaan',
                onPressed: klantProfileController.onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build individual TextField widget for the profile fields
  Widget _buildTextField({
    required String label,
    required RxString controller,
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF666666),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextField(
          controller: TextEditingController(text: controller.value),
          onChanged: (value) {
            controller.value = value;
          },
          readOnly: isReadOnly,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }

  // Build the action button for "Doorgaan" or "Overslaan"
  Widget _buildActionButton({
    required String label,
    required Function onPressed,
    bool isOutline = false,
  }) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: ShapeDecoration(
          color: isOutline ? Colors.transparent : Color(0xFF1E90FF),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF1E90FF)),
            borderRadius: BorderRadius.circular(51),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isOutline ? Color(0xFF1E90FF) : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
