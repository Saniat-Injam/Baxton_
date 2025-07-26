// ignore_for_file: await_only_futures
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_request_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/view/task_request_details_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskRequestListView extends StatelessWidget {
  final TaskRequestController taskRequestController = Get.find<TaskRequestController>(); // Use Get.find instead of Get.put to avoid reinitializing

  TaskRequestListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: const Text('Taakverzoeken'),
        leading: const BackButton(),
      ),
      body: Obx(() {
        if (taskRequestController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (taskRequestController.errorMessage.isNotEmpty) {
          return Center(child: Text(taskRequestController.errorMessage.value));
        } else if (taskRequestController.taskRequests.isEmpty) {
          return const Center(child: Text('No Task available'));
        } else {
          return ListView.builder(
            itemCount: taskRequestController.taskRequests.length,
            itemBuilder: (context, index) {
              final task = taskRequestController.taskRequests[index];
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondaryWhite),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top: Title and Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          task.timeAgo,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Bottom: User info and Details Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(IconPath.person, height: 20),
                            const SizedBox(width: 4),
                            Text(task.user),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // Get the Datum object to retrieve the task ID
                                final datum = taskRequestController.getDetailFor(task);
                                if (datum != null) {
                                  // Fetch task details using the task ID
                                  final detail = await taskRequestController.fetchTaskDetails(datum.id);
                                  if (detail != null) {
                                    Get.to(() => TaskRequestDetailView(task: detail));
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Task details not found',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    'Error',
                                    'Task not found in local data',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGold,
                                foregroundColor: AppColors.primaryWhite,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                minimumSize: const Size(62, 29),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Details"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}