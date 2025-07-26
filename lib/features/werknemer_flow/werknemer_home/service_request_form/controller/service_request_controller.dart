// import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/models/service_request_model.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class ServiceRequestController extends GetxController {
//   final request = ServiceRequestModel().obs;

//   final cities = ['Dhaka', 'Chittagong', 'Khulna', 'Rajshahi'].obs;
//   final taskTypes =
//       [
//         "Schimmelinspecties en -behandelingen", // Mold inspections and treatments
//         "Daklekkage opsporen en repareren", // Detect and repair roof leaks
//         "Ventilatiesysteem reinigen en controleren", // Clean and inspect ventilation system
//         'Vochtproblemen in muren analyseren en oplossen', // Analyze and resolve moisture problems in walls
//         'Isolatie van kruipruimtes verbeteren', // improve insulation of crawl spaces
//       ].obs;

//   final selectedCity = ''.obs;
//   final selectedTaskType = ''.obs;
//   final selectedPriceType = ''.obs;
//   final selectedTime = ''.obs;
//   final selectedDate = Rxn<DateTime>();
//   final selectedImagePath = ''.obs;
//   final capturedImagePath = ''.obs;

//   void setTime(String time) => selectedTime.value = time;
//   void setDate(DateTime date) => selectedDate.value = date;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       selectedImagePath.value = pickedFile.path;
//     }
//   }

//   Future<void> captureImage() async {
//     final capturedFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     if (capturedFile != null) {
//       selectedImagePath.value = capturedFile.path;
//     }
//   }

//   void submitRequest() {
//     // ignore: avoid_print
//     print('Submitting request: ${request.value}');
//   }
// }

import 'package:baxton/features/werknemer_flow/werknemer_home/service_request_form/models/service_request_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ServiceRequestController extends GetxController {
  final request = ServiceRequestModel().obs;

  final cities = ['Dhaka', 'Chittagong', 'Khulna', 'Rajshahi'].obs;

  final taskTypes =
      <String>[
        "Schimmelinspecties en -behandelingen",
        "Daklekkage opsporen en repareren",
        "Ventilatiesysteem reinigen en controleren",
        'Vochtproblemen in muren analyseren en oplossen',
        'Isolatie van kruipruimtes verbeteren',
      ].obs;

  final selectedCity = ''.obs;
  final selectedTaskType = ''.obs;
  final selectedPriceType = ''.obs;
  final selectedTime = ''.obs;
  final selectedDate = Rxn<DateTime>();
  final selectedImagePath = ''.obs;
  final capturedImagePath = ''.obs;

  void setTime(String time) => selectedTime.value = time;
  void setDate(DateTime date) => selectedDate.value = date;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> captureImage() async {
    final capturedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (capturedFile != null) {
      selectedImagePath.value = capturedFile.path;
    }
  }

  Future<void> submitRequest() async {
    try {
      final uri = Uri.parse(
        "https://freepik.softvenceomega.com/ts/service-request/create",
      );
      final requestMultipart = http.MultipartRequest('POST', uri);

      final imagePath = selectedImagePath.value;
      if (imagePath.isNotEmpty) {
        requestMultipart.files.add(
          await http.MultipartFile.fromPath('reqPhoto', imagePath),
        );
      }

      requestMultipart.fields['name'] = request.value.name ?? '';
      requestMultipart.fields['phoneNumber'] = request.value.phone ?? '';
      requestMultipart.fields['email'] = request.value.email ?? '';
      requestMultipart.fields['city'] = selectedCity.value;
      requestMultipart.fields['postalCode'] = request.value.postalCode ?? '';
      requestMultipart.fields['locationDescription'] =
          request.value.locationDesc ?? '';
      requestMultipart.fields['problemDescription'] =
          request.value.problemDesc ?? '';
      requestMultipart.fields['preferredTime'] = selectedTime.value;
      requestMultipart.fields['preferredDate'] =
          selectedDate.value?.toIso8601String() ?? '';
      requestMultipart.fields['taskTypeId'] = selectedTaskType.value;

      final streamedResponse = await requestMultipart.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Service request submitted successfully");
      } else {
        Get.snackbar("Error", "Submission failed: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    }
  }
}
