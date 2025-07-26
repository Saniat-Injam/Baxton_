// import 'package:get/get.dart';

// class ProfileController extends GetxController {
//   var name = ''.obs;
//   var phoneNumber = ''.obs;
//   var email = ''.obs;
//   var location = ''.obs;

//   void updateName(String value) {
//     name.value = value;
//   }

//   void updatePhoneNumber(String value) {
//     phoneNumber.value = value;
//   }

//   void updateEmail(String value) {
//     email.value = value;
//   }

//   void updateLocation(String value) {
//     location.value = value;
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/role_screen/screen/role_screen.dart';
import 'package:baxton/features/werknemer_flow/profile/models/worker_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ProfileSettingController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController workerIdController = TextEditingController();

  // Extra for UI bindings
  final TextEditingController currentplanController = TextEditingController();
  final TextEditingController confidenceController =
      TextEditingController(); // reused for location
  final TextEditingController interviewController =
      TextEditingController(); // reused for phone
  final RxString specialistId = ''.obs;

  var isEditing = false.obs;
  var isSaving = false.obs;
  final logoUrl = ''.obs;
  var selectedImagePath = ''.obs;
  var isEnable = false.obs;
  var fullName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void saveProfile() {
    // Logic for saving the profile (e.g., updating a database or API call)
    isSaving.value = false; // Reset the save button
    isEditing.value = false; // Turn off editing mode
  }

  void toggleEdit() {
    isEnable.value = !isEnable.value;
    isSaving.value = false;
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
      } else {
        Get.snackbar("No Image Selected", "Please select an image.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick an image: $e");
    }
  }

  File getSelectedImage() {
    return File(selectedImagePath.value);
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Choose from Camera'),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_outlined),
              title: Text('Choose from Gallery'),
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

  Future<void> fetchUserProfile() async {
    try {
      final token = await AuthService.getToken();
      final response = await http.get(
        Uri.parse('https://freepik.softvenceomega.com/ts/auth/me'),
        headers: {'Authorization': 'Bearer $token'},
      );

      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final data = WorkerProfileData.fromJson(json['data']);

        debugPrint('Parsed Name: ${data.name}');
        debugPrint('Parsed Email: ${data.email}');
        debugPrint('Parsed Phone: ${data.phone}');
        debugPrint('Parsed Worker ID: ${data.workerId}');
        debugPrint('Parsed Specialist ID: ${data.specialistId}');
        debugPrint('Parsed Location: ${data.location}');
        debugPrint('Parsed Image URL: ${data.profileImageUrl}');

        fullNameController.text = data.name;
        emailController.text = data.email;
        phoneController.text = data.phone;
        workerIdController.text = data.workerId;
        locationController.text = data.location;
        logoUrl.value = data.profileImageUrl ?? '';
        fullName.value = data.name;
        specialistId.value = data.specialistId;
      } else {
        debugPrint('Failed to fetch profile data');
      }
    } catch (e) {
      debugPrint('Error fetching profile data: $e');
    }
  }

  Future<void> updateWorkerProfile() async {
    try {
      isSaving.value = true;
      EasyLoading.show(status: 'Profiel bijwerken...');

      final token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError('Token ontbreekt. Log opnieuw in.');
        return;
      }

      final uri = Uri.parse(
        'https://freepik.softvenceomega.com/ts/profile/update-worker-profile/{id}',
      );
      final request = http.MultipartRequest('PUT', uri);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      });

      // Required fields: userName, location, workerId, workerSpecialtyId
      request.fields['userName'] = fullNameController.text.trim();
      request.fields['location'] = locationController.text.trim();
      request.fields['workerId'] = workerIdController.text.trim();
      request.fields['workerSpecialtyId'] = specialistId.value;

      if (selectedImagePath.value.isNotEmpty) {
        final mimeType = lookupMimeType(selectedImagePath.value) ?? 'image/png';
        final mimeParts = mimeType.split('/');
        final contentType = MediaType(mimeParts[0], mimeParts[1]);

        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePic',
            selectedImagePath.value,
            contentType: contentType,
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final updated = json['data']['data'];

        fullName.value = updated['userName'];
        logoUrl.value = updated['profilePic']['url'] ?? logoUrl.value;
        locationController.text =
            updated['location'] ?? locationController.text;
        selectedImagePath.value = '';

        EasyLoading.showSuccess('Profiel succesvol bijgewerkt');
        isEditing.value = false;
        isEnable.value = false;
      } else {
        EasyLoading.showError('Bijwerken mislukt');
        debugPrint('Error response: ${response.body}');
      }
    } catch (e) {
      EasyLoading.showError('Fout: $e');
      debugPrint('UpdateWorkerProfile error: $e');
    } finally {
      EasyLoading.dismiss();
      isSaving.value = false;
    }
  }

  void logout() async {
    EasyLoading.show(status: 'Logging out...');
    try {
      await AuthService.clearAuthData();
      await Future.delayed(Duration(milliseconds: 500));
      Get.offAll(() => RoleScreen());
    } catch (e) {
      EasyLoading.showError('Logout failed');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
