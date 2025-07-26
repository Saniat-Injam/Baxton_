
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/all_employe_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Employee {
  final String workerId;
  final String name;
  final String expertise;
  final String imageUrl;

  Employee({
    required this.workerId,
    required this.name,
    required this.expertise,
    required this.imageUrl,
  });
}

class EmployeeController extends GetxController {
  var allEmployees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;
  var selectedExpertise = ''.obs;
  var selectedEmployee = Rx<Employee?>(null);
  var isLoading = false.obs;
  var error = RxString('');

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      debugPrint('Starting fetchEmployees...');
      await EasyLoading.show(status: 'Loading employees...');
      String? token = await AuthService.getToken();
      debugPrint(
        'Token retrieved: ${token != null ? "Valid token" : "Null or empty token"}',
      );

      if (token == null || token.isEmpty) {
        debugPrint('Error: No token found or token is empty.');
        await EasyLoading.showError(
          'Authentication token is not available',
          duration: const Duration(seconds: 5),
        );
        throw Exception('Authentication token is not available');
      }

      isLoading(true);
      error('');

      final response = await http.get(
        Uri.parse('https://freepik.softvenceomega.com/ts/admin/employees'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('API Status code: ${response.statusCode}');
      debugPrint('API Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiResponse = apiEmployeeResponseFromJson(response.body);
        if (apiResponse.success) {
          allEmployees.assignAll(
            apiResponse.data.map((apiEmp) {
              return Employee(
                name: apiEmp.user.name,
                expertise: apiEmp.workerSpecialist.name,
                imageUrl: apiEmp.profilePic.url,
                workerId: apiEmp.id,
              );
            }).toList(),
          );

          filteredEmployees.assignAll(allEmployees);
          await EasyLoading.showSuccess('Employees loaded');
        } else {
          await EasyLoading.showError(apiResponse.message);
          throw Exception(apiResponse.message);
        }
      } else {
        final errorMsg = 'Failed to load employees: ${response.statusCode}';
        await EasyLoading.showError(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      error(e.toString());
      await EasyLoading.showError('Error: ${e.toString()}');
    } finally {
      isLoading(false);
      await EasyLoading.dismiss();
    }
  }

  void filterByExpertise(String keyword) {
    selectedExpertise.value = keyword;
    if (keyword.isEmpty) {
      filteredEmployees.assignAll(allEmployees);
    } else {
      filteredEmployees.value =
          allEmployees.where((e) => e.expertise == keyword).toList();
    }
  }

  void searchEmployee(String query) {
    final lower = query.toLowerCase();
    if (query.isEmpty) {
      filteredEmployees.assignAll(allEmployees);
    } else {
      filteredEmployees.value =
          allEmployees
              .where((e) => e.name.toLowerCase().contains(lower))
              .toList();
    }
  }

  void selectEmployee(Employee employee) {
    selectedEmployee.value = employee;
  }

  List<String> getExpertiseList() {
    final expertiseList = allEmployees.map((e) => e.expertise).toSet().toList();
    return expertiseList;
  }
}