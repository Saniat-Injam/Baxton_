import 'dart:convert';
import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/signature_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/details/controller/task_execution_controller.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/task_execution_screen_with_client_review.dart';
import 'package:baxton/features/werknemer_flow/taken/details/view/widget/checklist_item_widget.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/widget/client_info_card.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/views/widget/task_info_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskExecutionScreen extends StatelessWidget {
  final SetPriceTaskModel setPriceTask;

  final TextEditingController _textController = TextEditingController();
  final TaskExecutionController taskExecutionController = Get.put(
    TaskExecutionController(),
  );
  final ClientInfoController clientInfoController =
      Get.find<ClientInfoController>();
  final SharedSignatureController controller =
      Get.find<SharedSignatureController>();

  late final DateTime dateTime;
  late final String dateStr;
  late final String timeStr;

  TaskExecutionScreen({super.key, required this.setPriceTask}) {
    dateTime =
        clientInfoController.clientInfo.isNotEmpty
            ? clientInfoController.clientInfo.first.dateTime
            : DateTime.now();

    dateStr = DateFormat('dd/MM/yyyy').format(dateTime);
    timeStr = DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Taakdetails",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TaskInfoCard(setPriceInfoScreentask: setPriceTask),
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
            // Price Box
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondaryGold,
                border: Border.all(color: AppColors.secondaryWhite),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                //'\$${controller.workPrice.value}',
                "\$5000",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryGold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Show list of added work items
            Obx(
              () => Column(
                children:
                    taskExecutionController.workItems.map((item) {
                      return Container(
                        width: double.infinity,
                        color: AppColors.secondaryGold,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryBlack,
                              ),
                            ),
                            Text(
                              '\$${item['price']}',
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => showDialogWork(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryBlue,
                foregroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                side: BorderSide(color: AppColors.secondaryBlue),
              ),
              child: Text(
                'Toevoegen   +',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Progress Bar
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Jouw voortgang',
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey4,
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => Column(
                children: [
                  Text(
                    '${(taskExecutionController.progress * 100).toStringAsFixed(0)}% Voltooid',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryCyan,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 296,
                    child: LinearProgressIndicator(
                      value: taskExecutionController.progress,
                      borderRadius: BorderRadius.circular(10),
                      minHeight: 12,
                      color: AppColors.progressBarBlue,
                      backgroundColor: AppColors.progressbarGrey,
                      stopIndicatorColor: AppColors.primaryGold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Checklist button label
            Text(
              "TaakChecklist",
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 20),

            // Checklist Button
            ElevatedButton(
              onPressed: () => showDialogChecklist(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(51),
                ),
                side: BorderSide(color: AppColors.secondaryBlue),
              ),
              child: const Text(
                'Checklist +',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryWhite,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Obx(
              () => Column(
                children:
                    taskExecutionController.checkList
                        .asMap()
                        .entries
                        .map(
                          (e) => ChecklistItemWidget(
                            item: e.value,
                            onChanged:
                                (val) => taskExecutionController.toggleCheck(
                                  e.key,
                                  val,
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 40),

            // Camera
            // Upload photos BEFORE start your work
            Text(
              "Upload foto's voordat je aan je werk begint",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: taskExecutionController.captureImageBefore,
                  // Camera container
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlue,
                      border: Border.all(color: AppColors.primaryBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.asset(IconPath.camera),
                        const SizedBox(height: 12),
                        Text(
                          "Voor Photo",
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() {
                  if (taskExecutionController.uploadedPhotos.isEmpty) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(IconPath.photoUpload),
                    );
                  }

                  // If grid view is enabled
                  if (taskExecutionController.showAllPhotos.value) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: taskExecutionController.uploadedPhotos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.9,
                          ),
                      itemBuilder: (_, index) {
                        final item =
                            taskExecutionController.uploadedPhotos[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primaryGrey,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.file(
                                    File(item['path']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  item['description'] ?? '',
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  // Show only the latest image if grid view is off
                  final latest = taskExecutionController.uploadedPhotos.last;
                  return Column(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.primaryGrey,
                        ),
                        child: Image.file(
                          File(latest['path']!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        latest['description'] ?? '',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }),

                TextButton(
                  onPressed: taskExecutionController.toggleShowAllPhotos,
                  child: Text(
                    "Bekijk alle foto's",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryGold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Upload photos AFTER completed your work
            Text(
              "Upload foto's nadat je je werk hebt voltooid",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: taskExecutionController.captureImageAfter,
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlue,
                      border: Border.all(color: AppColors.primaryBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.asset(IconPath.camera),
                        const SizedBox(height: 4),
                        Text(
                          "Na foto",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() {
                  if (taskExecutionController.uploadedPhotosAfter.isEmpty) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(IconPath.photoUpload),
                    );
                  }

                  if (taskExecutionController.showAllPhotosAfter.value) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          taskExecutionController.uploadedPhotosAfter.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.9,
                          ),
                      itemBuilder: (_, index) {
                        final item =
                            taskExecutionController.uploadedPhotosAfter[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primaryGrey,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.file(
                                    File(item['path']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  item['description'] ?? '',
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  final latest =
                      taskExecutionController.uploadedPhotosAfter.last;
                  return Column(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.primaryGrey,
                        ),
                        child: Image.file(
                          File(latest['path']!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        latest['description'] ?? '',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }),
                TextButton(
                  onPressed: taskExecutionController.toggleShowAllPhotosAfter,
                  child: Text(
                    "Bekijk alle foto's",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryGold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            Text(
              "Handtekening van de klant",
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 20),

            // Signature Request Button
            SizedBox(
              height: 44,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: AppColors.secondaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(IconPath.pen),
                    //SizedBox(width: 4),
                    Text(
                      "Vraag om de handtekening van de klant",
                      style: getTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Obx(() {
                if (controller.signatureBase64.value.isEmpty) {
                  return const Text("No signature available yet.");
                } else {
                  final image = base64Decode(controller.signatureBase64.value);
                  return Column(
                    children: [
                      const Text("Received Signature:"),
                      const SizedBox(height: 10),
                      Image.memory(image, height: 200),
                    ],
                  );
                }
              }),
            ),

            const SizedBox(height: 30),
            Text(
              "Note",
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 3,
              controller: _textController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      side: BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Taak Pauzeren',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => TaskExecutionScreenWithClientReview(
                          setPriceTask: setPriceTask,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      backgroundColor: AppColors.primaryBlue,
                      side: const BorderSide(
                        color: AppColors.formFieldBorderColor,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62),
                      ),
                    ),

                    child: Text(
                      'Taak voltooien',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Work Dialog Function
  void showDialogWork(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.primaryWhite,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prijs instellen',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryBlack,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Dient',

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      child: TextFormField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          hintText: '0.00',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.formFieldBorderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(51),
                    ),
                  ),
                  onPressed: () {
                    taskExecutionController.addWorkItem(
                      nameController.text,
                      priceController.text,
                    );
                    Get.back();
                  },
                  child: Text(
                    'Wijzigingen opslaan',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Checklist Dialog Function
  void showDialogChecklist(BuildContext context) {
    final taskController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.primaryWhite,
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: MediaQuery.of(Get.context!).size.width, // Full width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Taak',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  maxLines: 3,
                  controller: taskController,
                  decoration: const InputDecoration(
                    //hintText: 'Checklist item',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.secondaryWhite),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      taskExecutionController.addCheckItem(taskController.text);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(51),
                      ),
                    ),
                    child: Text(
                      'Toevoegen',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
