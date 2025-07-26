import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/models/all_employe_model.dart';
import 'package:baxton/features/Admin_flow/medewerkerbeheer/models/worker_details_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class MedewerkerbeheerController extends GetxController {
  var searchController = TextEditingController();
  String? selectedLocation;
  String? selectedExpertise;
  var selectedPosition = 'Choose option'.obs;

  // Observable list to store fetched employees
  var employees = <Datum>[].obs;
  // Computed filtered employees list
  var filteredEmployees = <Datum>[].obs;
  // Observable list for worker details
  var workerDetails = Rxn<Workerdetails>();
  // Observable list for tasks (AssignedService)
  var tasks = <AssignedService>[].obs;

  // Debounce timer for search
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
    // Listen to search text changes with debounce
    searchController.addListener(_onSearchChanged);
    // Update filtered list when employees or filters change
    ever(employees, (_) => _filterEmployees());
    ever(selectedPosition, (_) => _filterEmployees());
  }

  @override
  void onClose() {
    searchController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  void setPosition(String position) {
    selectedPosition.value = position;
    debugPrint('Position set to: $position');
    _filterEmployees();
  }

  void setSelectedLocation(String location) {
    selectedLocation = location;
    debugPrint('Selected location: $location');
    _filterEmployees();
    update();
  }

  void setSelectedExpertise(String expertise) {
    selectedExpertise = expertise;
    debugPrint('Selected expertise: $expertise');
    _filterEmployees();
    update();
  }

  // Debounced search handler
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      debugPrint('Search query: ${searchController.text}');
      _filterEmployees();
    });
  }

  // Filter employees based on search and dropdown selections
  void _filterEmployees() {
    final query = searchController.text.trim().toLowerCase();
    debugPrint('Filtering employees with query: "$query", location: "$selectedLocation", expertise: "$selectedExpertise"');

    filteredEmployees.assignAll(
      employees.where((employee) {
        final matchesSearch = query.isEmpty ||
            (employee.user?.name?.toLowerCase().contains(query) ?? false) ||
            (employee.userName?.toLowerCase().contains(query) ?? false) ||
            (employee.workerSpecialist?.name.toLowerCase().contains(query) ?? false);

        final matchesLocation = selectedLocation == null ||
            (employee.location != null &&
                employee.location.toString().toLowerCase().contains(selectedLocation!.toLowerCase()));

        final matchesExpertise = selectedExpertise == null ||
            (employee.workerSpecialist != null &&
                employee.workerSpecialist!.name.toLowerCase() == selectedExpertise!.toLowerCase());

        final isMatch = matchesSearch && matchesLocation && matchesExpertise;
        debugPrint(
            'Employee: ${employee.user?.name ?? employee.userName ?? "Unknown"}, Search: $matchesSearch, Location: $matchesLocation, Expertise: $matchesExpertise, IsMatch: $isMatch');
        return isMatch;
      }).toList(),
    );

    debugPrint('Filtered employees count: ${filteredEmployees.length}');
  }

  Future<Allemploye?> fetchEmployees() async {
    debugPrint('Starting fetchEmployees API call');
    await EasyLoading.show(
      status: 'Loading employees...',
      maskType: EasyLoadingMaskType.black,
    );

    try {
      debugPrint('Fetching authentication token');
      String? token = await AuthService.getToken();
      debugPrint('Retrieved token: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Token validation failed: Token is null or empty');
        await EasyLoading.showError('Authentication token is missing');
        throw Exception('Token is not available');
      }

      final response = await http.get(
        Uri.parse(Urls.employees),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('API response received with status code: ${response.statusCode}');
      debugPrint('Raw API response: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('API call successful, parsing response body');
        final allemploye = allemployeFromJson(response.body);

        debugPrint('Parsed response into Allemploye model: ${allemploye.toString()}');

        // Filter out invalid entries (optional, based on your requirements)
        employees.assignAll(
          allemploye.data.where((employee) => employee.id != null).toList(),
        );
        debugPrint('Stored ${employees.length} valid employees in observable list');

        _filterEmployees();

        await EasyLoading.dismiss();
        await EasyLoading.showSuccess('Employees loaded successfully');
        return allemploye;
      } else {
        debugPrint('API call failed with status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        await EasyLoading.showError('Failed to load employees: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error occurred while fetching employees: $e');
      await EasyLoading.showError('Error fetching employees: $e');
      return null;
    } finally {
      debugPrint('Cleaning up: Dismissing EasyLoading');
      await EasyLoading.dismiss();
    }
  }

  Future<Workerdetails?> fetchWorkerDetails(String? employeeId) async {
    if (employeeId == null || employeeId.isEmpty) {
      debugPrint('Invalid employeeId: $employeeId');
      await EasyLoading.showError('Invalid employee ID');
      return null;
    }

    debugPrint('Starting fetchWorkerDetails API call for employeeId: $employeeId');
    await EasyLoading.show(
      status: 'Loading worker details...',
      maskType: EasyLoadingMaskType.black,
    );

    try {
      debugPrint('Fetching authentication token');
      String? token = await AuthService.getToken();
      debugPrint('Retrieved token: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Token validation failed: Token is null or empty');
        await EasyLoading.showError('Authentication token is missing');
        throw Exception('Token is not available');
      }

      final url = 'https://freepik.softvenceomega.com/ts/admin/worker-details?id=$employeeId';
      debugPrint('Sending GET request to API: $url');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('API response received with status code: ${response.statusCode}');
      debugPrint('Raw API response: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('API call successful, parsing response body');
        final workerdetails = workerdetailsFromJson(response.body);

        debugPrint('Parsed response into Workerdetails model: ${workerdetails.toString()}');

        workerDetails.value = workerdetails;
        tasks.assignAll(workerdetails.data.assignedService);
        debugPrint('Stored ${tasks.length} tasks in observable list');

        await EasyLoading.showSuccess('Worker details loaded successfully');
        return workerdetails;
      } else {
        debugPrint('API call failed with status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        await EasyLoading.showError('Failed to load worker details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error occurred while fetching worker details: $e');
      await EasyLoading.showError('Error fetching worker details: $e');
      return null;
    } finally {
      debugPrint('Cleaning up: Dismissing EasyLoading');
      await EasyLoading.dismiss();
    }
  }
}