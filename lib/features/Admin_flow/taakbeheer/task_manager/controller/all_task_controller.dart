// import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/all_task_data_model.dart';
// import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/all_task_model.dart';
// import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AllTasksController extends GetxController {
//   var tasks = <Task>[].obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadTasks();
//   }

//   Future<void> loadTasks() async {
//     isLoading.value = true;
//     try {
//       String? token = await AuthService.getToken();
//       debugPrint('Token retrieved: $token');

//       if (token == null || token.isEmpty) {
//         debugPrint('Error: No token found or token is empty.');
//         await EasyLoading.showError(
//           'Authentication token is not available',
//           duration: const Duration(seconds: 3),
//         );
//         throw Exception('Authentication token is not available');
//       }

//       final response = await http.get(
//         Uri.parse('https://freepik.softvenceomega.com/ts/admin/all-tasks'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         final List<Task> fetchedTasks = data.map((json) {
//           final allTasks = AllTasks.fromJson(json);
//           return Task(
//             title: allTasks.propertyName ?? 'Unknown Task',
//             location: allTasks.location ?? 'Unknown Location',
//             assignee: allTasks.worker?.name ?? 'Unassigned',
//             date: allTasks.createdAt != null
//                 ? DateTime.parse(allTasks.createdAt!)
//                 : DateTime.now(),
//             status: _mapStatus(allTasks.status),
//           );
//         }).toList();

//         tasks.assignAll(fetchedTasks);
//       } else {
//         await EasyLoading.showError(
//           'Failed to fetch tasks: ${response.statusCode}',
//           duration: const Duration(seconds: 3),
//         );
//         throw Exception('Failed to fetch tasks: ${response.statusCode}');
//       }
//     } catch (e) {
//       await EasyLoading.showError(
//         'An error occurred: $e',
//         duration: const Duration(seconds: 3),
//       );
//       debugPrint('Error fetching tasks: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   TaskStatus _mapStatus(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'bezig':
//         return TaskStatus.bezig;
//       case 'voltooid':
//         return TaskStatus.voltooid;
//       case 'te laat':
//         return TaskStatus.teLaat;
//       case 'niet toegewezen':
//         return TaskStatus.nietToegewezen;
//       default:
//         return TaskStatus.nietToegewezen;
//     }
//   }
// }


import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/all_task_data_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/all_task_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTasksController extends GetxController {
  var tasks = <Task>[].obs;
  var filteredTasks = <Task>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  var selectedLocation = ''.obs;
  var selectedMonth = ''.obs;
  var selectedYear = ''.obs;
  var selectedTaskType = ''.obs;
  var selectedTaskStatus = ''.obs;

  var locations = <String>[].obs;
  var months = <String>[
    'Januari', 'Februari', 'Maart', 'April', 'Mei', 'Juni',
    'Juli', 'Augustus', 'September', 'Oktober', 'November', 'December'
  ].obs;
  var years = <String>[].obs;
  var taskTypes = <String>[].obs;
  var taskStatuses = <String>['Bezig', 'Voltooid', 'Te Laat', 'Niet Toegewezen'].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    isLoading.value = true;
    try {
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

      final response = await http.get(
        Uri.parse(Urls.adminalltask),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Task> fetchedTasks = data.map((json) {
          final allTasks = AllTasks.fromJson(json);
          return Task(
            title: allTasks.propertyName ?? 'Unknown Task',
            location: allTasks.location ?? 'Unknown Location',
            assignee: allTasks.worker?.name ?? 'Unassigned',
            date: allTasks.createdAt != null
                ? DateTime.parse(allTasks.createdAt!)
                : DateTime.now(),
            status: _mapStatus(allTasks.status),
          );
        }).toList();

        tasks.assignAll(fetchedTasks);
        filteredTasks.assignAll(fetchedTasks); // Show all tasks by default
        _populateFilterOptions();
        debugPrint('Tasks loaded: ${tasks.length}');
        debugPrint('Filtered Tasks (initial): ${filteredTasks.length}');
        debugPrint('Locations: ${locations.toList()}');
        debugPrint('Task Types: ${taskTypes.toList()}');
        debugPrint('Years: ${years.toList()}');
      } else {
        await EasyLoading.showError(
          'Failed to fetch tasks: ${response.statusCode}',
          duration: const Duration(seconds: 3),
        );
        throw Exception('Failed to fetch tasks: ${response.statusCode}');
      }
    } catch (e) {
      await EasyLoading.showError(
        'An error occurred: $e',
        duration: const Duration(seconds: 3),
      );
      debugPrint('Error fetching tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFilterOptions() {
    locations.assignAll(tasks
        .map((task) => task.location)
        .where((location) => location.isNotEmpty)
        .toSet()
        .toList()
      ..sort());
    taskTypes.assignAll(tasks
        .map((task) => task.title)
        .where((title) => title.isNotEmpty)
        .toSet()
        .toList()
      ..sort());
    years.assignAll(tasks
        .map((task) => task.date.year.toString())
        .toSet()
        .toList()
      ..sort());
    // Ensure taskStatuses are capitalized for display
    taskStatuses.assignAll(['Bezig', 'Voltooid', 'Te Laat', 'Niet Toegewezen']);
  }

  TaskStatus _mapStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'bezig':
        return TaskStatus.bezig;
      case 'voltooid':
        return TaskStatus.voltooid;
      case 'te laat':
        return TaskStatus.teLaat;
      case 'niet toegewezen':
        return TaskStatus.nietToegewezen;
      default:
        return TaskStatus.nietToegewezen;
    }
  }

  void filterTasks() {
    filteredTasks.assignAll(tasks.where((task) {
      bool matchesSearch = searchQuery.value.isEmpty ||
          task.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      bool matchesLocation = selectedLocation.value.isEmpty ||
          task.location == selectedLocation.value;
      bool matchesMonth = selectedMonth.value.isEmpty ||
          task.date.month == months.indexOf(selectedMonth.value) + 1;
      bool matchesYear = selectedYear.value.isEmpty ||
          task.date.year.toString() == selectedYear.value;
      bool matchesTaskType = selectedTaskType.value.isEmpty ||
          task.title == selectedTaskType.value;
      bool matchesTaskStatus = selectedTaskStatus.value.isEmpty ||
          task.status.toString().split('.').last.capitalize == selectedTaskStatus.value;

      return matchesSearch &&
          matchesLocation &&
          matchesMonth &&
          matchesYear &&
          matchesTaskType &&
          matchesTaskStatus;
    }).toList());
    debugPrint('Filtered Tasks: ${filteredTasks.length}');
    debugPrint('Filters Applied - Search: ${searchQuery.value}, Location: ${selectedLocation.value}, '
        'Month: ${selectedMonth.value}, Year: ${selectedYear.value}, '
        'Task Type: ${selectedTaskType.value}, Status: ${selectedTaskStatus.value}');
  }

  void resetFilters() {
    selectedLocation.value = '';
    selectedMonth.value = '';
    selectedYear.value = '';
    selectedTaskType.value = '';
    selectedTaskStatus.value = '';
    searchQuery.value = '';
    filteredTasks.assignAll(tasks); // Reset to all tasks
    debugPrint('Filters reset, showing all tasks: ${filteredTasks.length}');
  }
}