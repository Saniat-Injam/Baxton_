import 'package:baxton/features/Admin_flow/admin_home/controller/home_screen_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TaskOverviewController extends GetxController {
  var stats = TaskStats(
    assigned: 0,
    inProgress: 0,
    completed: 0,
    overdue: 0,
    unassigned: 0,
  ).obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  Future<void> fetchStats() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      EasyLoading.show(status: 'Loading task statistics...');

      // Ensure HomeScreenController is initialized only once
      if (!Get.isRegistered<HomeScreenController>()) {
        Get.put(HomeScreenController());
        debugPrint('HomeScreenController initialized in TaskOverviewController');
      }

      final homeController = Get.find<HomeScreenController>();

      // Wait for homedata to be fetched if not already available
      if (homeController.homedata.value == null) {
        debugPrint('homedata is null, calling fetchHomeData');
        await homeController.fetchHomeData();
      }

      // Check if homedata is still null after fetch
      if (homeController.homedata.value == null) {
        debugPrint('homedata is still null after fetchHomeData');
        errorMessage.value = 'Failed to load task statistics';
        EasyLoading.showError('Failed to load task statistics');
        return;
      }

      // Update stats with API data
      final taskStatistics = homeController.homedata.value!.data.taskStatistics;
      stats.value = TaskStats(
        assigned: taskStatistics.totalAssignedTasks,
        inProgress: taskStatistics.totalConfirmedTasks,
        completed: taskStatistics.totalCompletedTasks,
        overdue: taskStatistics.totalLateWork,
        unassigned:
            taskStatistics.totalTaskRequests - taskStatistics.totalAssignedTasks,
      );
      debugPrint('Stats updated from API: assigned=${stats.value.assigned}, '
          'inProgress=${stats.value.inProgress}, completed=${stats.value.completed}, '
          'overdue=${stats.value.overdue}, unassigned=${stats.value.unassigned}');
      EasyLoading.showSuccess('Task statistics loaded successfully');
    } catch (e, stackTrace) {
      debugPrint('Error fetching stats: $e');
      debugPrint('StackTrace: $stackTrace');
      errorMessage.value = 'Error loading task statistics: $e';
      EasyLoading.showError('Error loading task statistics: $e');
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  void updateStats(TaskStats newStats) {
    stats.value = newStats;
    debugPrint('Stats manually updated: ${stats.value.toString()}');
  }
}