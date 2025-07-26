// import 'dart:io';
// import 'package:baxton/features/klant_flow/authentication/screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart'; // Make sure to import your AuthService

// class ProfileController extends GetxController {
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nothingController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();

//   var isEditing = false.obs;
//   var isSaving = false.obs;
//   final logoUrl = ''.obs;
//   var selectedImagePath = ''.obs;
//   var isEnable = false.obs;

//   final ImagePicker _imagePicker = ImagePicker();

//   // Method to log the user out
//   Future<void> logout() async {
//     EasyLoading.show(status: 'Logging out...');
//     try {
//       await AuthService.clearAuthData();

//       Get.offAll(() => LoginScreen());
//     } catch (e) {
//       EasyLoading.showError("An error occurred while logging out");
//       debugPrint("Logout Error: $e");
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }

//   void saveProfile() {
//     // Logic for saving the profile (e.g., updating a database or API call)
//     isSaving.value = false; // Reset the save button
//     isEditing.value = false; // Turn off editing mode
//   }

//   void toggleEdit() {
//     isEnable.value = !isEnable.value;
//     isSaving.value = false;
//   }

//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(source: source);
//       if (pickedFile != null) {
//         selectedImagePath.value = pickedFile.path;
//       } else {
//         Get.snackbar("No Image Selected", "Please select an image.");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to pick an image: $e");
//     }
//   }

//   File getSelectedImage() {
//     return File(selectedImagePath.value);
//   }

//   void showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Wrap(
//           children: [
//             ListTile(
//               leading: Icon(Icons.camera_alt_outlined),
//               title: Text('Choose from Camera'),
//               onTap: () {
//                 pickImage(ImageSource.camera);
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo_outlined),
//               title: Text('Choose from Gallery'),
//               onTap: () {
//                 pickImage(ImageSource.gallery);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/authentication/screens/login_screen.dart';
import 'package:baxton/features/klant_flow/home_screen/models/fetch_profile_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class ProfileController extends GetxController {
  RxBool isEditing = false.obs; // To track if we are in edit mode
  RxBool isSaving = false.obs; // To track save status
  RxString selectedImagePath = ''.obs; // To store the profile image path
  RxString logoUrl = ''.obs; // To store the profile image URL
  var isLoading = false.obs;
  var hasImageChanged = false.obs;
  final Rx<Profile?> profile = Rx<Profile?>(null);
  final RxString errorMessage = ''.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nothingController = TextEditingController();

  String originalfullName = '';
  String originallocation = '';

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    debugPrint('Starting fetchUserProfile in ProfileController');

    isLoading.value = true;
    errorMessage.value = '';

    await EasyLoading.show(status: 'Loading profile...');

    final token = await AuthService.getToken();

    if (token == null || token.isEmpty) {
      isLoading.value = false;
      errorMessage.value = 'User is not authenticated. Please log in.';
      await EasyLoading.showError('User is not authenticated. Please log in.');
      Get.offAllNamed('/login');
      return;
    }

    final url = Uri.parse(Urls.userdetails);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          profile.value = profileFromJson(response.body);
          profile.refresh();

          // Set text controllers directly here - Simple!
          final user = profile.value?.data.user;
          if (user != null) {
            fullNameController.text = user.name;
            locationController.text = user.clientProfile.location;
            emailController.text = user.email;
            phoneController.text = user.phone;

            if (user.clientProfile.profilePic.url.isNotEmpty) {
              logoUrl.value = user.clientProfile.profilePic.url;
            }

            // Store original values
            originalfullName = user.name;
            originallocation = user.clientProfile.location;
          }

          await EasyLoading.showSuccess('Profile loaded successfully!');
        } catch (e) {
          errorMessage.value = 'Invalid server response. Please try again.';
          await EasyLoading.showError('Invalid server response.');
        }
      } else {
        errorMessage.value = 'Failed to load profile. Please try again.';
        await EasyLoading.showError(
          'Failed to load profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      errorMessage.value = 'Error fetching profile: $e';
      await EasyLoading.showError('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      await EasyLoading.dismiss();
    }
  }

  // Future<void> initializeData() async {
  //   try {
  //     isLoading(true);

  //     final user = HomeController().profile.value?.data.user;
  //     if (user != null) {
  //       fullNameController.text = user.name;
  //       locationController.text = user.clientProfile.location;

  //       if (user.clientProfile.profilePic.url.isNotEmpty) {
  //         logoUrl.value = user.clientProfile.profilePic.url;
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load profile data');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Future<void> initializeData() async {
  //   try {
  //     debugPrint("Starting to initialize data...");
  //     isLoading(true);

  //     final user = HomeController().profile.value?.data.user;
  //     debugPrint("User fetched: $user");//     if (user != null) {
  //       debugPrint("User is not null, setting values...");
  //       fullNameController.text = user.name;
  //       debugPrint("Full Name set to: ${user.name}");

  //       locationController.text = user.clientProfile.location;
  //       debugPrint("Location set to: ${user.clientProfile.location}");
  //       emailController.text = user.email;
  //       phoneController.text = user.phone ?? "";
  //       if (user.clientProfile.profilePic.url.isNotEmpty) {
  //         logoUrl.value = user.clientProfile.profilePic.url;
  //         debugPrint("Logo URL set to: ${user.clientProfile.profilePic.url}");
  //       }
  //       // Store original values
  //       originalfullName = user.name;
  //       originallocation = user.clientProfile.location;
  //     } else {
  //       debugPrint("User is null");
  //     }
  //   } catch (e) {
  //     debugPrint("Error occurred: $e");
  //     Get.snackbar('Error', 'Failed to load profile data');
  //   } finally {
  //     debugPrint("Finished initializing data.");
  //     isLoading(false);
  //   }
  // }

  final ImagePicker _picker = ImagePicker();

  void toggleEdit() {
    if (isEditing.value) {
      // When the user is editing, save the changes
      saveChanges();
    } else {
      // Save the original data before editing
      originalfullName = fullNameController.text;
      originallocation = locationController.text;
      isEditing.value = true;
    }
  }

  Future<void> saveChanges() async {
    debugPrint("saveChanges called");
    await updateProfile(
      name: fullNameController.text,
      location: locationController.text,
    );
  }

  Future<void> updateProfile({
    required String name,
    required String location,
  }) async {
    try {
      EasyLoading.show(status: "Updating profile...");
      debugPrint("EasyLoading status shown: Updating profile...");

      String? accessToken = await AuthService.getToken();
      debugPrint("Access token retrieved: $accessToken");

      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError("Access token is missing. Please login again.");
        debugPrint("Access token is null or empty.");
        return;
      }

      final url = Uri.parse(
        'https://freepik.softvenceomega.com/ts/profile/update-client-profile/{id}',
      );
      debugPrint("Request URL: $url");

      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = 'Bearer $accessToken';
      debugPrint("Request headers: ${request.headers}");

      final requestData = {'userName': name, 'location': location};
      debugPrint("Request data: $requestData");

      request.fields['data'] = jsonEncode(requestData);
      debugPrint("Request data encoded as JSON: ${jsonEncode(requestData)}");

      if (selectedImagePath.value.isNotEmpty) {
        final file = File(selectedImagePath.value);
        debugPrint("Selected image path: ${selectedImagePath.value}");
        if (await file.exists()) {
          final fileName = path.basename(file.path);
          final mimeType = lookupMimeType(file.path);

          debugPrint("File attached to request: $fileName");

          // If MIME type is not found, default to "application/octet-stream"
          final contentType =
              mimeType != null
                  ? MediaType.parse(mimeType)
                  : MediaType('application', 'octet-stream');

          final multipartFile = await http.MultipartFile.fromPath(
            'profilePic',
            file.path,
            filename: fileName,
            contentType: contentType,
          );

          debugPrint(
            "File attached to request with content type: $contentType",
          );
          request.files.add(multipartFile);
        } else {
          debugPrint("File does not exist at path: ${selectedImagePath.value}");
        }
      } else {
        debugPrint("No image selected for upload.");
      }
      debugPrint("Sending request...");
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint("Response received: ${response.body}");
      debugPrint("Response status code: ${response.statusCode}");

      final responseData = jsonDecode(response.body);
      debugPrint("Parsed response data: $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true) {
          debugPrint("Profile update success: ${responseData['message']}");
          await _handleSuccessResponse(responseData, name, location);
          EasyLoading.showSuccess("Profile updated successfully!");
          isEditing.value = false;
          // await HomeController.fetchUserProfile();
        } else {
          debugPrint(
            "Profile update failed with message: ${responseData['message']}",
          );
          throw Exception(responseData['message'] ?? "Profile update failed");
        }
      } else {
        debugPrint("Failed with status code: ${response.statusCode}");
        throw Exception(_parseError(responseData, response.statusCode));
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      EasyLoading.showError(
        'Update failed: ${e.toString().replaceAll('Exception: ', '')}',
      );
      fullNameController.text = originalfullName;
      locationController.text = originallocation;
    }
  }

  Future<void> _handleSuccessResponse(
    Map<String, dynamic> data,
    String name,
    String location,
  ) async {
    if (data['data'] != null && data['data']['img'] != null) {
      logoUrl.value = data['data']['img'];
      selectedImagePath.value = '';
      hasImageChanged.value = false;
    }

    fullNameController.text = data['data']['name'] ?? name;
    locationController.text = data['data']['location'] ?? location;
  }

  String _parseError(Map<String, dynamic> data, int statusCode) {
    if (data['message'] != null) {
      return data['message'];
    }

    switch (statusCode) {
      case 400:
        return 'Invalid request data';
      case 401:
        return 'Authentication failed';
      case 403:
        return 'Permission denied';
      case 404:
        return 'Profile not found';
      case 500:
        return 'Server error';
      default:
        return 'Update failed (status $statusCode)';
    }
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        hasImageChanged.value = true;

        isEditing.value = true;
      }
    } catch (e) {
      EasyLoading.showError("Failed to pick an image: $e");
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Choose from Camera'),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void logout() async {
    await AuthService.clearAuthData();
    Get.offAll(LoginScreen());
  }
}
