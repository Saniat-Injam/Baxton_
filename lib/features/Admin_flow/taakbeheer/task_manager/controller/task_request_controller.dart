import 'dart:convert';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/task_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/task_request_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/task_details_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskRequestController extends GetxController {
  var taskRequests = <TaskRequest>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var _apiData = <Datum>[]; // Store raw API data for details

  // Helper method to calculate time ago
  String _calculateTimeAgo(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minuten geleden';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} uur geleden';
    } else {
      return '${difference.inDays} dagen geleden';
    }
  }

  Future<void> fetchServiceRequests() async {
    final String apiUrl = Urls.serviceRequestlist;
    debugPrint('Starting fetchServiceRequests: API URL = $apiUrl');

    try {
      isLoading.value = true;
      errorMessage.value = '';

      String? token = await AuthService.getToken();
      debugPrint('Token retrieved: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Error: No token found or token is empty.');
        throw Exception('Token is not available');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('HTTP request completed. Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('Response status is 200 OK. Parsing JSON response...');
        final tarefaRequest = taskrequestFromJson(response.body);
        _apiData = tarefaRequest.data; // Store raw API data
        taskRequests.value = tarefaRequest.data
            .map(
              (datum) => TaskRequest(
                id: datum.id,
                title: datum.name,
                user: datum.clientProfile.userName,
                timeAgo: _calculateTimeAgo(datum.createdAt),
              ),
            )
            .toList();
        debugPrint('Task requests updated: ${taskRequests.length} items');
      } else {
        debugPrint(
          'Error: Failed to load service requests. Status code: ${response.statusCode}',
        );
        throw Exception(
          'Failed to load service requests: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Error occurred during fetchServiceRequests: $e');
      debugPrint('Stack trace: $stackTrace');
      errorMessage.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<Data?> fetchTaskDetails(String taskId) async {
    final String apiUrl = '${Urls.taskdetails}$taskId';
    debugPrint('Starting fetchTaskDetails: API URL = $apiUrl');

    try {
      isLoading.value = true;
      errorMessage.value = '';

      String? token = await AuthService.getToken();
      debugPrint('Token retrieved: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Error: No token found or token is empty.');
        throw Exception('Token is not available');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('HTTP request completed. Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('Response status is 200 OK. Parsing JSON response...');
        final taskDetails = taskdetailsFromJson(response.body);
        debugPrint('Task details fetched successfully for ID: $taskId');
        return taskDetails.data;
      } else {
        debugPrint(
          'Error: Failed to load task details. Status code: ${response.statusCode}',
        );
        throw Exception('Failed to load task details: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error occurred during fetchTaskDetails: $e');
      debugPrint('Stack trace: $stackTrace');
      errorMessage.value = 'Error fetching task details: $e';
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> rejectTask(String serviceRequestId) async {
    try {
      await EasyLoading.show(
        status: 'Processing...',
        maskType: EasyLoadingMaskType.black,
      );

      String? token = await AuthService.getToken();
      debugPrint('Token retrieved: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Error: No token found or token is empty.');
        await EasyLoading.showError(
          'Authentication token is not available',
          duration: const Duration(seconds: 3),
        );
        throw Exception('Authentication token is not available');
      }

      final url = Uri.parse('${Urls.rejectTask}$serviceRequestId');

      final response = await http
          .patch(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              debugPrint('Error: Request timed out');
              throw Exception('Request timed out');
            },
          );

      if (response.statusCode == 200) {
        debugPrint('Task rejected successfully for ID: $serviceRequestId');
        debugPrint('Response body: ${response.body}');
        await EasyLoading.showSuccess(
          'Task rejected successfully',
          duration: const Duration(seconds: 2),
        );
        return true;
      } else {
        debugPrint('Failed to reject task: Status ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        await EasyLoading.showError(
          'Failed to reject task: ${response.statusCode}',
          duration: const Duration(seconds: 3),
        );
        throw Exception('Failed to reject task: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error rejecting task: $e');
      await EasyLoading.showError(
        'Error rejecting task: $e',
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<bool> assignTask(String serviceRequestId, String workerId) async {
    try {
      await EasyLoading.show(
        status: 'Assigning task...',
        maskType: EasyLoadingMaskType.black,
      );

      String? token = await AuthService.getToken();
      debugPrint('Token retrieved: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Error: No token found or token is empty.');
        await EasyLoading.showError(
          'Authentication token is not available',
          duration: const Duration(seconds: 3),
        );
        throw Exception('Authentication token is not available');
      }

      final url = Uri.parse(Urls.assignTask);

      final requestBody = {'taskId': serviceRequestId, 'workerId': workerId};

      debugPrint('Request URL: $url');
      debugPrint(
        'Request Headers: ${{'Authorization': 'Bearer $token', 'Content-Type': 'application/json'}}',
      );
      debugPrint('Request Body: ${json.encode(requestBody)}');

      final response = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: json.encode(requestBody),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              debugPrint('Error: Request timed out');
              throw Exception('Request timed out');
            },
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
          'Task assigned successfully for ID: $serviceRequestId to worker: $workerId',
        );
        debugPrint('Response body: ${response.body}');
        await EasyLoading.showSuccess(
          'Task assigned successfully',
          duration: const Duration(seconds: 2),
        );
        return true;
      } else {
        debugPrint('Failed to assign task: Status ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        await EasyLoading.showError(
          'Failed to assign task: ${response.statusCode}',
          duration: const Duration(seconds: 0),
        );
        throw Exception('Failed to assign task: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error assigning task: $e');
      await EasyLoading.showError(
        'Error assigning task: $e',
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Datum? getDetailFor(TaskRequest task) {
    try {
      return _apiData.firstWhere(
        (datum) =>
            datum.id == task.id &&
            datum.name == task.title &&
            datum.clientProfile.userName == task.user &&
            _calculateTimeAgo(datum.createdAt) == task.timeAgo,
      );
    } catch (e) {
      debugPrint('Error finding detail for task: $e');
      return null;
    }
  }

  @override
  void onInit() {
    fetchServiceRequests();
    super.onInit();
  }
}