// ignore_for_file: invalid_use_of_protected_member

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/admin_home/screens/navbar.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_overview_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_request_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/all_tasks_screen.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/widgets/stat_card.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/widgets/task_request_card.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/views/task_creation_screen.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/task_request_view_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskManagerScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TaskManagerScreen({super.key}) {
    // Initialize controllers only if not already registered
    if (!Get.isRegistered<TaskOverviewController>()) {
      Get.put(TaskOverviewController());
      debugPrint('TaskOverviewController initialized in TaskManagerScreen');
    }
    if (!Get.isRegistered<TaskRequestController>()) {
      Get.put(TaskRequestController());
      debugPrint('TaskRequestController initialized in TaskManagerScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskOverviewController = Get.find<TaskOverviewController>();
    final taskRequestController = Get.find<TaskRequestController>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      key: _scaffoldKey,
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Text("Taakbeheer"),
        titleSpacing: 0,
        leading: IconButton(
          icon: Image.asset(IconPath.notes),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Obx(() {
        // Handle loading and error states
        if (taskOverviewController.isLoading.value ||
            taskRequestController.isLoading.value) {
          // return const Center(child: CircularProgressIndicator());
          return const Center(child: Text('Loading'));
        }
        if (taskOverviewController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  taskOverviewController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    taskOverviewController.fetchStats();
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }
        if (taskRequestController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  taskRequestController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    taskRequestController.fetchServiceRequests();
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Taakoverzicht",
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // StatCard Widgets
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  Wrap(
                    spacing: 12, // Horizontal space between cards
                    runSpacing: 12, // Vertical space between rows
                    children: [
                      // StatCard for "Toegewezen taken"
                      FractionallySizedBox(
                        widthFactor:
                            0.48, // Set the width to 48% of the parent width
                        child: StatCard(
                          iconPath: IconPath.assignedTask,
                          title: "Toegewezen taken",
                          count: taskOverviewController.stats.value.assigned,
                          countTextStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),

                      // StatCard for "In uitvoering"
                      FractionallySizedBox(
                        widthFactor:
                            0.48, // Set the width to 48% of the parent width
                        child: StatCard(
                          iconPath: IconPath.inProgress,
                          title: "In uitvoering",
                          count: taskOverviewController.stats.value.inProgress,
                          countTextStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),

                      // StatCard for "Voltooid"
                      FractionallySizedBox(
                        widthFactor:
                            0.48, // Set the width to 48% of the parent width
                        child: StatCard(
                          iconPath: IconPath.completed,
                          title: "Voltooid",
                          count: taskOverviewController.stats.value.completed,
                          countTextStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlack,
                          ),
                        ),
                      ),

                      // StatCard for "Te laat"
                      FractionallySizedBox(
                        widthFactor:
                            0.48, // Set the width to 48% of the parent width
                        child: StatCard(
                          iconPath: IconPath.tooLate,
                          title: "Te laat",
                          count: taskOverviewController.stats.value.overdue,
                          countTextStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryRed,
                          ),
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(() => AllTasksScreen());
                    },
                    child: StatCard(
                      iconPath: IconPath.totalNumberOfTasks,
                      title: "Totaal aantal taken",
                      count:
                          taskOverviewController.stats.value.assigned +
                          taskOverviewController.stats.value.inProgress +
                          taskOverviewController.stats.value.completed +
                          taskOverviewController.stats.value.overdue +
                          taskOverviewController.stats.value.unassigned,
                      width: screenWidth - 36,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      countTextStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Unassigned Tasks Button
              SizedBox(
                height: 54,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => TaskRequestListView());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryBlue,
                    foregroundColor: AppColors.primaryBlack,
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          "${taskOverviewController.stats.value.unassigned}",
                          style: getTextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text("Niet-toegewezen taken"),
                      const SizedBox(width: 40),
                      Image.asset(IconPath.arrowRight2),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Create New Task Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => CreateNewTaskScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Nieuwe taak aanmaken"),
                      SizedBox(width: 8),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Task Requests Section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Taakverzoeken",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => TaskRequestListView());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Bekijk alles ",
                              style: getTextStyle(
                                color: AppColors.primaryGold,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(IconPath.arrowRight3),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Task Request Cards
                  Column(
                    children:
                        taskRequestController.taskRequests.value
                            .map((req) => TaskRequestCard(req: req))
                            .toList(),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
