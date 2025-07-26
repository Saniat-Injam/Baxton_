import 'dart:io';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/profile_setup/controller/profile_setup_controller.dart';
import 'package:baxton/features/werknemer_flow/profile_setup/model/worker_specialist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WorkerProfileSetupScreen extends StatelessWidget {
  final controller = Get.put(WorkerProfileSetupController());

  WorkerProfileSetupScreen({super.key});

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      controller.pickImage(picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Profielinstelling',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: _pickImage,
              child: Obx(() {
                final hasImage = controller.profilePicPath.value.isNotEmpty;
                return CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      hasImage
                          ? FileImage(File(controller.profilePicPath.value))
                          : const AssetImage(IconPath.profileicon)
                              as ImageProvider,
                  backgroundColor: Colors.white,
                  child:
                      !hasImage
                          ? const Icon(Icons.camera_alt, color: Colors.grey)
                          : null,
                );
              }),
            ),

            const SizedBox(height: 24),
            _buildLabel("Gebruikersnaam"),
            _buildTextField(
              hint: "jane@123",
              onChanged: (val) => controller.userName.value = val,
            ),

            const SizedBox(height: 16),
            _buildLabel("Expertise"),
            Obx(() {
              return DropdownButtonFormField<WorkerSpecialist>(
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  // contentPadding: const EdgeInsets.symmetric(
                  //   horizontal: 16,
                  //   vertical: 10,
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFC0C0C0)),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFC0C0C0),
                      width: 2,
                    ),
                  ),
                ),
                hint: Text(
                  "Select expertise",
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value: controller.selectedSpecialist.value,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF666666),
                ),
                dropdownColor: Colors.white,
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                menuMaxHeight: 300,
                items:
                    controller.specialistList.asMap().entries.map((entry) {
                      int index = entry.key;
                      WorkerSpecialist specialist = entry.value;

                      return DropdownMenuItem(
                        value: specialist,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 4,
                              ),
                              child: Text(
                                specialist.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGold,
                                ),
                              ),
                            ),

                            if (index < controller.specialistList.length - 1)
                              const Divider(
                                height: 1,
                                thickness: 0.5,
                                color: AppColors.buttonPrimary,
                                indent: 4,
                                endIndent: 4,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) controller.selectSpecialist(value);
                },
                selectedItemBuilder: (BuildContext context) {
                  return controller.specialistList.map<Widget>((specialist) {
                    return Text(
                      specialist.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    );
                  }).toList();
                },
              );
            }),

            const SizedBox(height: 16),
            _buildLabel("Werknemers-ID"),
            _buildTextField(
              hint: "EMP-123456",
              onChanged: (val) => controller.workerId.value = val,
            ),

            const SizedBox(height: 16),
            _buildLabel("Locatie"),
            _buildTextField(
              hint: "Amsterdam",
              onChanged: (val) => controller.location.value = val,
            ),

            const SizedBox(height: 30),
            Obx(
              () =>
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: controller.submitProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E90FF),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Doorgaan",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
            ),

            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                'Overslaan',
                style: TextStyle(color: Color(0xFF1E90FF)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF666666),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  Widget _buildTextField({
    required String hint,
    required Function(String) onChanged,
  }) => TextField(
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFC0C0C0)),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    onChanged: onChanged,
  );
}
