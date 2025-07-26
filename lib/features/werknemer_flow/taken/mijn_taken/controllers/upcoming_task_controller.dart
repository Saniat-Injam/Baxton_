// ignore_for_file: unnecessary_to_list_in_spreads

import 'dart:io';

import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/task_details_model.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/upcoming_task_model.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/repository/upcoming_task_repository.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class UpcomingTaskController extends GetxController {
  final UpcomingTaskRepository upcomingTaskRepository =
      UpcomingTaskRepository();
  var upcomingTasks = <UpcomingTaskModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<TaskDetailsModel?> taskDetailsModel = Rx<TaskDetailsModel?>(null);
  var setPriceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchNonSetPriceTasks();
  }

  Future<void> fetchNonSetPriceTasks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      EasyLoading.show(status: 'Loading......');
      final upcomingList = await upcomingTaskRepository.fetchUpcommingTask();
      upcomingTasks.assignAll(upcomingList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> fetchTaskDetails(String id) async {
    try {
      isLoading.value = false;
      errorMessage.value = '';
      EasyLoading.show(status: 'Loading.....');
      final details = await upcomingTaskRepository.getTaskDetails(id);
      taskDetailsModel.value = details;
    } catch (e) {
      debugPrint('Error fetching task details: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  /// Generate PDF from current task details
  Future<void> generatePdf() async {
    await _requestStoragePermission();

    final data = taskDetailsModel.value;
    if (data == null) {
      EasyLoading.showError('Geen gegevens om te downloaden');
      return;
    }

    // Build PDF
    final pdf = pw.Document();

    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Roboto/Roboto-Regular.ttf'),
    );
    final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Roboto/Roboto-Bold.ttf'),
    );

    final titleStyle = pw.TextStyle(font: boldFont, fontSize: 22);
    final headingStyle = pw.TextStyle(font: boldFont, fontSize: 16);
    final bodyStyle = pw.TextStyle(font: regularFont, fontSize: 12);

    final dateStr = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final timeStr = DateFormat('HH:mm').format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Text('Taak Rapport', style: titleStyle),
            pw.SizedBox(height: 20),

            pw.Text('Taak Informatie', style: headingStyle),
            pw.SizedBox(height: 8),
            pw.Text('Naam: ${data.name ?? "Onbekend"}', style: bodyStyle),
            pw.Text(
              'Beschrijving: ${data.problemDescription ?? "Geen"}',
              style: bodyStyle,
            ),
            pw.Text('Locatie: ${data.city ?? "Geen"}', style: bodyStyle),
            pw.SizedBox(height: 16),

            pw.Text('Klanteninformatie', style: headingStyle),
            pw.SizedBox(height: 8),
            pw.Text(
              'Klant: ${data.clientProfile?.userName ?? "Geen"}',
              style: bodyStyle,
            ),
            pw.Text(
              'Telefoon: ${data.phoneNumber ?? "Geen"}',
              style: bodyStyle,
            ),
            pw.Text('Datum: $dateStr', style: bodyStyle),
            pw.Text('Tijd: $timeStr', style: bodyStyle),
            pw.SizedBox(height: 16),

            pw.Text('Checklist', style: headingStyle),
            pw.SizedBox(height: 8),
            ...(data.tasks ?? []).map<pw.Widget>((item) {
              final done = item.done == true ? '✅' : '❌';
              return pw.Text('${item.name}: $done', style: bodyStyle);
            }).toList(),

            pw.SizedBox(height: 16),
            pw.Text('Opmerking', style: headingStyle),
            pw.SizedBox(height: 8),
            pw.Text(data.note ?? 'Geen opmerking', style: bodyStyle),
          ];
        },
      ),
    );

    try {
      final bytes = await pdf.save();
      final fileName =
          'Task_Report_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf';

      try {
        await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          mimeType: MimeType.pdf,
        );
        EasyLoading.showSuccess('PDF opgeslagen');
      } catch (e) {
        // Fallback if FileSaver fails
        final dir = await getExternalStorageDirectory();
        if (dir == null) {
          EasyLoading.showError('Kon opslag niet openen');
          return;
        }
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes);
        EasyLoading.showSuccess('PDF opgeslagen in ${dir.path}');
      }
    } catch (e) {
      EasyLoading.showError('Fout bij genereren PDF: $e');
    }
  } // Future<void> submitPrice(String id) async {
  //   debugPrint('🟢 [submitPrice] Called with id: $id');

  //   try {
  //     isLoading.value = true;
  //     EasyLoading.show(status: 'Prijs wordt ingesteld...');

  //     // 🔹 Parse the price from the text field
  //     final double price = double.tryParse(setPriceController.text.trim()) ?? 0;
  //     debugPrint('🔹 [submitPrice] Parsed price: $price');

  //     if (price <= 0) {
  //       EasyLoading.dismiss();
  //       debugPrint('🔴 [submitPrice] Invalid price entered');
  //       Get.snackbar('Ongeldige prijs', 'Voer een geldige prijs in.');
  //       return;
  //     }

  //     debugPrint('🟡 [submitPrice] Sending API request to set price...');
  //     // ✅ Call the repo method
  //     final updatedModel = await upcomingTaskRepository.setPrice(id, price);

  //     debugPrint('✅ [submitPrice] API response received.');
  //     debugPrint('📦 [submitPrice] Updated model: ${updatedModel.toJson()}');

  //     // ✅ Update your observable with the new model
  //     taskDetailsModel.value = updatedModel;
  //     debugPrint('✅ [submitPrice] taskDetailsModel updated in controller.');

  //     EasyLoading.dismiss();

  //     // ✅ Show success
  //     Get.snackbar(
  //       'Succes',
  //       'Prijs succesvol ingesteld!',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     debugPrint('✅ [submitPrice] Snackbar displayed for success.');

  //     // ✅ Navigate to another screen (replace with your desired screen)
  //     debugPrint('➡️ [submitPrice] Navigating to next screen...');
  //     Get.to(() => EmployeeSelectionView()); // Replace with your actual screen
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     debugPrint('❌ [submitPrice] Error occurred: $e');
  //     Get.snackbar('Fout', e.toString(), snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading.value = false;
  //     debugPrint('🔵 [submitPrice] Loading finished.');
  //   }
  // }
}
