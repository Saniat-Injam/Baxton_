import 'dart:io';

import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/employee_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/task_creation_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/models/task_type_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/views/employee_screen.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TaskCreationController extends GetxController {
  final selectedEmployee = Rxn<Employee>();
  final taskTypes = <TaskType>[].obs;
  var selectedTaskType = RxnString(); // Use RxnString for null safety
  var selectedAssignee = ''.obs;
  var expertise = ''.obs;
  var selectedTime = ''.obs;
  var selectedImage = Rx<File?>(null);

  final descriptionController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController(text: '11:00 uur');

  var preferredDate = DateTime.now().obs;

  void createTask() {
    final task = TaskCreationModel(
      taskType: selectedTaskType.value ?? '', // Use name for taskType
      description: descriptionController.text,
      clientName: nameController.text,
      clientPhone: phoneController.text,
      clientLocation: locationController.text,
      preferredDate: preferredDate.value,
      preferredTime: timeController.text,
      assignedTo: selectedAssignee.value,
      expertise: expertise.value,
    );

    debugPrint("Task Created: ${task.taskType}, for ${task.clientName}");
    Get.snackbar("Success", "Taak aangemaakt!");
  }

  void openEmployeeSelection() {
    Get.to(() => EmployeeScreen());
  }

  void cancel() {
    Get.back();
  }

  Future<List<TaskType>?> fetchTaskTypes() async {
    debugPrint('Starting fetchTaskTypes API call');
    await EasyLoading.show(
      status: 'Loading task types...',
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

      const url = Urls.taskType;
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
        final taskTypesList = taskTypeListFromJson(response.body);
        taskTypes.assignAll(taskTypesList);
        if (taskTypesList.isNotEmpty) {
          selectedTaskType.value = taskTypesList.first.name;
        } else {
          selectedTaskType.value = null;
        }
        debugPrint('Parsed ${taskTypesList.length} task types');
        await EasyLoading.showSuccess('Task types loaded successfully');
        return taskTypesList;
      } else {
        debugPrint('API call failed with status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        await EasyLoading.showError('Failed to load task types: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error occurred while fetching task types: $e');
      await EasyLoading.showError('Error fetching task types: $e');
      return null;
    } finally {
      debugPrint('Cleaning up: Dismissing EasyLoading');
      await EasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    fetchTaskTypes();
    super.onInit();
  }
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Failed to pick image: $e');
      EasyLoading.showError('Failed to pick image: $e');
    }
  }
}