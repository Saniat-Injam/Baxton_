import 'package:baxton/features/klant_flow/home_screen/widgets/service_widget.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/request_screen.dart';
import 'package:baxton/features/klant_flow/task_screen/widgets/complete_job.dart';
import 'package:baxton/features/klant_flow/task_screen/widgets/pay_to_confirm.dart';
import 'package:flutter/material.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_icon_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/job_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final JobController jobsController = Get.put(JobController());
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SafeArea(
            child: taskController.showRequestScreen.value
                ? RequestScreen(
                    onBack: () => taskController.toggleRequestScreen(false),
                  )
                : buildTaskContent(),
          ),
        ));
  }

  Widget buildTaskContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Mijn Taken",
                style: getTextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
             SizedBox(height: 20),
            CustomIconButton(
              text: "Vraag Service Aan",
              icon: Icons.add,
              onTap: () => taskController.toggleRequestScreen(true),
              isPrefix: false,
            ),
             SizedBox(height: 20),
            Text(
              "Aangevraagde Dienst",
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
             SizedBox(height: 20),
            Obx(() {
              final requestedServices = jobsController.getRequestedServices();
              debugPrint('Rendering requested services: ${requestedServices.length} items');
              if (jobsController.isLoading.value) {
                debugPrint('Showing loading indicator');
                return  Center(child: CircularProgressIndicator());
              }
              if (jobsController.errorMessage.value.isNotEmpty) {
                debugPrint('Showing error: ${jobsController.errorMessage.value}');
                return Column(
                  children: [
                    Text(
                      "Error: ${jobsController.errorMessage.value}",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                     SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: jobsController.retryFetch,
                      child:  Text("Retry"),
                    ),
                  ],
                );
              }
              if (requestedServices.isEmpty) {
                debugPrint('No requested services found');
                return Text(
                  "Geen aangevraagde diensten",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textThird,
                  ),
                );
              }
              debugPrint('Rendering ${requestedServices.length} ServiceContainer widgets');
              return Column(
                children: requestedServices
                    .asMap()
                    .entries
                    .map((entry) {
                      final index = entry.key;
                      final service = entry.value;
                      debugPrint('Service $index: ${service.taskTypeId ?? "null"}, ${service.status}');
                      return ServiceContainer(service: service);
                    })
                    .toList(),
              );
            }),
            const SizedBox(height: 40),
            Text(
              "Betaal om te bevestigen",
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            PayToConfirm(jobscontroller: jobsController),
            const SizedBox(height: 40),
            Text(
              "Voltooide Dienst",
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Completejob(jobscontroller: jobsController),
          ],
        ),
      ),
    );
  }
}