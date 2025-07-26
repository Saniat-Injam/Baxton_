// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_button.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/request_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/task_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class BeoordelingsverzoekScreen extends StatelessWidget {
  BeoordelingsverzoekScreen({super.key});

  TaskController taskController = Get.put(TaskController());
  final RequestController requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Beoordelingsverzoek",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Obx(() {
        if (requestController.requestId.value.isEmpty ||
            requestController.serviceRequest.value == null) {
          debugPrint(
            'No request data: requestId=${requestController.requestId.value}',
          );
          return const Center(child: Text('No request data available'));
        }

        final serviceRequest = requestController.serviceRequest.value!;
        bool hasBasePrice =
            serviceRequest.basePrice != null && serviceRequest.basePrice > 0;
        taskController.updateProgress(
          _getProgressFromStatus(serviceRequest.status, hasBasePrice),
        );

        bool isAssigned = serviceRequest.status == 'ASSIGNED';
        bool isInProgress = serviceRequest.status == 'ASSIGNED' && hasBasePrice;

        String istext =
            isInProgress
                ? "Prijs Vastgesteld door Werknemer"
                : "Toegewezen aan Werknemer";

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    // Conditionally change the text based on status
                    isAssigned ? istext : "Taak Aangevraagd",
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "${(taskController.progress.value * 100).toInt()}% Voltooid",
                  style: getTextStyle(
                    color: Color(0xff0072C3),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 32,
                      lineHeight: 14.0,
                      percent: taskController.progress.value,
                      backgroundColor: Colors.grey[300],
                      progressColor: Color(0xff0043CE),
                      barRadius: Radius.circular(10),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                SizedBox(height: 15),
                if (hasBasePrice) ...[
                  // Show price section
                  Container(
                    width: double.infinity,
                    height: 52,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFBF6E6),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFEBEBEB),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          '\$${serviceRequest.basePrice}',
                          style: TextStyle(
                            color: const Color(0xFFD9A300),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: requestController.buildImageWidget(
                    context,
                    serviceRequest,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 208,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 25,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'Naam',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            serviceRequest.name,
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'Telefoonnummer',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            serviceRequest.phoneNumber,
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'E-mail',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            serviceRequest.email,
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'Stad',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            serviceRequest.city,
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'Postcode',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            serviceRequest.postalCode,
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 120,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEBEBEB),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        'Locatie beschrijven',
                        style: getTextStyle(
                          color: const Color(0xFF666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.28,
                        ),
                      ),
                      SizedBox(
                        width: 337,
                        child: Text(
                          serviceRequest.locationDescription,
                          style: getTextStyle(
                            color: const Color(0xFFD9A300),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.32,
                            lineHeight: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 142,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 29,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'Taaktype',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 168,
                            child: Text(
                              serviceRequest.taskType.name,
                              textAlign: TextAlign.right,
                              style: getTextStyle(
                                color: const Color(0xFF1E90FF),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'Voorkeurs tijd',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            DateFormat(
                              'h:mm a',
                            ).format(serviceRequest.preferredTime),
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 4,
                        children: [
                          Text(
                            'Voorkeursdatum',
                            style: getTextStyle(
                              color: const Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            DateFormat(
                              'dd/MM/yyyy',
                            ).format(serviceRequest.preferredDate),
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              color: const Color(0xFF1E90FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                Container(
                  height: 120,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEBEBEB),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        'Probleem beschrijven',
                        style: getTextStyle(
                          color: const Color(0xFF666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.28,
                        ),
                      ),
                      SizedBox(
                        width: 337,
                        child: Text(
                          serviceRequest.problemDescription,
                          style: getTextStyle(
                            color: const Color(0xFFD9A300),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            lineHeight: 13,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                if (!isAssigned)
                  CustomButton(
                    onPress: () async {
                      // Ensure that the requestId is available
                      if (requestController.requestId.value.isEmpty) {
                        EasyLoading.showError(
                          "No request ID available for cancellation",
                        );
                        return;
                      }

                      // Get the dynamic request ID
                      String requestId = requestController.requestId.value;

                      // Confirm cancel action
                      bool confirmCancel = await requestController
                          .showCancelDialog(context);
                      if (!confirmCancel) return;

                      // Show loading
                      EasyLoading.show(status: 'Canceling request...');

                      // Call the cancel API
                      final success = await requestController.cancelRequest(
                        requestId,
                      );

                      if (success) {
                        EasyLoading.showSuccess(
                          'Request canceled successfully',
                        );
                        // Ensure TaskScreen shows _buildTaskContent by setting showRequestScreen to false
                        taskController.toggleRequestScreen(false);
                        // Navigate to TaskScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TaskScreen()),
                        );
                      } else {
                        EasyLoading.showError('Failed to cancel the request');
                      }
                    },
                    title: "Annuleer verzoek",
                    backgroundColor: Colors.transparent,
                    textcolor: Color(0xFF1E90FF),
                    borderColor: Color(0xFF1E90FF),
                  ),
                if (isAssigned & hasBasePrice) ...[
                 
                  // CustomContinueButton(
                  //   onTap: () async {
                  //     // Ensure the serviceRequest is available
                  //     if (requestController.serviceRequest.value == null) {
                  //       EasyLoading.showError(
                  //         "No service request data available",
                  //       );
                  //       debugPrint("Error: No service request data available");
                  //       return;
                  //     }

                  //     // Get the requestId from serviceRequest
                  //     final requestId =
                  //         requestController.serviceRequest.value!.id;

                  //     // Call the confirmServiceRequest API first
                  //     bool isConfirmed = await requestController
                  //         .confirmServiceRequest(requestId);
                  //     if (!isConfirmed) {
                  //       EasyLoading.showError(
                  //         "Service request confirmation failed.",
                  //       );
                  //       return; // Exit if confirmation failed
                  //     }

                  //     // If confirmed, proceed with creating the invoice
                  //     await requestController.createInvoice();
                  //     await requestController.fetchRequestStatus();

                  //     // Wait for 5 seconds before calling getInvoice
                  //     await Future.delayed(Duration(seconds: 5));

                  //     // After the delay, check if the invoiceId is available
                  //     if (requestController.serviceRequest.value!.invoiceId !=
                  //             null &&
                  //         requestController
                  //             .serviceRequest
                  //             .value!
                  //             .invoiceId
                  //             .isNotEmpty) {
                  //       // Fetch the updated service request status
                        

                  //       // Fetch the invoice after the delay
                  //       await requestController.getInvoice();
                  //     } else {
                  //       EasyLoading.showError('Invoice ID is missing');
                  //       debugPrint("Invoice ID is missing");
                  //     }
                  //   },
                  //   title: "Generate Invoice",
                  //   backgroundColor: Color(0xff1E90FF),
                  //   textColor: AppColors.textWhite,
                  // ),

                  CustomContinueButton(
  onTap: () async {
    // Ensure the serviceRequest is available
    if (requestController.serviceRequest.value == null) {
      EasyLoading.showError("No service request data available");
      debugPrint("Error: No service request data available");
      return;
    }

    // Get the requestId from serviceRequest
    final requestId = requestController.serviceRequest.value!.id;

    // Call the confirmServiceRequest API first
    bool isConfirmed = await requestController.confirmServiceRequest(requestId);
    if (!isConfirmed) {
      EasyLoading.showError("Service request confirmation failed.");
      return; // Exit if confirmation failed
    }

    // If confirmed, proceed with creating the invoice
    await requestController.createInvoice();
    await requestController.fetchRequestStatus();

    // Stop periodic status check
    requestController.stopPeriodicStatusCheck();

    // Wait for 5 seconds before calling getInvoice
    await Future.delayed(Duration(seconds: 5));

    // After the delay, check if the invoiceId is available
    if (requestController.serviceRequest.value!.invoiceId != null &&
        requestController.serviceRequest.value!.invoiceId.isNotEmpty) {
      // Fetch the invoice after the delay
      await requestController.getInvoice();
    } else {
      EasyLoading.showError('Invoice ID is missing');
      debugPrint("Invoice ID is missing");
    }
  },
  title: "Generate Invoice",
  backgroundColor: Color(0xff1E90FF),
  textColor: AppColors.textWhite,
),

                  SizedBox(height: 16),
                  CustomButton(
                    onPress: () {
                      // Handle decline action
                    },
                    title: "Decline",
                    backgroundColor: Colors.transparent,
                    textcolor: Color(0xFF1E90FF),
                    borderColor: Color(0xFF1E90FF),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  // Map status to progress value
  double _getProgressFromStatus(String status, bool hasBasePrice) {
    switch (status) {
      case 'PENDING':
        return 0.2;
      case 'ASSIGNED':
        return 0.4 * (hasBasePrice ? 1.5 : 1.0);

      case 'CONFIRMED':
        return 0.8;
      case 'COMPLETED':
        return 1.0;
      default:
        return 0.0;
    }
  }
}
