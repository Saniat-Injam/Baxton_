// ignore_for_file: unused_element

import 'dart:io';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

class DownloadController extends GetxController {
  // Download functionality
  Future<void> downloadReport(dynamic data) async {
    try {
      _showLoadingDialog();

      final pdf = await _generatePDF(data);
      final pdfBytes = await pdf.save();

      final fileName =
          'TaskReport_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/$fileName');
      await file.writeAsBytes(pdfBytes);

      Get.back(); // Close loading dialog

      _showSuccessDialog(fileName, directory.path, file.path);
    } catch (e) {
      Get.back();
      _showErrorSnackbar('Download failed: $e');
    }
  }

  Future<void> shareReport(dynamic data) async {
    try {
      _showLoadingDialog();

      final pdf = await _generatePDF(data);
      final pdfBytes = await pdf.save();

      final fileName =
          'TaskReport_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(pdfBytes);

      Get.back(); // Close loading dialog

      // Use share_plus package for proper sharing
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Task Report - ${data.name ?? "Report"}',
        subject: 'Task Report',
      );
    } catch (e) {
      Get.back();
      _showErrorSnackbar('Share failed: $e');
      debugPrint(e.toString());
    }
  }

  // Professional loading dialog
  void _showLoadingDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryBlue,
                ),
                strokeWidth: 3,
              ),
              const SizedBox(height: 20),
              Text(
                'Rapport genereren...',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlack,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Even geduld alstublieft',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryGrey,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _showSuccessDialog(
    String fileName,
    String directoryPath,
    String filePath,
  ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: Colors.green, size: 35),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                'Download Voltooid',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlack,
                ),
              ),
              const SizedBox(height: 12),

              // Message
              Text(
                'Uw rapport is succesvol opgeslagen!',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // File info container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffEBEBEB)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.description,
                      size: 16,
                      color: AppColors.primaryBlue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        fileName,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Sluiten',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                        await _openPDFFile(filePath);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Openen',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Professional error snackbar
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Fout',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white),
      duration: const Duration(seconds: 4),
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
    );
  }

  // Open PDF file
  Future<void> _openPDFFile(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);

      if (result.type != ResultType.done) {
        Get.snackbar(
          'Info',
          'Installeer een PDF-viewer app om dit bestand te openen.',
          backgroundColor: AppColors.primaryGold,
          colorText: Colors.white,
          icon: Icon(Icons.info, color: Colors.white),
          duration: const Duration(seconds: 3),
          borderRadius: 8,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      _showErrorSnackbar('Kon bestand niet openen: $e');
    }
  }

  // Open file with system
  Future<void> _openFileWithSystem(String filePath) async {
    try {
      if (Platform.isAndroid) {
        const platform = MethodChannel('file_operations');
        await platform.invokeMethod('openFile', {'path': filePath});
      } else {
        await Process.run('open', [filePath]);
      }
    } catch (e) {
      _showErrorSnackbar('Deel functie niet beschikbaar: $e');
    }
  }

  // Generate PDF method (same as before but moved to controller)
  Future<pw.Document> _generatePDF(dynamic data) async {
    final pdf = pw.Document();

    // Load images as bytes for PDF
    Uint8List? beforePhotoBytes;
    Uint8List? afterPhotoBytes;
    Uint8List? signatureBytes;

    try {
      // Get first before photo if available
      if (data.beforePhoto != null && data.beforePhoto.isNotEmpty) {
        final response = await http.get(Uri.parse(data.beforePhoto[0].url));
        if (response.statusCode == 200) {
          beforePhotoBytes = response.bodyBytes;
        }
      }

      // Get first after photo if available
      if (data.afterPhoto != null && data.afterPhoto.isNotEmpty) {
        final response = await http.get(Uri.parse(data.afterPhoto[0].url));
        if (response.statusCode == 200) {
          afterPhotoBytes = response.bodyBytes;
        }
      }

      // Get signature if available
      if (data.signature?.url != null && data.signature.url.isNotEmpty) {
        final response = await http.get(Uri.parse(data.signature.url));
        if (response.statusCode == 200) {
          signatureBytes = response.bodyBytes;
        }
      }
    } catch (e) {
      debugPrint('Error loading images: $e');
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Text(
                'TASK REPORT',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 20),

            // Task Information
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey400),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'TASK INFORMATION',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text('Task Name: ${data.name ?? 'No Task Name'}'),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Description: ${data.problemDescription ?? 'No Description'}',
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text('City: ${data.city ?? 'No data'}'),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Date: ${data.preferredDate?.split('T')[0] ?? 'No data'}',
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Time: ${data.preferredTime != null ? data.preferredTime!.split('T')[1].substring(0, 5) : 'No data'}',
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text('Task Type: ${data.taskTypeName ?? 'No data'}'),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Price: \$${data.basePrice?.toStringAsFixed(2) ?? '0.00'}',
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 15),

            // Client Information
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey400),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'CLIENT INFORMATION',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text('Name: ${data.clientProfile?.userName ?? 'No data'}'),
                  pw.SizedBox(height: 5),
                  pw.Text('Phone: ${data.phoneNumber ?? 'No data'}'),
                ],
              ),
            ),

            pw.SizedBox(height: 15),

            // Checklist
            if (data.tasks != null && data.tasks.isNotEmpty) ...[
              pw.Text(
                'COMPLETED TASKS',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children:
                      data.tasks
                          .where((item) => item.done == true)
                          .map<pw.Widget>(
                            (item) => pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 2,
                              ),
                              child: pw.Text('- ${item.name ?? 'Task item'}'),
                            ),
                          )
                          .toList(),
                ),
              ),
              pw.SizedBox(height: 15),
            ],

            // Before Photo
            if (beforePhotoBytes != null) ...[
              pw.Text(
                'BEFORE PHOTO',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                height: 200,
                width: double.infinity,
                child: pw.Image(
                  pw.MemoryImage(beforePhotoBytes),
                  fit: pw.BoxFit.contain,
                ),
              ),
              pw.SizedBox(height: 15),
            ],

            // After Photo
            if (afterPhotoBytes != null) ...[
              pw.Text(
                'AFTER PHOTO',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                height: 200,
                width: double.infinity,
                child: pw.Image(
                  pw.MemoryImage(afterPhotoBytes),
                  fit: pw.BoxFit.contain,
                ),
              ),
              pw.SizedBox(height: 15),
            ],

            // Notes
            if (data.note != null && data.note.isNotEmpty) ...[
              pw.Text(
                'NOTES',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Text(data.note),
              ),
              pw.SizedBox(height: 15),
            ],

            // Rating
            if (data.rating != null) ...[
              pw.Text(
                'CLIENT RATING',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Rating: ${data.rating}/5 stars'),
                    if (data.review != null && data.review.isNotEmpty) ...[
                      pw.SizedBox(height: 5),
                      pw.Text('Review: ${data.review}'),
                    ],
                  ],
                ),
              ),
              pw.SizedBox(height: 15),
            ],

            // Signature
            if (signatureBytes != null) ...[
              pw.Text(
                'CLIENT SIGNATURE',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                height: 100,
                width: double.infinity,
                child: pw.Image(
                  pw.MemoryImage(signatureBytes),
                  fit: pw.BoxFit.contain,
                ),
              ),
              pw.SizedBox(height: 15),
            ],

            // Footer
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Text(
              'Report generated on ${DateTime.now().toString().split('.')[0]}',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ];
        },
      ),
    );

    return pdf;
  }
}
