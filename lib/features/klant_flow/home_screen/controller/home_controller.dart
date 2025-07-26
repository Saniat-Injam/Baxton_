import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/home_screen/models/fetch_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/home_model.dart';

class HomeController extends GetxController {
  // Reactive profile state
  final Rx<Profile?> profile = Rx<Profile?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Service list
  final List<Service> _services = [
    Service(
      title: "Schimmelbehandeling",
      location: "New York",
      description:
          "Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.",
      time: "11:00 Am",
    ),
    Service(
      title: "Schimmelbehandeling",
      location: "New York",
      description:
          "Inspecteer het dak voor tekenen van schade. Zorg ervoor dat alle shingles stevig en in goede staat zijn.",
      time: "11:00 Am",
    ),
    Service(
      title: "Roof Inspection",
      location: "Los Angeles",
      description:
          "Inspect and repair the roof to ensure its durability and safety.",
      time: "02:00 PM",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    debugPrint('HomeController onInit called');
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    debugPrint('Starting fetchUserProfile');
    
    isLoading.value = true;
    debugPrint('Set isLoading to true');
    
    errorMessage.value = '';
    debugPrint('Cleared errorMessage');
    
    debugPrint('Showing EasyLoading indicator');
    await EasyLoading.show(status: 'Loading profile...');

    final token = await AuthService.getToken();
    debugPrint('Retrieved token: $token');
    
    if (token == null || token.isEmpty) {
      debugPrint('No token found. User is not authenticated.');
      isLoading.value = false;
      debugPrint('Set isLoading to false due to missing token');
      errorMessage.value = 'User is not authenticated. Please log in.';
      debugPrint('Set errorMessage: User is not authenticated. Please log in.');
      await EasyLoading.showError('User is not authenticated. Please log in.');
      Get.offAllNamed('/login'); // Redirect to login screen
      return;
    }

    final url = Uri.parse(Urls.userdetails);
    debugPrint('Parsed URL: $url');

    try {
      debugPrint('Making HTTP GET request to $url');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('Received response with status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('Parsing response body into Profile model');
        try {
          profile.value = profileFromJson(response.body);
          profile.refresh();
          debugPrint('Successfully set profile: ${profile.value?.data.user.name ?? "No name"}');
          await EasyLoading.showSuccess('Profile loaded successfully!');
          debugPrint('Showed success with EasyLoading');
        } catch (e) {
          debugPrint('JSON parsing error: $e');
          errorMessage.value = 'Invalid server response. Please try again.';
          await EasyLoading.showError('Invalid server response.');
        }
      } else {
        debugPrint('Failed to load profile: ${response.statusCode} - ${response.body}');
        errorMessage.value = 'Failed to load profile. Please try again.';
        debugPrint('Set errorMessage: Failed to load profile. Please try again.');
        await EasyLoading.showError('Failed to load profile: ${response.statusCode}');
        debugPrint('Showed error with EasyLoading');
      }
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      errorMessage.value = 'Error fetching profile: $e';
      debugPrint('Set errorMessage: Error fetching profile: $e');
      await EasyLoading.showError('Error fetching profile: $e');
      debugPrint('Showed error with EasyLoading');
    } finally {
      isLoading.value = false;
      debugPrint('Set isLoading to false in finally block');
      await EasyLoading.dismiss();
      debugPrint('Dismissed EasyLoading');
    }
    
    debugPrint('Completed fetchUserProfile');
  }

  List<Service> getFirstTwoServices() {
    debugPrint('Getting first two services');
    return _services.take(2).toList();
  }
}