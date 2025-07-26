// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';

import 'package:baxton/features/klant_flow/home_screen/controller/home_controller.dart';
import 'package:baxton/features/klant_flow/profile_screen/controller/profile_controller.dart';
import 'package:baxton/features/klant_flow/profile_screen/widgets/custom_profile_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  HomeController homeController = Get.put(HomeController());

  Widget _buildProfileImage() {
    if (profileController.selectedImagePath.value.isNotEmpty) {
      return CircleAvatar(
        radius: 80,

        backgroundImage: FileImage(
          File(profileController.selectedImagePath.value),
        ),
      );
    } else if (profileController.logoUrl.value.isNotEmpty) {
      return CircleAvatar(
        radius: 80,
        backgroundImage: NetworkImage(profileController.logoUrl.value),
      );
    }
    return CircleAvatar(
      radius: 80,
      backgroundImage: AssetImage(IconPath.profileicon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: Obx(() {
          if (profileController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 58,
                              backgroundColor: Colors.white,
                              child: _buildProfileImage(),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(15, 95),
                            child: GestureDetector(
                              onTap: () {
                                profileController.showImagePicker(context);
                              },
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
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
                  SizedBox(height: 8),
                  Text(
                    profileController.fullNameController.text.isNotEmpty
                        ? profileController.fullNameController.text
                        : profileController.profile.value?.data.user.name ??
                            "Jakob Vaccaro",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    profileController.profile.value?.data.user.email ??
                        "jakob@123",

                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff212121),
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      profileController.toggleEdit();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          profileController.isEditing.value
                              ? "Redden"
                              : "Bewerken",

                          style: TextStyle(
                            color: Color(0xff1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          profileController.isEditing.value
                              ? Icons.save
                              : Icons.edit,

                          size: 15,
                          color: Color(0xff1E90FF),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Persoonlijke Informatie",
                        style: TextStyle(
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

                      child: Column(
                        children: [
                          CustomProfileTextField(
                            label: "Volledige Naam",
                            controller: profileController.fullNameController,
                            hintText: "Jakob Vaccaro",
                            enabled: profileController.isEditing.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Information",
                        style: TextStyle(
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

                      child: Column(
                        children: [
                          CustomProfileTextField(
                            label: "Telefoon",
                            controller: profileController.phoneController,

                            hintText:
                                // homeController.profile.value?.data.user.phone ??
                                "+1 234-567-8901",

                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "E-mail",
                            controller: profileController.emailController,

                            hintText:
                                // homeController.profile.value?.data.user.email ??
                                "johndoe@email.com",

                            enabled: false,
                          ),
                          CustomProfileTextField(
                            label: "Locatie",
                            controller: profileController.locationController,
                            hintText: "Headquarters, Cityville",
                            enabled: profileController.isEditing.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 5,
                        bottom: 5,
                      ),

                      child: Column(
                        children: [
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
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff212121),
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
          );
        }),
      ),
    );
  }
}
