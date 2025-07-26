import 'dart:convert';
import 'dart:io';

import 'package:baxton/core/utils/constants/api_constants.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/werknemer_flow/bottom_navigation_bar/screens/bottom_navbar.dart';
import 'package:baxton/features/werknemer_flow/profile_setup/model/worker_specialist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class WorkerProfileSetupController extends GetxController {
  final userName = ''.obs;
  final location = ''.obs;
  final workerId = ''.obs;
  // final workerSpecialtyId = ''.obs;
  final profilePicPath = ''.obs;
  final isLoading = false.obs;
  var specialistList = <WorkerSpecialist>[].obs;
  var selectedSpecialist = Rxn<WorkerSpecialist>();
  @override
  void onInit() {
    fetchSpecialists();
    super.onInit();
  }

  Future<void> fetchSpecialists() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        debugPrint("Token not found");
        return;
      }

      final url = Uri.parse(
        "https://freepik.softvenceomega.com/ts/meta/worker-specialist-type",
      );

      final response =
          await HttpClient().getUrl(url)
            ..headers.set("Authorization", "Bearer $token")
            ..headers.set("accept", "*/*");

      final result = await response.close();

      if (result.statusCode == 200) {
        final jsonStr = await result.transform(utf8.decoder).join();
        final List<dynamic> jsonData = jsonDecode(jsonStr);
        specialistList.value =
            jsonData.map((e) => WorkerSpecialist.fromJson(e)).toList();
      } else {
        debugPrint("Failed to fetch: ${result.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception during fetchSpecialists: $e");
    }
  }

  void selectSpecialist(WorkerSpecialist value) {
    debugPrint("Selected: ${value.name} (ID: ${value.id})");
    selectedSpecialist.value = value;
  }

  void pickImage(String imagePath) {
    profilePicPath.value = imagePath;
  }

  Future<void> submitProfile() async {
    if (userName.value.isEmpty ||
        location.value.isEmpty ||
        workerId.value.isEmpty ||
        selectedSpecialist.value == null ||
        profilePicPath.value.isEmpty) {
      Get.snackbar(
        "Fout",
        "Alle velden zijn verplicht!",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final file = File(profilePicPath.value);
    if (!file.existsSync()) {
      Get.snackbar("Fout", "Afbeeldingsbestand bestaat niet!");
      return;
    }

    isLoading.value = true;

    try {
      final token = await AuthService.getToken();
      if (token == null) {
        Get.snackbar("Fout", "Gebruiker niet geauthenticeerd (401)");
        isLoading.value = false;
        return;
      }

      debugPrint("Submitting Profile with:");
      debugPrint("userName: ${userName.value}");
      debugPrint("location: ${location.value}");
      debugPrint("workerId: ${workerId.value}");
      debugPrint("workerSpecialtyId: ${selectedSpecialist.value?.id}");
      debugPrint("profilePicPath: ${profilePicPath.value}");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.createWorkerProfileUrl),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['userName'] = userName.value;
      request.fields['location'] = location.value;
      request.fields['workerId'] = workerId.value;
      request.fields['workerSpecialtyId'] = selectedSpecialist.value!.id;

      // request.files.add(
      //   await http.MultipartFile.fromPath(
      //     'profilePic',
      //     profilePicPath.value,
      //     filename: path.basename(profilePicPath.value),
      //     contentType: MediaType('image', 'jpeg'),
      //   ),
      // );

      final file = File(profilePicPath.value);
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
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      debugPrint("Response ${response.statusCode}: $responseBody");

      // Need to change
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Succes", "Profiel succesvol aangemaakt!");
        Get.offAll(() => BottomNavbar());
      } else {
        Get.snackbar("Fout", "Serverfout (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Fout", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
