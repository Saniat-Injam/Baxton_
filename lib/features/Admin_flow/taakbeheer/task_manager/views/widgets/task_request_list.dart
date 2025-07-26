import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/controller/task_request_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_manager/views/widgets/task_request_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskRequestList extends StatelessWidget {
  const TaskRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskRequestController controller = Get.find<TaskRequestController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      } else if (controller.taskRequests.isEmpty) {
        return const Center(child: Text('No data available'));
      } else {
        return ListView.builder(
          itemCount: controller.taskRequests.length,
          itemBuilder: (context, index) {
            final taskRequest = controller.taskRequests[index];
            return TaskRequestCard(req: taskRequest);
          },
        );
      }
    });
  }
}