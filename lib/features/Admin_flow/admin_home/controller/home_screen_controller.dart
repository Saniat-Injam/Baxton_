
import 'dart:convert';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/admin_home/model/admin_profile_model.dart';
import 'package:baxton/features/Admin_flow/admin_home/model/home_data_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController {
  final Rx<Homedata?> homedata = Rx<Homedata?>(null);
  final Rx<Adminprofile?> profile = Rx<Adminprofile?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString webSocketMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  // Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    debugPrint('Search query updated: $query');
  }

  // Fetch home data
  Future<void> fetchHomeData() async {
    debugPrint('Starting fetchHomeData');
    try {
      EasyLoading.show(status: 'Loading...');
      debugPrint('Attempting to retrieve token');
      String? token = await AuthService.getToken();
      debugPrint("Token: $token");

      if (token == null || token.isEmpty) {
        debugPrint('No token found. User is not authenticated.');
        throw Exception("Token is not available");
      }

      final url = Urls.homedata;
      debugPrint("API URL: $url");
      debugPrint('Making HTTP GET request');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        debugPrint("Parsed JSON Data: $jsonData");

        homedata.value = Homedata.fromJson(jsonData);
        debugPrint("Total Workers: ${homedata.value?.data.totalWorkers}");
        debugPrint('Home Data Message: ${homedata.value?.message}');
        EasyLoading.showSuccess('Data loaded successfully');
      } else {
        debugPrint('Failed to load home data: ${response.statusCode}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint("Error in fetchHomeData: $e");
      debugPrint("StackTrace: $stackTrace");
      errorMessage.value = 'Failed to load data: $e';
      EasyLoading.showError('Failed to load data: $e');
    } finally {
      EasyLoading.dismiss();
      debugPrint('fetchHomeData completed');
    }
  }

  // Fetch admin profile
  Future<void> fetchAdminProfile() async {
    debugPrint('Starting fetchAdminProfile');
    isLoading.value = true;
    debugPrint('Set isLoading to true');
    errorMessage.value = '';
    debugPrint('Cleared errorMessage');

    try {
      debugPrint('Attempting to retrieve token');
      final token = await AuthService.getToken();
      debugPrint('Retrieved token: $token');

      if (token == null || token.isEmpty) {
        debugPrint('No token found. User is not authenticated.');
        isLoading.value = false;
        errorMessage.value = 'User is not authenticated. Please log in.';
        await EasyLoading.showError(
          'User is not authenticated. Please log in.',
        );
        return;
      }

      final url = Uri.parse(Urls.userdetails);
      debugPrint('Parsed URL: $url');
      debugPrint('Making HTTP GET request');

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
        profile.value = adminprofileFromJson(response.body);
        debugPrint(
          'Successfully set profile: ${profile.value?.data.user.name ?? "No name"}',
        );
        await EasyLoading.showSuccess('Profile loaded successfully!');
      } else {
        debugPrint(
          'Failed to load profile: ${response.statusCode} - ${response.body}',
        );
        errorMessage.value = 'Failed to load profile. Please try again.';
        await EasyLoading.showError(
          'Failed to load profile: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching profile: $e');
      debugPrint('StackTrace: $stackTrace');
      errorMessage.value = 'Error fetching profile: $e';
      await EasyLoading.showError('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      await EasyLoading.dismiss();
      debugPrint('fetchAdminProfile completed');
    }
  }
  

  @override
  void onInit() {
    debugPrint('HomeScreenController onInit called');
    fetchAdminProfile();
    fetchHomeData();
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint('HomeScreenController onClose called');
    // WebSocket connection is not closed to maintain persistent connection
    super.onClose();
  }
}