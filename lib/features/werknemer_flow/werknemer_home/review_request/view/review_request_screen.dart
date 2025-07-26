import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/controller/review_request_controller.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/widget/customer_worker_info_card.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/widget/info_card_row.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/review_request/widget/service_payment_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewRequestScreen extends StatelessWidget {
  final ReviewRequestController reviewRequestController = Get.put(
    ReviewRequestController(),
  );

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
          'Beoordelingsverzoek',
          style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        final data = reviewRequestController.reviewData.value;
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            color: AppColors.secondaryGold,
            child: Column(
              children: [
                // Company Info Header
                Container(
                  width: double.infinity,
                  height: 148,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xffF3E2B0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(ImagePath.baxton, width: 118.63, height: 42),
                      SizedBox(height: 12),
                      richText("Address:", " 123 Property Lane, Cityville, NL"),
                      SizedBox(height: 12),
                      richText("Phone:", " +31 123 456 789"),
                      SizedBox(height: 12),
                      richText("E-mail:", " info@baxton.nl"),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // labelBox([
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // Left side: Invoice Number (label above, value below)
                //       Expanded(
                //         flex: 1,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Invoice Number:",
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(height: 4),
                //             Text(data.invoiceNumber),
                //           ],
                //         ),
                //       ),
                //       // Right side: Date Issued and Due Date (already in column format)
                //       Expanded(
                //         flex: 1,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             Text(
                //               "Date Issued:",
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(height: 4),
                //             Text(data.issuedDate),
                //             SizedBox(height: 8),
                //             Text(
                //               "Due Date:",
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(height: 4),
                //             Text(data.dueDate),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ]),

                // Invoice Number, Date Issued, and Due Date
                labelBox([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Left side: Invoice Number (label above, value below)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Invoice Number:",
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryBlack,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(data.invoiceNumber),
                            ],
                          ),
                        ),
                        // Right side: Date Issued and Due Date (each in a separate row)
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Date Issued: ",
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryBlack,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(data.issuedDate),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Due Date: ",
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryBlack,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(data.dueDate),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),

                // Customer/Client Info
                CustomerWorkerInfoCard(
                  height: 225,
                  title: "Klantinformatie",
                  valueColor: AppColors.primaryBlack,
                  children: [
                    InfoCardRow(label: "Naam", value: data.clientName),
                    SizedBox(height: 16),
                    InfoCardRow(
                      label: "Telefoonnummer",
                      value: data.clientPhone,
                    ),
                    SizedBox(height: 16),
                    InfoCardRow(label: "E-mail", value: data.clientEmail),
                    SizedBox(height: 16),
                    InfoCardRow(label: "Stad", value: data.clientCity),
                    SizedBox(height: 16),
                    InfoCardRow(label: "Postcode", value: data.clientPostcode),
                  ],
                ),

                // Worker/Employee Info
                CustomerWorkerInfoCard(
                  height: 114,
                  title: "Werknemersinformatie",
                  valueColor: AppColors.primaryBlack,
                  children: [
                    InfoCardRow(label: "Naam", value: data.employeeName),
                    SizedBox(height: 16),
                    InfoCardRow(
                      label: "Telefoonnummer",
                      value: data.employeePhone,
                    ),
                  ],
                ),

                ServicePaymentInfoCard(
                  title: "Servicedetails",
                  valueColor: AppColors.primaryBlue,
                  children: [
                    ...data.serviceDetails.entries.map(
                      (e) => Column(
                        children: [
                          InfoCardRow(label: e.key, value: "\$${e.value}"),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    InfoCardRow(label: "Totaal", value: "\$${data.total}"),
                  ],
                ),

                // Payment Details
                ServicePaymentInfoCard(
                  title: "Betalingsdetails",
                  valueColor: AppColors.primaryBlue,
                  children: [
                    InfoCardRow(label: "Banknaam", value: data.bankName),
                    SizedBox(height: 16),
                    InfoCardRow(label: "IBAN", value: data.iban),
                    SizedBox(height: 16),
                    InfoCardRow(label: "BIC/SWIFT", value: data.bic),
                  ],
                ),

                SizedBox(height: 16),

                // Payment Instruction
                Container(
                  height: 172,
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryRed.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Bij het doen van de betaling, gelieve het ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryRed,
                        ),
                      ),
                      Text(
                        "factuurnummer (gevonden bovenaan dit ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryRed,
                        ),
                      ),
                      Text(
                        "document) als betalingsreferentie of ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryRed,
                        ),
                      ),
                      Text(
                        "beschrijving op te nemen. Dit zorgt ervoor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryRed,
                        ),
                      ),
                      Text(
                        "dat uw betaling correct aan uw taak en ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryRed,
                        ),
                      ),
                      Text(
                        "factuur wordt gekoppeld.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryRed,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 34),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget labelBox(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget richText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryGold,
              ),
            ),
            WidgetSpan(child: SizedBox(width: 4)),
            TextSpan(
              text: value,
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff5B4400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
