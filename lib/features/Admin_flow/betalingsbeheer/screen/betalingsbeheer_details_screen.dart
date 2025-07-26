// lib/features/Admin_flow/betalingsbeheer/screen/betalingsbeheer_details_screen.dart
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_creation/controllers/task_creation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BetalingsbeheerDetailsScreen extends StatelessWidget {
  final String invoiceId;

  BetalingsbeheerDetailsScreen({super.key, required this.invoiceId});

  final TaskCreationController taskCreationController = Get.put(
    TaskCreationController(),
  );
  final BetalingsbeheerController betalingsbeheerController =
      Get.find<BetalingsbeheerController>();

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Building BetalingsbeheerDetailsScreen for invoiceId: $invoiceId',
    );
    // Ensure invoice details are fetched if not already loading
    if (betalingsbeheerController.invoiceDetails.value == null &&
        !betalingsbeheerController.isLoading.value) {
      betalingsbeheerController.fetchInvoiceDetails(invoiceId);
    }
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
        centerTitle: true,
        title: Text(
          "Betalingsbeheer",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(IconPath.menu, height: 18, width: 18),
          ),
        ],
      ),
      body: Obx(() {
        debugPrint(
          'Obx triggered: isLoading=${betalingsbeheerController.isLoading.value}, invoiceDetails=${betalingsbeheerController.invoiceDetails.value != null}',
        );
        final invoiceDetails = betalingsbeheerController.invoiceDetails.value;
        if (betalingsbeheerController.isLoading.value) {
          debugPrint('Showing CircularProgressIndicator');
          return const Center(child: CircularProgressIndicator());
        }
        if (invoiceDetails == null) {
          debugPrint('No invoice details available');
          return const Center(
            child: Text('Geen factuurdetails beschikbaar. Probeer opnieuw.'),
          );
        }
        debugPrint(
          'Rendering invoice details for invoiceNumber: ${invoiceDetails.data.invoiceNumber}',
        );
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffFBF6E6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 148,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xffF3E2B0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(IconPath.logo1, height: 42, width: 119),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Adres:",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                                Text(
                                  " ${invoiceDetails.data.companyInfo.city}, ${invoiceDetails.data.companyInfo.state}",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Telefoon:",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                                Text(
                                  " ${invoiceDetails.data.companyInfo.phone}",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "E-mail:",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                                Text(
                                  " ${invoiceDetails.data.companyInfo.email}",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Factuurnummer: ${invoiceDetails.data.invoiceNumber}',
                                    style: const TextStyle(
                                      color: Color(0xFF666666),
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Datum uitgegeven: ${DateFormat('dd MMMM yyyy').format(invoiceDetails.data.serviceRequestDetails.updatedAt)}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                    Text(
                                      'Vervaldatum: ${DateFormat('dd MMMM yyyy').format(invoiceDetails.data.serviceRequestDetails.finishedAt)}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Klantinformatie',
                                    style: getTextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Naam',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.clientInfo.name,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Telefoonnummer',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.clientInfo.phone,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'E-mail',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.clientInfo.email,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Stad',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.clientInfo.location,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Postcode',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails
                                            .data
                                            .clientInfo
                                            .postalCode,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Medewerkerinformatie',
                                    style: getTextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Naam',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.workerInfo.name,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Telefoonnummer',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.workerInfo.phone,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Servicedetails',
                                    style: getTextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ...invoiceDetails.data.serviceDetail.map(
                                    (service) => Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            service.taskName,
                                            style: getTextStyle(
                                              color: const Color(0xFF666666),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.28,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            '\$${service.taskPrice}',
                                            textAlign: TextAlign.center,
                                            style: getTextStyle(
                                              color: const Color(0xFF1E90FF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFFEBEBEB),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Totaal',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        '\$${invoiceDetails.data.serviceDetail.fold(0, (sum, item) => sum + item.taskPrice)}',
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Betalingsdetails',
                                    style: getTextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Banknaam',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.bankInfo.bankName,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'IBAN',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.bankInfo.iban,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'BIC/SWIFT',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        invoiceDetails.data.bankInfo.bicOrSwift,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              decoration: ShapeDecoration(
                                color: Color(0x33FF3B30).withValues(alpha: 0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Bij het doen van de betaling, gelieve het factuurnummer (gevonden bovenaan dit document) als betalingsreferentie of beschrijving op te nemen. Dit zorgt ervoor dat uw betaling correct aan uw taak en factuur wordt gekoppeld.',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: const Color(0xFFFF3B30),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  lineHeight: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Toegewezen aan',
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryBlack,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Obx(() {
                                  debugPrint(
                                    'Assignees: ${betalingsbeheerController.assignees}',
                                  );
                                  debugPrint(
                                    'AssignedTo: ${betalingsbeheerController.assignedTo.value}',
                                  );
                                  // Ensure assignees is not empty and assignedTo is valid
                                  if (betalingsbeheerController
                                      .assignees
                                      .isEmpty) {
                                    return Text(
                                      'Geen medewerkers beschikbaar',
                                      style: getTextStyle(
                                        color: AppColors.primaryBlack,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  }
                                  String dropdownValue =
                                      betalingsbeheerController
                                          .assignedTo
                                          .value;
                                  if (!betalingsbeheerController.assignees
                                      .contains(dropdownValue)) {
                                    dropdownValue =
                                        betalingsbeheerController
                                            .assignees
                                            .first;
                                    betalingsbeheerController.assignedTo.value =
                                        dropdownValue;
                                    debugPrint(
                                      'AssignedTo reset to: $dropdownValue',
                                    );
                                  }
                                  return SizedBox(
                                    width:
                                        double
                                            .infinity, // Make dropdown take full width
                                    height: 44,
                                    child: DropdownButtonFormField<String>(
                                      dropdownColor: AppColors.primaryWhite,
                                      icon: Image.asset(IconPath.arrowDown4),
                                      value: dropdownValue,
                                      items:
                                          betalingsbeheerController.assignees
                                              .map(
                                                (name) => DropdownMenuItem(
                                                  value: name,
                                                  child: Text(name),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          betalingsbeheerController
                                              .assignedTo
                                              .value = value;
                                          debugPrint(
                                            'Dropdown changed to: $value',
                                          );
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 12,
                                            ),
                                        filled: true,
                                        fillColor: AppColors.primaryWhite,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: AppColors.secondaryWhite,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: AppColors.secondaryWhite,
                                          ),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: AppColors.primaryGold,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expertise',
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryBlack,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGold,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    betalingsbeheerController.expertise.isEmpty
                                        ? 'Geen expertise beschikbaar' // Default text if expertise is empty
                                        : betalingsbeheerController.expertise,
                                    style: const TextStyle(
                                      color: AppColors.primaryGold,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Text(
                        'Taakstatus',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          dropdownColor: AppColors.primaryWhite,
                          icon: Image.asset(IconPath.arrowDown4),
                          value: betalingsbeheerController.status.value,
                          items:
                              betalingsbeheerController.statusOptions
                                  .map(
                                    (status) => DropdownMenuItem(
                                      value: status,
                                      child: Text(
                                        status,
                                        style: const TextStyle(
                                          color: AppColors.primaryGold,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              betalingsbeheerController.status.value = value;
                              debugPrint('Status changed to: $value');
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.primaryWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.secondaryWhite,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.secondaryWhite,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Taakbedrag',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Obx(
                        () => TextFormField(
                          initialValue: betalingsbeheerController.amount.value,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.primaryWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.secondaryWhite,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.secondaryWhite,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomContinueButton(
                  onTap: () {
                    debugPrint('Save changes tapped');
                    // Implement save changes logic if needed
                  },
                  title: "Wijzigingen opslaan",
                  backgroundColor: AppColors.buttonPrimary,
                  textColor: AppColors.textWhite,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
