import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/my_task_model.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/repository/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TaskDataController extends GetxController {
  final TaskRepository _taskRepository = TaskRepository();

  RxBool isLoading = false.obs;

  RxList<MyTask> allTasks = <MyTask>[].obs;

  RxString errorMessage = ''.obs;
  RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      EasyLoading.show(status: 'Loading tasks...');

      final String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      final tasks = await _taskRepository.fetchMyTasks(token);
      allTasks.assignAll(tasks);

      debugPrint('Successfully loaded ${tasks.length} tasks');
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      debugPrint('Error fetching tasks: $e');
      EasyLoading.showError('Failed to load tasks');
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  // List<MyTask> get confirmedTasks =>
  //     allTasks.where((task) => task.isPaymentCompleted).toList();
}
