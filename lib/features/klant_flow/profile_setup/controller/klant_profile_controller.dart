
import 'dart:convert';
import 'dart:io';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class KlantProfileController extends GetxController {
  var name = ''.obs;
  var phoneNumber = ''.obs;
  // var email = 'example123@gmail.com'.obs;
  var location = ''.obs;
  var selectedImagePath = ''.obs;
  var hasImageChanged = false.obs;
  var isEditing = false.obs;

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

  Future<void> onSubmit() async {
    // Validate required fields
    if (name.value.isEmpty) {
      EasyLoading.showError('Name is required');
      return;
    }
    if (location.value.isEmpty) {
      EasyLoading.showError('Location is required');
      return;
    }
    if (selectedImagePath.value.isEmpty) {
      EasyLoading.showError('Profile image is required');
      return;
    }

    try {
      EasyLoading.show(status: 'Creating profile...');

      // Retrieve token from AuthService
      final token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError('Authentication token is missing');
        return;
      }

      // Ensure unique username by appending a timestamp
      String uniqueUsername =
          "${name.value}_${DateTime.now().millisecondsSinceEpoch}";

      // Prepare multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.profilesetup),
      );

      // Add token to headers
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Add form fields
      request.fields['userName'] = uniqueUsername;
      // request.fields['email'] = email.value;
      request.fields['location'] = location.value;

      // Add filename and file if an image is selected
      if (selectedImagePath.value.isNotEmpty) {
        final file = File(selectedImagePath.value);
        final filename = path.basename(file.path).toLowerCase();

        // Validate file extension
        if (!filename.endsWith('.jpg') &&
            !filename.endsWith('.jpeg') &&
            !filename.endsWith('.png')) {
          EasyLoading.showError('Only JPG or PNG images are supported');
          return;
        }

        // Determine MIME type based on extension
        String mimeType = 'image/jpeg';
        if (filename.endsWith('.png')) {
          mimeType = 'image/png';
        }

        debugPrint('Uploading file: $filename with MIME type: $mimeType');

        request.fields['profilePic'] = filename;
        request.files.add(
          http.MultipartFile(
            'profilePic',
            file.readAsBytes().asStream(),
            await file.length(),
            filename: filename,
            contentType: MediaType('image', mimeType.split('/')[1]),
          ),
        );
      }

      // Send the request
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${responseBody.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(responseBody.body);
        if (responseData['success'] == true) {
          EasyLoading.showSuccess(
            responseData['message'] ?? 'Profile created successfully!',
          );
          Get.offAllNamed('/bottomnavbar'); // Adjust to your home route
        } else {
          String errorMessage =
              responseData['message'] ?? 'Failed to create profile';

          // Handle specific error for duplicate userName
          if (responseData['message'].contains("Unique constraint failed")) {
            errorMessage = "Username already taken. Please choose another.";
          }

          EasyLoading.showError(errorMessage);
        }
      } else {
        final errorData = jsonDecode(responseBody.body);
        final errorMessage = errorData['message'] ?? 'Failed to create profile';
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      debugPrint('Exception occurred: $e');
      EasyLoading.showError('Error creating profile: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void onSkip() {
    debugPrint("Skipped");
    Get.offAllNamed('/bottomnavbar'); // Adjust to your home route
  }
}
