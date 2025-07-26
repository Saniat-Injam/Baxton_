// import 'dart:io';
// import 'package:baxton/features/werknemer_flow/taken/details/model/task_checklist_item.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class TaskExecutionController extends GetxController {
//   final capturedImagePathAfter = ''.obs;
//   final capturedImagePathBefore = ''.obs;

//   var workItems = <Map<String, String>>[].obs;
//   var checkList = <TaskCheckItem>[].obs;

//   var uploadedPhotos = <Map<String, String>>[].obs;
//   var showAllPhotos = false.obs;

//   var uploadedPhotosAfter = <Map<String, String>>[].obs;
//   var showAllPhotosAfter = false.obs;

//   double get progress =>
//       checkList.isEmpty
//           ? 0
//           : checkList.where((e) => e.isChecked).length / checkList.length;

//   void addWorkItem(String name, String price) {
//     workItems.add({'name': name, 'price': price});
//   }

//   void addCheckItem(String title) {
//     checkList.add(TaskCheckItem(title: title));
//   }

//   void toggleCheck(int index, bool? value) {
//     checkList[index].isChecked = value ?? false;
//     checkList.refresh();
//   }

//   void toggleShowAllPhotos() {
//     showAllPhotos.value = !showAllPhotos.value;
//   }

//   void toggleShowAllPhotosAfter() {
//     showAllPhotosAfter.value = !showAllPhotosAfter.value;
//   }

//   Future<void> captureImageBefore() async {
//     final capturedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     if (capturedFile != null) {
//       _showImageDialog(capturedFile.path, isAfter: false);
//     }
//   }

//   Future<void> captureImageAfter() async {
//     final capturedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     if (capturedFile != null) {
//       _showImageDialog(capturedFile.path, isAfter: true);
//     }
//   }

//   void _showImageDialog(String imagePath, {required bool isAfter}) {
//     final TextEditingController descriptionController = TextEditingController();

//     Get.dialog(
//       Dialog(
//         insetPadding: const EdgeInsets.all(12),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Foto Informatie',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.file(
//                     File(imagePath),
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: descriptionController,
//                 style: const TextStyle(fontSize: 12),

//                 decoration: const InputDecoration(
//                   hintText: 'Beschrijving',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 16,
//                     horizontal: 16,
//                   ),
//                   isDense: true,
//                 ),
//               ),
//               SizedBox(height: 16),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     final item = {
//                       'path': imagePath,
//                       'description': descriptionController.text,
//                     };
//                     if (isAfter) {
//                       uploadedPhotosAfter.add(item);
//                     } else {
//                       uploadedPhotos.add(item);
//                     }
//                     Get.back();
//                   },
//                   child: const Text('Toevoegen'),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () => Get.back(),
//                     child: const Text('Annuleren'),
//                   ),
//                   const SizedBox(width: 8),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Shakil vai
// import 'dart:io';
// import 'package:baxton/features/werknemer_flow/taken/details/model/task_checklist_item.dart';
// import 'package:get/get.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:file_saver/file_saver.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class TaskExecutionController extends GetxController {
//   final capturedImagePathAfter = ''.obs;
//   final capturedImagePathBefore = ''.obs;

//   var workItems = <Map<String, String>>[].obs;
//   var checkList = <TaskCheckItem>[].obs;

//   var uploadedPhotos = <Map<String, String>>[].obs;
//   var showAllPhotos = false.obs;

//   var uploadedPhotosAfter = <Map<String, String>>[].obs;
//   var showAllPhotosAfter = false.obs;

//   double get progress =>
//       checkList.isEmpty
//           ? 0
//           : checkList.where((e) => e.isChecked).length / checkList.length;

//   void addWorkItem(String name, String price) {
//     workItems.add({'name': name, 'price': price});
//   }

//   void addCheckItem(String title) {
//     checkList.add(TaskCheckItem(title: title));
//   }

//   void toggleCheck(int index, bool? value) {
//     checkList[index].isChecked = value ?? false;
//     checkList.refresh();
//   }

//   void toggleShowAllPhotos() {
//     showAllPhotos.value = !showAllPhotos.value;
//   }

//   void toggleShowAllPhotosAfter() {
//     showAllPhotosAfter.value = !showAllPhotosAfter.value;
//   }

//   Future<void> captureImageBefore() async {
//     final capturedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     if (capturedFile != null) {
//       _showImageDialog(capturedFile.path, isAfter: false);
//     }
//   }

//   Future<void> captureImageAfter() async {
//     final capturedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     if (capturedFile != null) {
//       _showImageDialog(capturedFile.path, isAfter: true);
//     }
//   }

//   void _showImageDialog(String imagePath, {required bool isAfter}) {
//     final TextEditingController descriptionController = TextEditingController();

//     Get.dialog(
//       Dialog(
//         insetPadding: const EdgeInsets.all(12),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Foto Informatie',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.file(
//                     File(imagePath),
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: descriptionController,
//                 style: const TextStyle(fontSize: 12),
//                 decoration: const InputDecoration(
//                   hintText: 'Beschrijving',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 16,
//                     horizontal: 16,
//                   ),
//                   isDense: true,
//                 ),
//               ),
//               SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     final item = {
//                       'path': imagePath,
//                       'description': descriptionController.text,
//                     };
//                     if (isAfter) {
//                       uploadedPhotosAfter.add(item);
//                     } else {
//                       uploadedPhotos.add(item);
//                     }
//                     Get.back();
//                   },
//                   child: const Text('Toevoegen'),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () => Get.back(),
//                     child: const Text('Annuleren'),
//                   ),
//                   const SizedBox(width: 8),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> downloadReport(SetPriceTaskModel setPriceTask) async {
//     final clientInfoController = Get.find<ClientInfoController>();
//     final dateTime =
//         clientInfoController.clientInfo.isNotEmpty
//             ? clientInfoController.clientInfo.first.dateTime
//             : DateTime.now();
//     final dateStr = DateFormat('dd/MM/yyyy').format(dateTime);
//     final timeStr = DateFormat('HH:mm').format(dateTime);

//     // Try to request permissions for Android
//     bool permissionsGranted = true;
//     if (Platform.isAndroid) {
//       try {
//         final storageStatus = await Permission.storage.request();
//         permissionsGranted = storageStatus.isGranted;
//       } catch (e) {
//         Get.snackbar(
//           'Fout',
//           'Kan toestemmingen niet aanvragen: $e. Ga verder zonder toestemmingen.',
//         );
//         permissionsGranted = false;
//       }
//       if (!permissionsGranted) {
//         Get.snackbar(
//           'Waarschuwing',
//           'Opslagtoestemming geweigerd. Probeer te slaan zonder volledige toegang.',
//         );
//       }
//     }

//     // Create a new PDF document
//     final pdf = pw.Document();

//     // Define text styles
//     final titleStyle = pw.TextStyle(
//       fontSize: 20,
//       fontWeight: pw.FontWeight.bold,
//     );
//     final headingStyle = pw.TextStyle(
//       fontSize: 16,
//       fontWeight: pw.FontWeight.bold,
//     );
//     final bodyStyle = pw.TextStyle(fontSize: 12);

//     // Add content to the PDF
//     pdf.addPage(
//       pw.MultiPage(
//         build:
//             (context) => [
//               // Title
//               pw.Text('Taak Rapport', style: titleStyle),
//               pw.SizedBox(height: 20),

//               // Task Information
//               pw.Text('Taak Informatie', style: headingStyle),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'Taak: ${setPriceTask.customerName ?? 'Onbekend'}',
//                 style: bodyStyle,
//               ),
//               pw.Text(
//                 'Beschrijving: ${setPriceTask.shortDescription ?? 'Geen beschrijving'}',
//                 style: bodyStyle,
//               ),
//               pw.Text('Prijs: \$5000', style: bodyStyle),
//               pw.SizedBox(height: 20),

//               // Client Information
//               pw.Text('Klanteninformatie', style: headingStyle),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'Naam: ${clientInfoController.clientInfo.isNotEmpty ? clientInfoController.clientInfo.first.customerName ?? "" : ""}',
//                 style: bodyStyle,
//               ),
//               pw.Text(
//                 'Locatie: ${clientInfoController.clientInfo.isNotEmpty ? clientInfoController.clientInfo.first.customerAddress ?? "" : ""}',
//                 style: bodyStyle,
//               ),
//               pw.Text(
//                 'Telefoonnummer: ${clientInfoController.clientInfo.isNotEmpty ? clientInfoController.clientInfo.first.customerPhone ?? "" : ""}',
//                 style: bodyStyle,
//               ),
//               pw.Text('Gewenste datum: $dateStr', style: bodyStyle),
//               pw.Text('Gewenste tijd: $timeStr uur', style: bodyStyle),
//               pw.SizedBox(height: 20),

//               // Work Items
//               pw.Text('Werk Items', style: headingStyle),
//               pw.SizedBox(height: 10),
//               ...workItems.map(
//                 (item) => pw.Text(
//                   '${item['name']}: \$${item['price']}',
//                   style: bodyStyle,
//                 ),
//               ),
//               pw.SizedBox(height: 20),

//               // Checklist
//               pw.Text('Taak Checklist', style: headingStyle),
//               pw.SizedBox(height: 10),
//               ...checkList.map(
//                 (item) => pw.Text(
//                   '${item.title}: ${item.isChecked ? "Voltooid" : "Niet voltooid"}',
//                   style: bodyStyle,
//                 ),
//               ),
//               pw.SizedBox(height: 20),

//               // Photos Before
//               pw.Text('Foto\'s Voor', style: headingStyle),
//               pw.SizedBox(height: 10),
//               ...uploadedPhotos.map(
//                 (photo) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       'Beschrijving: ${photo['description'] ?? ''}',
//                       style: bodyStyle,
//                     ),
//                     pw.SizedBox(height: 10),
//                     if (File(photo['path']!).existsSync())
//                       pw.Image(
//                         pw.MemoryImage(File(photo['path']!).readAsBytesSync()),
//                         width: 200,
//                         height: 200,
//                       ),
//                     pw.SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),

//               // Photos After
//               pw.Text('Foto\'s Na', style: headingStyle),
//               pw.SizedBox(height: 10),
//               ...uploadedPhotosAfter.map(
//                 (photo) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       'Beschrijving: ${photo['description'] ?? ''}',
//                       style: bodyStyle,
//                     ),
//                     pw.SizedBox(height: 10),
//                     if (File(photo['path']!).existsSync())
//                       pw.Image(
//                         pw.MemoryImage(File(photo['path']!).readAsBytesSync()),
//                         width: 200,
//                         height: 200,
//                       ),
//                     pw.SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               pw.SizedBox(height: 20),

//               // Comments
//               pw.Text('Opmerkingen', style: headingStyle),
//               pw.SizedBox(height: 10),
//               pw.Text(
//                 'Taak succesvol voltooid. Het dak is grondig geïnspecteerd en er zijn geen zichtbare schade of schimmel- of watervlekken gevonden. Ik heb voor- en nafoto\'s genomen voor de documentatie. De klant was tevreden met het werk en gaf bevestiging. Er zijn geen aanvullende problemen gerapporteerd. Ik raad aan om over 6 maanden een vervolginspectie in te plannen om te zorgen dat alles in goede staat blijft.',
//                 style: bodyStyle,
//               ),
//               pw.SizedBox(height: 20),

//               // Client Review
//               pw.Text('Klantbeoordeling', style: headingStyle),
//               pw.SizedBox(height: 10),
//               pw.Text('Beoordeling: 5 sterren', style: bodyStyle),
//               pw.Text(
//                 'Opmerkingen: Lorem ipsum dolor sit amet consectetur. Urna odio sit neque urna. Nisi nisi volutpat pellentesque in tincidunt diam.',
//                 style: bodyStyle,
//               ),
//             ],
//       ),
//     );

//     // Save the PDF
//     try {
//       final bytes = await pdf.save();
//       final fileName =
//           'Task_Report_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf';
//       try {
//         await FileSaver.instance.saveFile(
//           name: fileName,
//           bytes: bytes,
//           mimeType: MimeType.pdf,
//         );
//         Get.snackbar('Succes', 'Rapport succesvol opgeslagen als $fileName');
//       } catch (e) {
//         // Fallback to path_provider
//         final dir = await getExternalStorageDirectory();
//         if (dir == null) {
//           Get.snackbar('Fout', 'Kan opslagdirectory niet openen');
//           return;
//         }
//         final file = File('${dir.path}/$fileName');
//         await file.writeAsBytes(bytes);
//         Get.snackbar('Succes', 'Rapport opgeslagen in ${file.path}');
//       }
//     } catch (e) {
//       Get.snackbar('Fout', 'Kan rapport niet opslaan: $e');
//     }
//   }
// }

import 'dart:io';
import 'package:baxton/features/werknemer_flow/taken/details/model/task_checklist_item.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/model/set_price_task_model.dart';
import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TaskExecutionController extends GetxController {
  final capturedImagePathAfter = ''.obs;
  final capturedImagePathBefore = ''.obs;

  var workItems = <Map<String, String>>[].obs;
  var checkList = <TaskCheckItem>[].obs;

  var uploadedPhotos = <Map<String, String>>[].obs;
  var showAllPhotos = false.obs;

  var uploadedPhotosAfter = <Map<String, String>>[].obs;
  var showAllPhotosAfter = false.obs;

  double get progress =>
      checkList.isEmpty
          ? 0
          : checkList.where((e) => e.isChecked).length / checkList.length;

  void addWorkItem(String name, String price) {
    workItems.add({'name': name, 'price': price});
  }

  void addCheckItem(String title) {
    checkList.add(TaskCheckItem(title: title));
  }

  void toggleCheck(int index, bool? value) {
    checkList[index].isChecked = value ?? false;
    checkList.refresh();
  }

  void toggleShowAllPhotos() {
    showAllPhotos.value = !showAllPhotos.value;
  }

  void toggleShowAllPhotosAfter() {
    showAllPhotosAfter.value = !showAllPhotosAfter.value;
  }

  Future<void> captureImageBefore() async {
    final capturedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (capturedFile != null) {
      _showImageDialog(capturedFile.path, isAfter: false);
    }
  }

  Future<void> captureImageAfter() async {
    final capturedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (capturedFile != null) {
      _showImageDialog(capturedFile.path, isAfter: true);
    }
  }

  void _showImageDialog(String imagePath, {required bool isAfter}) {
    final TextEditingController descriptionController = TextEditingController();

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Foto Informatie',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(imagePath),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLength: 30,
                controller: descriptionController,
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                decoration: const InputDecoration(
                  hintText: 'Beschrijving',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  isDense: true,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final item = {
                      'path': imagePath,
                      'description': descriptionController.text,
                    };
                    if (isAfter) {
                      uploadedPhotosAfter.add(item);
                    } else {
                      uploadedPhotos.add(item);
                    }
                    Get.back();
                  },
                  child: const Text('Toevoegen'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Annuleren'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> requestStoragePermission() async {
    // Request storage permission for Android
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      // Permission granted
      debugPrint('Storage permission granted');
    } else if (status.isDenied) {
      // Permission denied
      debugPrint('Storage permission denied');
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, ask user to go to settings
      debugPrint('Storage permission permanently denied');
      openAppSettings(); // This will open app settings for the user
    }
  }

  Future<void> downloadReport(SetPriceTaskModel setPriceTask) async {
    // Request storage permission before attempting to save the report
    await requestStoragePermission();

    final clientInfoController = Get.find<ClientInfoController>();
    final dateTime =
        clientInfoController.clientInfo.isNotEmpty
            ? clientInfoController.clientInfo.first.dateTime
            : DateTime.now();
    final dateStr = DateFormat('dd/MM/yyyy').format(dateTime);
    final timeStr = DateFormat('HH:mm').format(dateTime);

    // Create a new PDF document
    final pdf = pw.Document();

    // Define text styles
    final titleStyle = pw.TextStyle(
      fontSize: 20,
      fontWeight: pw.FontWeight.bold,
    );
    final headingStyle = pw.TextStyle(
      fontSize: 16,
      fontWeight: pw.FontWeight.bold,
    );
    final bodyStyle = pw.TextStyle(fontSize: 12);

    // Add content to the PDF
    pdf.addPage(
      pw.MultiPage(
        build:
            (context) => [
              // Title
              pw.Text('Taak Rapport', style: titleStyle),
              pw.SizedBox(height: 20),

              // Task Information
              pw.Text('Taak Informatie', style: headingStyle),
              pw.SizedBox(height: 10),
              pw.Text(
                'Taak: ${setPriceTask.customerName ?? 'Onbekend'}',
                style: bodyStyle,
              ),
              pw.Text(
                'Beschrijving: ${setPriceTask.shortDescription ?? 'Geen beschrijving'}',
                style: bodyStyle,
              ),
              pw.Text('Prijs: \$5000', style: bodyStyle),
              pw.SizedBox(height: 20),

              // Client Information
              pw.Text('Klanteninformatie', style: headingStyle),
              pw.SizedBox(height: 10),
              pw.Text(
                'Naam: ${clientInfoController.clientInfo.isNotEmpty ? clientInfoController.clientInfo.first.customerName ?? "" : ""}',
                style: bodyStyle,
              ),
              pw.Text(
                'Locatie: ${clientInfoController.clientInfo.isNotEmpty ? clientInfoController.clientInfo.first.customerAddress ?? "" : ""}',
                style: bodyStyle,
              ),
              pw.Text(
                'Telefoonnummer: ${clientInfoController.clientInfo.isNotEmpty ? clientInfoController.clientInfo.first.customerPhone ?? "" : ""}',
                style: bodyStyle,
              ),
              pw.Text('Gewenste datum: $dateStr', style: bodyStyle),
              pw.Text('Gewenste tijd: $timeStr uur', style: bodyStyle),
              pw.SizedBox(height: 20),

              // Work Items
              pw.Text('Werk Items', style: headingStyle),
              pw.SizedBox(height: 10),
              ...workItems.map(
                (item) => pw.Text(
                  '${item['name']}: \$${item['price']}',
                  style: bodyStyle,
                ),
              ),
              pw.SizedBox(height: 20),

              // Checklist
              pw.Text('Taak Checklist', style: headingStyle),
              pw.SizedBox(height: 10),
              ...checkList.map(
                (item) => pw.Text(
                  '${item.title}: ${item.isChecked ? "Voltooid" : "Niet voltooid"}',
                  style: bodyStyle,
                ),
              ),
              pw.SizedBox(height: 20),

              // Photos Before
              pw.Text('Foto\'s Voor', style: headingStyle),
              pw.SizedBox(height: 10),
              ...uploadedPhotos.map(
                (photo) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Beschrijving: ${photo['description'] ?? ''}',
                      style: bodyStyle,
                    ),
                    pw.SizedBox(height: 10),
                    if (File(photo['path']!).existsSync())
                      pw.Image(
                        pw.MemoryImage(File(photo['path']!).readAsBytesSync()),
                        width: 200,
                        height: 200,
                      ),
                    pw.SizedBox(height: 10),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Photos After
              pw.Text('Foto\'s Na', style: headingStyle),
              pw.SizedBox(height: 10),
              ...uploadedPhotosAfter.map(
                (photo) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Beschrijving: ${photo['description'] ?? ''}',
                      style: bodyStyle,
                    ),
                    pw.SizedBox(height: 10),
                    if (File(photo['path']!).existsSync())
                      pw.Image(
                        pw.MemoryImage(File(photo['path']!).readAsBytesSync()),
                        width: 200,
                        height: 200,
                      ),
                    pw.SizedBox(height: 10),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Comments
              pw.Text('Opmerkingen', style: headingStyle),
              pw.SizedBox(height: 10),
              pw.Text(
                'Taak succesvol voltooid. Het dak is grondig geïnspecteerd en er zijn geen zichtbare schade of schimmel- of watervlekken gevonden. Ik heb voor- en nafoto\'s genomen voor de documentatie. De klant was tevreden met het werk en gaf bevestiging. Er zijn geen aanvullende problemen gerapporteerd. Ik raad aan om over 6 maanden een vervolginspectie in te plannen om te zorgen dat alles in goede staat blijft.',
                style: bodyStyle,
              ),
              pw.SizedBox(height: 20),

              // Client Review
              pw.Text('Klantbeoordeling', style: headingStyle),
              pw.SizedBox(height: 10),
              pw.Text('Beoordeling: 5 sterren', style: bodyStyle),
              pw.Text(
                'Opmerkingen: Lorem ipsum dolor sit amet consectetur. Urna odio sit neque urna. Nisi nisi volutpat pellentesque in tincidunt diam.',
                style: bodyStyle,
              ),
            ],
      ),
    );

    // Save the PDF
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

        EasyLoading.showSuccess("Download successful");
      } catch (e) {
        // Fallback to path_provider
        final dir = await getExternalStorageDirectory();
        if (dir == null) {
          EasyLoading.showError("Fout', 'Kan opslagdirectory niet openen");
          return;
        }
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes);
        EasyLoading.showSuccess("Download successful");
      }
    } catch (e) {
      EasyLoading.showError("Fout', 'Kan opslagdirectory niet openen");
    }
  }
}
