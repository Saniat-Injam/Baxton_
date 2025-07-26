// lib/features/Admin_flow/betalingsbeheer/widgets/invoice_card.dart
import 'package:flutter/material.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/model/invoice_model.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/controller/betalingsbeheer_controller.dart';
import 'package:baxton/features/Admin_flow/betalingsbeheer/screen/betalingsbeheer_details_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback? onDetailsPressed;

  const InvoiceCard({super.key, required this.invoice, this.onDetailsPressed});

  @override
  Widget build(BuildContext context) {
    final BetalingsbeheerController controller =
        Get.find<BetalingsbeheerController>();
    String formattedDate = 'Unknown';
    try {
      final dateTime = DateTime.parse(invoice.date);
      formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      debugPrint('Error parsing date: ${invoice.date}, error: $e');
    }
    return Container(
      width: double.infinity,
      height: 182,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Stack(
        children: [
          // Top section with invoice info
          Positioned(
            left: 8,
            top: 8,
            child: SizedBox(
              width: 345,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 95,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Factuurnummer',
                          style: getTextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            lineHeight: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          invoice.invoiceNumber,
                          style: getTextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            lineHeight: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Klantnaam',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            lineHeight: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          invoice.customerName,
                          style: getTextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            lineHeight: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Taaknaam',
                          style: getTextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            lineHeight: 9,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          invoice.taskName,
                          style: getTextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            lineHeight: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Middle section with payment info
          Positioned(
            left: 8,
            top: 63,
            child: SizedBox(
              width: 345,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 97,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Taakbedrag',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            lineHeight: 7,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 97,
                          child: Text(
                            invoice.amount,
                            style: getTextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              lineHeight: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Betalingsstatus',
                        style: getTextStyle(
                          color: const Color(0xFF666666),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          lineHeight: 7,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildStatusIndicator(invoice.status),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Datum',
                          style: getTextStyle(
                            color: const Color(0xFF666666),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            lineHeight: 7,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: getTextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 14,
                            lineHeight: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Details button
          Positioned(
            left: 10,
            top: 130,
            child: InkWell(
              onTap: () {
                if (invoice.id != null) {
                  controller.fetchInvoiceDetails(invoice.id!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BetalingsbeheerDetailsScreen(
                            invoiceId: invoice.id!,
                          ),
                    ),
                  );
                } else {
                  debugPrint('Invoice ID is null');
                  EasyLoading.showError('Invoice ID is not available');
                }
              },
              borderRadius: BorderRadius.circular(62),
              child: Container(
                width: 345,
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: ShapeDecoration(
                  color: Color(0xFF1E90FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(62),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Details',
                      style: getTextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(PaymentStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case PaymentStatus.pending:
        backgroundColor = const Color(0xFFFFE0C4);
        textColor = const Color(0xFFFF5B00);
        text = 'In afwachting';
        break;
      case PaymentStatus.confirmed:
        backgroundColor = const Color(0x1934C759);
        textColor = const Color(0xFF34C759);
        text = 'Bevestigd';
        break;
      case PaymentStatus.overdue:
        backgroundColor = const Color(0x19FF3B30);
        textColor = const Color(0xFFFF3B30);
        text = 'Achterstallig';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          height: 1.50,
        ),
      ),
    );
  }
}
