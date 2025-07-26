import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/profile_screen/widgets/custom_profile_textfield.dart';
import 'package:baxton/features/werknemer_flow/profile/controller/profile_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileSettingController profileController = Get.put(
    ProfileSettingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Profile Image Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Obx(() {
                          final selectedImagePath =
                              profileController.selectedImagePath.value;
                          final imageUrl = profileController.logoUrl.value;

                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  selectedImagePath.isNotEmpty
                                      ? FileImage(File(selectedImagePath))
                                      : (imageUrl.isNotEmpty
                                          ? NetworkImage(imageUrl)
                                          : AssetImage(IconPath.profilepic)
                                              as ImageProvider),
                            ),
                          );
                        }),
                        Obx(
                          () =>
                              profileController.isEnable.value
                                  ? Transform.translate(
                                    offset: Offset(5, 75),
                                    child: GestureDetector(
                                      onTap: () {
                                        profileController.showImagePicker(
                                          context,
                                        );
                                      },
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: Color(0xff1E90FF),
                                        ),
                                      ),
                                    ),
                                  )
                                  : SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 8),

                Obx(
                  () => Text(
                    profileController.fullName.value.isNotEmpty
                        ? profileController.fullName.value
                        : "No name provided",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  profileController.emailController.text.isNotEmpty
                      ? profileController.emailController.text
                      : "No email provided",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff212121),
                  ),
                ),

                SizedBox(height: 25),

                // Edit/Save Button
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (profileController.isEnable.value) {
                        // Save when in editing mode
                        profileController.updateWorkerProfile();
                      } else {
                        // Toggle editing
                        profileController.toggleEdit();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          profileController.isEnable.value
                              ? "Opslaan"
                              : "Bewerken",
                          style: getTextStyle(
                            color: Color(0xff1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          profileController.isEnable.value
                              ? Icons.save
                              : Icons.edit,
                          size: 15,
                          color: Color(0xff1E90FF),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Personal Information Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Persoonlijke Informatie",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          CustomProfileTextField(
                            label: "Volledige Naam",
                            controller: profileController.fullNameController,
                            hintText: '',
                            enabled: profileController.isEnable.value,
                          ),
                          CustomProfileTextField(
                            label: "Email",
                            controller: profileController.emailController,
                            hintText: "jakob@gmail.com",
                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "Functie",
                            controller: profileController.currentplanController,
                            hintText: "Onderhoudsmedewerker",
                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "Werknemers-ID",
                            controller: profileController.workerIdController,
                            hintText: "12324354",
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Information",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          CustomProfileTextField(
                            label: "Telefoon",
                            controller: profileController.phoneController,
                            hintText: "+1 234-567-8901",
                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "E-mail",
                            controller: profileController.emailController,
                            hintText: "johndoe@email.com",
                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "Locatie",
                            controller: profileController.locationController,
                            hintText: "Headquarters, Cityville",
                            enabled: profileController.isEnable.value, // Fixed
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Settings Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      children: [
                        CustomProfileTextField(
                          label: "Wachtwoord",
                          controller: profileController.currentplanController,
                          hintText: "",
                          enabled: false,
                        ),
                        CustomProfileTextField(
                          label: "Melding",
                          controller: profileController.currentplanController,
                          hintText: "",
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
                              profileController.logout();
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconPath.logout,
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Uitloggen",
                                  style: getTextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSixth,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
