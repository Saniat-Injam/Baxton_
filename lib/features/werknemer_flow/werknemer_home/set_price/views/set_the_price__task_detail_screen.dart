import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';

import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/set_price_detail_screen_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/widget/client_info_card.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/widget/task_info_section.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SetThePriceTaskDetailScreen extends StatelessWidget {
  final SetPriceTaskModel setPriceTasks;
  SetThePriceTaskDetailScreen({super.key, required this.setPriceTasks});

  // final ClientInfoController clientInfoController = Get.put(
  //   ClientInfoController(),
  // );
  final ClientInfoController clientInfoController =
      Get.find<ClientInfoController>();

  @override
  Widget build(BuildContext context) {
    final TaskDetailController taskDetailController = Get.put(
      TaskDetailController(setPriceTasks),
    );
    final dateStr = DateFormat('dd/MM/yyyy').format(setPriceTasks.dateTime);
    final timeStr = DateFormat('HH:mm').format(setPriceTasks.dateTime);

    return Scaffold(
      backgroundColor: AppColors.containerColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(IconPath.arrowBack),
            ],
          ),
        ),
        title: Text(
          'Taak Details',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        backgroundColor: AppColors.containerColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Task Info Section
            TaskInfoCard(setPriceInfoScreentask: setPriceTasks),
            const SizedBox(height: 16),

            // Client Information
            Container(
              width: double.infinity,
              height: 231,
              //padding: const EdgeInsets.all(16),
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.secondaryWhite),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Klanteninformatie',
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ClientInfoCard(
                    label: 'Naam',
                    value:
                        clientInfoController.clientInfo.isNotEmpty
                            ? clientInfoController
                                    .clientInfo
                                    .first
                                    .customerName ??
                                ""
                            : "",
                  ),
                  SizedBox(height: 12),
                  ClientInfoCard(
                    label: 'Locatie',
                    value:
                        clientInfoController.clientInfo.isNotEmpty
                            ? clientInfoController
                                    .clientInfo
                                    .first
                                    .customerAddress ??
                                ""
                            : "",
                  ),
                  SizedBox(height: 12),
                  ClientInfoCard(
                    label: 'Telefoonnummer',
                    value:
                        clientInfoController.clientInfo.isNotEmpty
                            ? clientInfoController
                                    .clientInfo
                                    .first
                                    .customerPhone ??
                                ""
                            : "",
                  ),
                  SizedBox(height: 12),
                  ClientInfoCard(label: 'Gewenste datum', value: dateStr),
                  SizedBox(height: 12),
                  ClientInfoCard(label: 'Gewenste tijd', value: '$timeStr uur'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Prepay Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryWhite),
                color: AppColors.secondaryGold,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Prepay',
                  style: TextStyle(
                    color: AppColors.primaryGold,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Price Input Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Stel een Prijs In',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryBlack,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => Column(
                children: [
                  // Price Input Field
                  TextField(
                    onChanged: (val) => taskDetailController.price.value = val,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //hintText: 'Voer prijs in',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // onPressed:
                      //     taskDetailController.price.isEmpty
                      //         ? null
                      //         : () {
                      //           taskDetailController.submitPrice();
                      //         },
                      onPressed: () {
                        //Get.to(() => TaskDetailsScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(62),
                        ),
                        foregroundColor:
                            taskDetailController.price.isEmpty
                                ? AppColors.primaryWhite
                                : AppColors.primaryWhite,
                        side: BorderSide(
                          color:
                              taskDetailController.price.isEmpty
                                  ? AppColors.primaryWhite
                                  : AppColors.primaryWhite,
                          width: 1.5,
                        ),
                      ),
                      child: const Text(
                        'Indienen',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
