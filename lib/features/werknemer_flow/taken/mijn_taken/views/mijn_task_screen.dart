import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/completed_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/confirm_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/payment_pending_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/controllers/upcoming_task_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_completed_task_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_confirmed_task_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_payment_pending_tasks_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/all_upcoming_task_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/complete_details_screen.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/set_price_task_details.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/complete_task_card.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/filter_dialog.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/upcoming_task_card.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/widgets/payment_all_task_card.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/views/worker_taskExecution_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyTaskScreen extends StatelessWidget {
  const MyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UpcomingTaskController upcomingTaskController = Get.put(
      UpcomingTaskController(),
    );
    final PaymentPendingTaskController paymentPendingController = Get.put(
      PaymentPendingTaskController(),
    );
    final ConfirmedTaskController confirmedTaskController = Get.put(
      ConfirmedTaskController(),
    );

    final CompletedTaskController completedTaskController = Get.put(
      CompletedTaskController(),
    );

    // Fetch tasks when the screen is initialized
    upcomingTaskController.fetchNonSetPriceTasks();

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Mijn Taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),

        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dates Section
                // ShowDates(),
                // SizedBox(height: 20),

                // Search Box and Filter Option
                Row(
                  children: [
                    // search
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.primaryWhite,

                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12.0,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(IconPath.search),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondaryWhite,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.secondaryWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // filter
                    GestureDetector(
                      onTap:
                          () => showDialog(
                            context: context,
                            builder: (context) => FilterDialog(),
                          ),
                      child: Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gold3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset(IconPath.filter),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildSteldePrijzenInView(upcomingTaskController),
                SizedBox(height: 30),
                _buildBetalingInAfwachtingView(paymentPendingController),
                SizedBox(height: 20),
                _buildBevestigdeTakenView(confirmedTaskController),
                _buildCompleteListView(completedTaskController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteListView(
    CompletedTaskController completedTaskController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Voltooide Taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        SizedBox(height: 10.h),
        // Completed Task Card Called here,
        // ...completedTaskController.completedTasks.map(
        //   (task) => CompletedTaskCard(employeesCompletedTask: task),
        // ),
        // ...completedTaskController.completedTasks
        //     .take(3)
        //     .map(
        //       (task) => CompletedTaskCard(employeesCompletedTask: task),
        //     ),
        Obx(() {
          if (completedTaskController.completeTasks.isEmpty) {
            return const Center(
              child: Text('Geen bevestigde taken.'), // No confirmed tasks
            );
          }

          final displayedTasks =
              completedTaskController.completeTasks.take(3).toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayedTasks.length,
            itemBuilder: (context, index) {
              final task = displayedTasks[index];
              // return CompleteTaskCard(task: task);
              return CompleteTaskCard(
                task: task,
                onPressed: () {
                  debugPrint('completeTask id ${task.id}');
                  Get.to(
                    CompleteDetailsScreen(taskId: task.id),
                    transition: Transition.leftToRight,
                  );
                },
              );
            },
          );
        }),

        SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              Get.to(() => AllCompletedTasksScreen());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bekijk alles',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGold,
                  ),
                ),
                SizedBox(width: 8.0),
                Image.asset(IconPath.arrowRight6),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBevestigdeTakenView(
    ConfirmedTaskController confirmedTaskController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bevestigde Taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),

        // // Confirmed Task Card Called here,
        // ...employeeHomeController.confirmedTasks
        //     .take(3)
        //     .map(
        //       (myConfirmedTask) =>
        //           AllTaskCard(allTask: myConfirmedTask),
        //     ),
        SizedBox(height: 10.h),
        Obx(() {
          if (confirmedTaskController.confirmedTasks.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Geen bevestigde taken.'),
              ), // No confirmed tasks
            );
          }

          final displayedTasks =
              confirmedTaskController.confirmedTasks.take(3).toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayedTasks.length,
            itemBuilder: (context, index) {
              final task = displayedTasks[index];
              return CompleteTaskCard(
                task: task,
                onPressed: () {
                  debugPrint('confirmTask id ${task.id}');
                  Get.to(
                    WorkerTaskExecutionScreen(taskId: task.id),
                    transition: Transition.leftToRight,
                  );
                },
              );
            },
          );
        }),

        SizedBox(height: 20),

        Center(
          child: TextButton(
            onPressed: () {
              Get.to(() => AllConfirmedTasksScreen());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bekijk alles',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGold,
                  ),
                ),
                SizedBox(width: 8.0),
                Image.asset(IconPath.arrowRight6),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildBetalingInAfwachtingView(
    PaymentPendingTaskController paymentPendingController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Betaling In Afwachting Taken",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        // // Payment Pending Task Card Called here,
        // ...employeeHomeController.paymentPendingTasks
        //     .take(3)
        //     .map(
        //       (myPaymentPendingTasks) =>
        //           AllTaskCard(allTask: myPaymentPendingTasks),
        //     ),
        SizedBox(height: 10.h),
        //------------------new----------------------
        Obx(() {
          if (paymentPendingController.paymentPendingTasks.isEmpty) {
            return Center(child: Text('Geen betaling in afwachting.'));
          }

          final displayedTasks =
              paymentPendingController.paymentPendingTasks.take(3).toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: displayedTasks.length,
            itemBuilder: (context, index) {
              final task = displayedTasks[index];
              return PaymentAllTaskCard(task: task);
            },
          );
        }),
        SizedBox(height: 20),

        Center(
          child: TextButton(
            onPressed: () {
              Get.to(() => AllPaymentPendingTasksScreen());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bekijk alles',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGold,
                  ),
                ),
                SizedBox(width: 8.0),
                Image.asset(IconPath.arrowRight6),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSteldePrijzenInView(
    UpcomingTaskController upcomingTaskController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Stel de Prijzen In",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        SizedBox(height: 10.h),
        // Upcoming Tasks
        Obx(() {
          if (upcomingTaskController.upcomingTasks.isEmpty) {
            return Center(
              child: Text(
                "Geen aankomende taken.",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            );
          }

          // Show only first 3 tasks
          final displayedTasks =
              upcomingTaskController.upcomingTasks.take(3).toList();
          debugPrint('upcoming 3 list $displayedTasks');
          debugPrint(upcomingTaskController.upcomingTasks.length.toString());

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: displayedTasks.length,
            itemBuilder: (context, index) {
              final task = upcomingTaskController.upcomingTasks[index];

              return UpcomingTaskCard(
                upcomingTask: displayedTasks[index],
                onPressed: () {
                  debugPrint('specific id ${task.id}');
                  upcomingTaskController.fetchTaskDetails(task.id);
                  Get.to(
                    SetPriceTaskDetails(),
                    transition: Transition.leftToRight,
                  );
                },
              );
            },
          );
        }),
        SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              Get.to(() => AllUpcomingTaskScreen());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bekijk alles',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryGold,
                  ),
                ),
                SizedBox(width: 8.0),
                Image.asset(IconPath.arrowRight6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
