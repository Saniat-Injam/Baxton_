// // ignore_for_file: unnecessary_null_comparison, unused_element
// import 'dart:async';
// import 'dart:convert';
// import 'package:baxton/core/urls/endpoint.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
// import 'package:baxton/features/klant_flow/task_screen/model/get_client_invoice.dart';
// import 'package:baxton/features/klant_flow/task_screen/model/get_service_request_model.dart';
// import 'package:baxton/features/klant_flow/task_screen/screens/beoordelingsverzoek_invoice.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// class RequestController extends GetxController {
//   // Text controllers
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController phonecontroller = TextEditingController();
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController citycontroller = TextEditingController();
//   TextEditingController postcodecontroller = TextEditingController();
//   TextEditingController describecontroller = TextEditingController();
//   TextEditingController problemcontroller = TextEditingController();

//   // Observable variables
//   var selectedDate = ''.obs;
//   var selectedTime = ''.obs;
//   var selectedImage = Rx<File?>(null);
//   var errorMessage = ''.obs;
//   var requestId = ''.obs;
//   var serviceRequest = Rx<Getservicerequest?>(null);
//   var invoice = Rx<Getclientinvoice?>(null);
//   Timer? _statusTimer;

//   // Simplified image picker method
//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final pickedFile = await ImagePicker().pickImage(
//         source: source,
//         imageQuality: 80,
//         maxWidth: 800,
//       );

//       if (pickedFile != null) {
//         selectedImage.value = File(pickedFile.path);
//       }
//     } catch (e) {
//       debugPrint('Failed to pick image: $e');
//       EasyLoading.showError('Failed to pick image: $e');
//     }
//   }

//   //=========================================================================================
//   // Method to submit the form data to the API
//   Future<bool> submitRequest(String taskTypeId) async {
//     debugPrint('Starting request submission with Task Type ID: $taskTypeId');
//     try {
//       await EasyLoading.show(status: 'Submitting request...');

//       String? token = await AuthService.getToken();
//       debugPrint(
//         'Retrieved token: ${token != null ? 'Valid token' : 'Null or empty token'}',
//       );

//       if (token == null || token.isEmpty) {
//         debugPrint('Token validation failed: Token is null or empty');
//         errorMessage.value = 'Authentication token is missing';
//         await EasyLoading.showError(errorMessage.value);
//         return false;
//       }

//       String? formattedDateTime;
//       if (selectedDate.value.isNotEmpty && selectedTime.value.isNotEmpty) {
//         debugPrint('Selected date and time are not empty');
//         final dateParts = selectedDate.value.split('-');
//         debugPrint('Parsed selected date: $dateParts');
//         if (dateParts.length == 3) {
//           try {
//             final day = int.parse(dateParts[0]).toString().padLeft(2, '0');
//             final month = int.parse(dateParts[1]).toString().padLeft(2, '0');
//             final year = int.parse(dateParts[2]);

//             if (day.isEmpty || month.isEmpty || year < 2000 || year > 2100) {
//               await EasyLoading.showError('Invalid date components');
//               await EasyLoading.dismiss();
//               return false;
//             }

//             final timeFormat = DateFormat('h:mm a');
//             final parsedTime = timeFormat.parse(selectedTime.value);
//             final hour = parsedTime.hour.toString().padLeft(2, '0');
//             final minute = parsedTime.minute.toString().padLeft(2, '0');

//             formattedDateTime = '$year-$month-${day}T$hour:$minute:00Z';
//             debugPrint('Formatted date-time: $formattedDateTime');
//           } catch (e) {
//             debugPrint('Date parsing error: $e');
//             await EasyLoading.showError('Invalid date format');
//             await EasyLoading.dismiss();
//             return false;
//           }
//         } else {
//           await EasyLoading.showError('Invalid date format');
//           await EasyLoading.dismiss();
//           return false;
//         }
//       } else {
//         await EasyLoading.showError('Please select both date and time');
//         await EasyLoading.dismiss();
//         return false;
//       }

//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(Urls.clientrequest),
//       );

//       request.headers['accept'] = '*/*';
//       request.headers['Authorization'] = 'Bearer $token';
//       request.headers['Content-Type'] = 'multipart/form-data';

//       request.fields['name'] = namecontroller.text;
//       request.fields['phoneNumber'] = phonecontroller.text;
//       request.fields['email'] = emailcontroller.text;
//       request.fields['city'] = citycontroller.text;
//       request.fields['postalCode'] = postcodecontroller.text;
//       request.fields['locationDescription'] = describecontroller.text;
//       request.fields['problemDescription'] = problemcontroller.text;
//       request.fields['taskTypeId'] = taskTypeId;
//       if (formattedDateTime != null) {
//         request.fields['preferredDate'] = formattedDateTime;
//         request.fields['preferredTime'] = formattedDateTime;
//       }

//       if (selectedImage.value != null) {
//         String fileExtension =
//             selectedImage.value!.path.split('.').last.toLowerCase();
//         String mimeType =
//             fileExtension == 'jpg' || fileExtension == 'jpeg'
//                 ? 'image/jpeg'
//                 : 'image/png';
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'reqPhoto',
//             selectedImage.value!.path,
//             contentType: MediaType.parse(mimeType),
//           ),
//         );
//         debugPrint('Image added to request: ${selectedImage.value!.path}');
//       }

//       debugPrint('Sending API request with Task Type ID: $taskTypeId');
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//       debugPrint('API response status: ${response.statusCode}');
//       debugPrint('API response body: $responseBody');

//       await EasyLoading.dismiss();

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         try {
//           final jsonResponse = jsonDecode(responseBody);
//           final id = jsonResponse['data']?['id']?.toString();
//           if (id != null && id.isNotEmpty) {
//             requestId.value = id;
//             debugPrint('Request ID extracted: $id');
//             await fetchRequestStatus();
//             _startPeriodicStatusCheck();
//           } else {
//             debugPrint('No ID found in response');
//             errorMessage.value = 'No request ID returned from the server';
//             await EasyLoading.showError(errorMessage.value);
//             return false;
//           }
//         } catch (e) {
//           debugPrint('Error parsing response: $e');
//           errorMessage.value = 'Failed to parse response';
//           await EasyLoading.showError(errorMessage.value);
//           return false;
//         }
//         await EasyLoading.showSuccess('Request submitted successfully');
//         return true;
//       } else {
//         errorMessage.value = 'Failed to submit request: $responseBody';
//         await EasyLoading.showError(errorMessage.value);
//         return false;
//       }
//     } catch (e) {
//       debugPrint('Error occurred: $e');
//       errorMessage.value = 'An error occurred: $e';
//       await EasyLoading.showError(errorMessage.value);
//       await EasyLoading.dismiss();
//       return false;
//     }
//   }

//   //===========================================================================================
//   // Method to call the GET API and parse into Getservicerequest
//   Future<void> fetchRequestStatus() async {
//     if (requestId.value.isEmpty) {
//       debugPrint('No request ID available for status check');
//       return;
//     }

//     try {
//       String? token = await AuthService.getToken();
//       if (token == null || token.isEmpty) {
//         debugPrint('Token validation failed for GET request');
//         errorMessage.value = 'Authentication token is missing';
//         await EasyLoading.showError(errorMessage.value);
//         return;
//       }

//       final response = await http.get(
//         Uri.parse('${Urls.getservicerequest}${requestId.value}'),
//         headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
//       );

//       debugPrint('GET API response status: ${response.statusCode}');
//       debugPrint('GET API response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         serviceRequest.value = Getservicerequest.fromJson(
//           jsonResponse,
//         ); // No 'data' wrapper in GET response
//         debugPrint(
//           'Service request updated: ${serviceRequest.value?.id}, Image URL: ${serviceRequest.value?.reqPhoto?.url}',
//         );
//         await EasyLoading.showInfo(
//           'Request status updated: ${serviceRequest.value?.status}',
//         );
//       } else {
//         debugPrint('GET API failed: ${response.body}');
//         errorMessage.value = 'Failed to fetch request status';
//         await EasyLoading.showError(errorMessage.value);
//       }
//     } catch (e) {
//       debugPrint('Error in GET request: $e');
//       errorMessage.value = 'Error fetching request status: $e';
//       await EasyLoading.showError(errorMessage.value);
//     }
//   }

//   //============================================================================================

//   // Start periodic status checks
//   void _startPeriodicStatusCheck() {
//     _statusTimer?.cancel();
//     _statusTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
//       debugPrint('Checking request status for ID: ${requestId.value}');
//       fetchRequestStatus();
//     });
//   }

//   //============================================================================================

//   Widget buildImageWidget(BuildContext context, serviceRequest) {
//     final photoUrl = serviceRequest.reqPhoto?.url;
//     debugPrint('Image URL: $photoUrl');
//     if (photoUrl == null || photoUrl.isEmpty) {
//       debugPrint('No valid photo URL, showing fallback image');
//       EasyLoading.showInfo('No image available');
//       return Image.asset(IconPath.image, fit: BoxFit.cover);
//     }

//     return FutureBuilder<String?>(
//       future: AuthService.getToken(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           debugPrint('Waiting for token...');
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           debugPrint('Token fetch error: ${snapshot.error}');
//           EasyLoading.showError('Failed to load authentication token');
//           return Image.asset(IconPath.image, fit: BoxFit.cover);
//         }
//         if (!snapshot.hasData ||
//             snapshot.data == null ||
//             snapshot.data!.isEmpty) {
//           debugPrint('Token is null or empty');
//           EasyLoading.showError('Authentication token is missing');
//           return Image.asset(IconPath.image, fit: BoxFit.cover);
//         }

//         final token = snapshot.data!;
//         debugPrint(
//           'Token retrieved: ${token.substring(0, 10)}...',
//         ); // Log partial token for security
//         return CachedNetworkImage(
//           imageUrl: photoUrl,
//           httpHeaders: {'Authorization': 'Bearer $token'},
//           placeholder:
//               (context, url) =>
//                   const Center(child: CircularProgressIndicator()),
//           errorWidget: (context, url, error) {
//             debugPrint('Image load error: $error, URL: $photoUrl');
//             EasyLoading.showError('Failed to load image');
//             return Image.asset(IconPath.image, fit: BoxFit.cover);
//           },
//           fit: BoxFit.cover,
//         );
//       },
//     );
//   }

//   //============================================================================================

//   Future<bool> cancelRequest(String requestId) async {
//     try {
//       // Step 1: Get the token
//       String? token = await AuthService.getToken();
//       debugPrint('Retrieved token: $token');

//       if (token == null || token.isEmpty) {
//         debugPrint('Error: Authentication token is missing');
//         EasyLoading.showError('Authentication token is missing');
//         return false;
//       }

//       // Step 2: Make the PATCH request
//       final url =
//           'https://freepik.softvenceomega.com/ts/service-request/cancel/$requestId';
//       debugPrint('Making PATCH request to: $url');

//       final response = await http.patch(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       // Step 3: Check the response status code
//       debugPrint('Response Status Code: ${response.statusCode}');
//       debugPrint('Response Body: ${response.body}');

//       // Step 4: Handling success or failure
//       if (response.statusCode == 200 || response.statusCode == 204) {
//         debugPrint('Request canceled successfully: $requestId');
//         return true;
//       } else {
//         debugPrint('Failed to cancel request: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       // Step 5: Error handling
//       debugPrint('Error during cancellation: $e');
//       return false;
//     }
//   }

//   //============================================================================================

//   // Show confirmation dialog for cancellation
//   Future<bool> showCancelDialog(BuildContext context) async {
//     return await showDialog<bool>(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Cancel Request"),
//               content: Text("Are you sure you want to cancel this request?"),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(
//                       context,
//                     ).pop(false); // Return false if canceled
//                   },
//                   child: Text('No'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true); // Return true if confirmed
//                   },
//                   child: Text('Yes'),
//                 ),
//               ],
//             );
//           },
//         ) ??
//         false; // Default to false if dialog is dismissed
//   }

//  // In RequestController
// void stopPeriodicStatusCheck() {
//   _statusTimer?.cancel();
//   _statusTimer = null;
//   debugPrint('Periodic status check stopped');
// }

//   @override
//   void onClose() {
//     namecontroller.dispose();
//     phonecontroller.dispose();
//     emailcontroller.dispose();
//     citycontroller.dispose();
//     postcodecontroller.dispose();
//     describecontroller.dispose();
//     problemcontroller.dispose();
//     stopPeriodicStatusCheck();
//     super.onClose();
//   }
//   //============================================================================================

//   Future<bool> confirmServiceRequest(String requestId) async {
//     try {
//       String? token = await AuthService.getToken();
//       if (token == null || token.isEmpty) {
//         EasyLoading.showError("Authentication token is missing");
//         debugPrint("Error: Authentication token is missing");
//         return false;
//       }

//       final confirmServiceUrl =
//           'https://freepik.softvenceomega.com/ts/service-request/confirm-service-request/$requestId';

//       EasyLoading.show(status: 'Confirming service request...');
//       final confirmResponse = await http.post(
//         Uri.parse(confirmServiceUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (confirmResponse.statusCode == 200 ||
//           confirmResponse.statusCode == 201) {
//         EasyLoading.showSuccess('Service request confirmed successfully');
//         debugPrint("Service request confirmed successfully.");
//         return true;
//       } else {
//         EasyLoading.showError(
//           'Failed to confirm service request: ${confirmResponse.body}',
//         );
//         debugPrint(
//           "Failed to confirm service request: ${confirmResponse.body}",
//         );
//         return false;
//       }
//     } catch (e) {
//       EasyLoading.showError(
//         'Error occurred while confirming service request: $e',
//       );
//       debugPrint("Error: $e");
//       return false;
//     }
//   }

//   //============================================================================================

//   Future<void> createInvoice() async {
//     try {
//       if (serviceRequest.value == null) {
//         EasyLoading.showError("No service request data available");
//         debugPrint("Error: No service request data available");
//         return;
//       }

//       final request = serviceRequest.value!;
//       final payload = {
//         'serviceRequestId': request.id,
//         'clientId': request.clientProfileId,
//         'workerId': request.workerProfileId ?? "",
//       };

//       String? token = await AuthService.getToken();
//       if (token == null || token.isEmpty) {
//         EasyLoading.showError("Authentication token is missing");
//         debugPrint("Error: Authentication token is missing");
//         return;
//       }

//       final response = await http.post(
//         Uri.parse('https://freepik.softvenceomega.com/ts/invoice/create'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode(payload),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         EasyLoading.showSuccess('Invoice created successfully');
//         debugPrint("Invoice created successfully.");
//       } else {
//         EasyLoading.showError('Failed to create invoice: ${response.body}');
//         debugPrint("Failed to create invoice: ${response.body}");
//       }
//     } catch (e) {
//       EasyLoading.showError('Error occurred while creating invoice: $e');
//       debugPrint("Error: $e");
//     }
//   }

//   //============================================================================================

//   Future<void> getInvoice() async {
//     try {
//       if (serviceRequest.value == null) {
//         EasyLoading.showError("No service request data available");
//         debugPrint("Error: No service request data available");
//         return;
//       }

//       final request = serviceRequest.value!;
//       if (request.invoiceId == null || request.invoiceId.isEmpty) {
//         EasyLoading.showError("Invoice ID is missing");
//         debugPrint("Error: Invoice ID is missing");
//         return;
//       }

//       String? token = await AuthService.getToken();
//       if (token == null || token.isEmpty) {
//         EasyLoading.showError("Authentication token is missing");
//         debugPrint("Error: Authentication token is missing");
//         return;
//       }

//       final response = await http.get(
//         Uri.parse(
//           'https://freepik.softvenceomega.com/ts/invoice/get/${request.invoiceId}',
//         ),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final invoiceData = getclientinvoiceFromJson(response.body);
//         invoice.value = invoiceData; // Store the invoice data
//         EasyLoading.showSuccess('Invoice fetched successfully');
//         Get.to(BetalingsbeheerInvoiceScreen());
//       } else {
//         EasyLoading.showError('Failed to fetch invoice: ${response.body}');
//         debugPrint("Failed to fetch invoice: ${response.body}");
//       }
//     } catch (e) {
//       EasyLoading.showError('Error occurred while fetching invoice: $e');
//       debugPrint("Error: $e");
//     }
//   }
// }



// ignore_for_file: unnecessary_null_comparison, unused_element
import 'dart:async';
import 'dart:convert';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/task_screen/model/get_client_invoice.dart';
import 'package:baxton/features/klant_flow/task_screen/model/get_service_request_model.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/beoordelingsverzoek_invoice.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/task_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RequestController extends GetxController {
  // Text controllers
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController postcodecontroller = TextEditingController();
  TextEditingController describecontroller = TextEditingController();
  TextEditingController problemcontroller = TextEditingController();

  // Observable variables
  var selectedDate = ''.obs;
  var selectedTime = ''.obs;
  var selectedImage = Rx<File?>(null);
  var errorMessage = ''.obs;
  var requestId = ''.obs;
  var serviceRequest = Rx<Getservicerequest?>(null);
  var invoice = Rx<Getclientinvoice?>(null);
  var shouldFetchInvoice = true.obs; // Flag to control invoice fetching
  Timer? _statusTimer;

  // Simplified image picker method
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Failed to pick image: $e');
      EasyLoading.showError('Failed to pick image: $e');
    }
  }

  // Method to submit the form data to the API
  Future<bool> submitRequest(String taskTypeId) async {
    debugPrint('Starting request submission with Task Type ID: $taskTypeId');
    try {
      await EasyLoading.show(status: 'Submitting request...');

      String? token = await AuthService.getToken();
      debugPrint(
        'Retrieved token: ${token != null ? 'Valid token' : 'Null or empty token'}',
      );

      if (token == null || token.isEmpty) {
        debugPrint('Token validation failed: Token is null or empty');
        errorMessage.value = 'Authentication token is missing';
        await EasyLoading.showError(errorMessage.value);
        return false;
      }

      String? formattedDateTime;
      if (selectedDate.value.isNotEmpty && selectedTime.value.isNotEmpty) {
        debugPrint('Selected date and time are not empty');
        final dateParts = selectedDate.value.split('-');
        debugPrint('Parsed selected date: $dateParts');
        if (dateParts.length == 3) {
          try {
            final day = int.parse(dateParts[0]).toString().padLeft(2, '0');
            final month = int.parse(dateParts[1]).toString().padLeft(2, '0');
            final year = int.parse(dateParts[2]);

            if (day.isEmpty || month.isEmpty || year < 2000 || year > 2100) {
              await EasyLoading.showError('Invalid date components');
              await EasyLoading.dismiss();
              return false;
            }

            final timeFormat = DateFormat('h:mm a');
            final parsedTime = timeFormat.parse(selectedTime.value);
            final hour = parsedTime.hour.toString().padLeft(2, '0');
            final minute = parsedTime.minute.toString().padLeft(2, '0');

            formattedDateTime = '$year-$month-${day}T$hour:$minute:00Z';
            debugPrint('Formatted date-time: $formattedDateTime');
          } catch (e) {
            debugPrint('Date parsing error: $e');
            await EasyLoading.showError('Invalid date format');
            await EasyLoading.dismiss();
            return false;
          }
        } else {
          await EasyLoading.showError('Invalid date format');
          await EasyLoading.dismiss();
          return false;
        }
      } else {
        await EasyLoading.showError('Please select both date and time');
        await EasyLoading.dismiss();
        return false;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.clientrequest),
      );

      request.headers['accept'] = '*/*';
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['name'] = namecontroller.text;
      request.fields['phoneNumber'] = phonecontroller.text;
      request.fields['email'] = emailcontroller.text;
      request.fields['city'] = citycontroller.text;
      request.fields['postalCode'] = postcodecontroller.text;
      request.fields['locationDescription'] = describecontroller.text;
      request.fields['problemDescription'] = problemcontroller.text;
      request.fields['taskTypeId'] = taskTypeId;
      if (formattedDateTime != null) {
        request.fields['preferredDate'] = formattedDateTime;
        request.fields['preferredTime'] = formattedDateTime;
      }

      if (selectedImage.value != null) {
        String fileExtension =
            selectedImage.value!.path.split('.').last.toLowerCase();
        String mimeType =
            fileExtension == 'jpg' || fileExtension == 'jpeg'
                ? 'image/jpeg'
                : 'image/png';
        request.files.add(
          await http.MultipartFile.fromPath(
            'reqPhoto',
            selectedImage.value!.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
        debugPrint('Image added to request: ${selectedImage.value!.path}');
      }

      debugPrint('Sending API request with Task Type ID: $taskTypeId');
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      debugPrint('API response status: ${response.statusCode}');
      debugPrint('API response body: $responseBody');

      await EasyLoading.dismiss();

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final jsonResponse = jsonDecode(responseBody);
          final id = jsonResponse['data']?['id']?.toString();
          if (id != null && id.isNotEmpty) {
            requestId.value = id;
            debugPrint('Request ID extracted: $id');
            await fetchRequestStatus();
            _startPeriodicStatusCheck();
          } else {
            debugPrint('No ID found in response');
            errorMessage.value = 'No request ID returned from the server';
            await EasyLoading.showError(errorMessage.value);
            return false;
          }
        } catch (e) {
          debugPrint('Error parsing response: $e');
          errorMessage.value = 'Failed to parse response';
          await EasyLoading.showError(errorMessage.value);
          return false;
        }
        await EasyLoading.showSuccess('Request submitted successfully');
        return true;
      } else {
        errorMessage.value = 'Failed to submit request: $responseBody';
        await EasyLoading.showError(errorMessage.value);
        return false;
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
      errorMessage.value = 'An error occurred: $e';
      await EasyLoading.showError(errorMessage.value);
      await EasyLoading.dismiss();
      return false;
    }
  }

  // Method to call the GET API and parse into Getservicerequest
  Future<void> fetchRequestStatus() async {
    if (requestId.value.isEmpty) {
      debugPrint('No request ID available for status check');
      return;
    }

    try {
      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        debugPrint('Token validation failed for GET request');
        errorMessage.value = 'Authentication token is missing';
        await EasyLoading.showError(errorMessage.value);
        return;
      }

      final response = await http.get(
        Uri.parse('${Urls.getservicerequest}${requestId.value}'),
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      debugPrint('GET API response status: ${response.statusCode}');
      debugPrint('GET API response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        serviceRequest.value = Getservicerequest.fromJson(
          jsonResponse,
        ); // No 'data' wrapper in GET response
        debugPrint(
          'Service request updated: ${serviceRequest.value?.id}, Image URL: ${serviceRequest.value?.reqPhoto?.url}',
        );
        await EasyLoading.showInfo(
          'Request status updated: ${serviceRequest.value?.status}',
        );
      } else {
        debugPrint('GET API failed: ${response.body}');
        errorMessage.value = 'Failed to fetch request status';
        await EasyLoading.showError(errorMessage.value);
      }
    } catch (e) {
      debugPrint('Error in GET request: $e');
      errorMessage.value = 'Error fetching request status: $e';
      await EasyLoading.showError(errorMessage.value);
    }
  }

  // Start periodic status checks
  void _startPeriodicStatusCheck() {
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      debugPrint('Checking request status for ID: ${requestId.value}');
      fetchRequestStatus();
    });
  }

  // Stop periodic status checks
  void stopPeriodicStatusCheck() {
    _statusTimer?.cancel();
    _statusTimer = null;
    debugPrint('Periodic status check stopped');
  }

  // Reset invoice fetching flag
  void resetInvoiceFetching() {
    shouldFetchInvoice.value = true;
  }

  // Stop invoice fetching
  void stopInvoiceFetching() {
    shouldFetchInvoice.value = false;
    debugPrint('Stopped invoice fetching');
  }

  Widget buildImageWidget(BuildContext context, serviceRequest) {
    final photoUrl = serviceRequest.reqPhoto?.url;
    debugPrint('Image URL: $photoUrl');
    if (photoUrl == null || photoUrl.isEmpty) {
      debugPrint('No valid photo URL, showing fallback image');
      EasyLoading.showInfo('No image available');
      return Image.asset(IconPath.image, fit: BoxFit.cover);
    }

    return FutureBuilder<String?>(
      future: AuthService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          debugPrint('Waiting for token...');
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          debugPrint('Token fetch error: ${snapshot.error}');
          EasyLoading.showError('Failed to load authentication token');
          return Image.asset(IconPath.image, fit: BoxFit.cover);
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          debugPrint('Token is null or empty');
          EasyLoading.showError('Authentication token is missing');
          return Image.asset(IconPath.image, fit: BoxFit.cover);
        }

        final token = snapshot.data!;
        debugPrint(
          'Token retrieved: ${token.substring(0, 10)}...',
        ); // Log partial token for security
        return CachedNetworkImage(
          imageUrl: photoUrl,
          httpHeaders: {'Authorization': 'Bearer $token'},
          placeholder:
              (context, url) =>
                  const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) {
            debugPrint('Image load error: $error, URL: $photoUrl');
            EasyLoading.showError('Failed to load image');
            return Image.asset(IconPath.image, fit: BoxFit.cover);
          },
          fit: BoxFit.cover,
        );
      },
    );
  }

  Future<bool> cancelRequest(String requestId) async {
    try {
      // Step 1: Get the token
      String? token = await AuthService.getToken();
      debugPrint('Retrieved token: $token');

      if (token == null || token.isEmpty) {
        debugPrint('Error: Authentication token is missing');
        EasyLoading.showError('Authentication token is missing');
        return false;
      }

      // Step 2: Make the PATCH request
      final url =
          'https://freepik.softvenceomega.com/ts/service-request/cancel/$requestId';
      debugPrint('Making PATCH request to: $url');

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Step 3: Check the response status code
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Step 4: Handling success or failure
      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.offAll(TaskScreen);
        debugPrint('Request canceled successfully: $requestId');
        return true;
      } else {
        debugPrint('Failed to cancel request: ${response.body}');
        return false;
      }
    } catch (e) {
      // Step 5: Error handling
      debugPrint('Error during cancellation: $e');
      return false;
    }
  }

  // Show confirmation dialog for cancellation
  Future<bool> showCancelDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Cancel Request"),
              content: Text("Are you sure you want to cancel this request?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(false); // Return false if canceled
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true if confirmed
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if dialog is dismissed
  }

  Future<bool> confirmServiceRequest(String requestId) async {
    try {
      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token is missing");
        debugPrint("Error: Authentication token is missing");
        return false;
      }

      final confirmServiceUrl =
          'https://freepik.softvenceomega.com/ts/service-request/confirm-service-request/$requestId';

      EasyLoading.show(status: 'Confirming service request...');
      final confirmResponse = await http.post(
        Uri.parse(confirmServiceUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (confirmResponse.statusCode == 200 ||
          confirmResponse.statusCode == 201) {
        EasyLoading.showSuccess('Service request confirmed successfully');
        debugPrint("Service request confirmed successfully.");
        return true;
      } else {
        EasyLoading.showError(
          'Failed to confirm service request: ${confirmResponse.body}',
        );
        debugPrint(
          "Failed to confirm service request: ${confirmResponse.body}",
        );
        return false;
      }
    } catch (e) {
      EasyLoading.showError(
        'Error occurred while confirming service request: $e',
      );
      debugPrint("Error: $e");
      return false;
    }
  }

  Future<void> createInvoice() async {
    try {
      if (serviceRequest.value == null) {
        EasyLoading.showError("No service request data available");
        debugPrint("Error: No service request data available");
        return;
      }

      final request = serviceRequest.value!;
      final payload = {
        'serviceRequestId': request.id,
        'clientId': request.clientProfileId,
        'workerId': request.workerProfileId ?? "",
      };

      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token is missing");
        debugPrint("Error: Authentication token is missing");
        return;
      }

      final response = await http.post(
        Uri.parse('https://freepik.softvenceomega.com/ts/invoice/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Invoice created successfully');
        debugPrint("Invoice created successfully.");
      } else {
        EasyLoading.showError('Failed to create invoice: ${response.body}');
        debugPrint("Failed to create invoice: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError('Error occurred while creating invoice: $e');
      debugPrint("Error: $e");
    }
  }

  Future<void> getInvoice() async {
    if (!shouldFetchInvoice.value) {
      debugPrint('Invoice fetching is disabled');
      return;
    }

    try {
      if (serviceRequest.value == null) {
        EasyLoading.showError("No service request data available");
        debugPrint("Error: No service request data available");
        return;
      }

      final request = serviceRequest.value!;
      if (request.invoiceId == null || request.invoiceId.isEmpty) {
        EasyLoading.showError("Invoice ID is missing");
        debugPrint("Error: Invoice ID is missing");
        return;
      }

      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token is missing");
        debugPrint("Error: Authentication token is missing");
        return;
      }

      final response = await http.get(
        Uri.parse('https://freepik.softvenceomega.com/ts/invoice/get/${request.invoiceId}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final invoiceData = getclientinvoiceFromJson(response.body);
        invoice.value = invoiceData; // Store the invoice data
        EasyLoading.showSuccess('Invoice fetched successfully');
        Get.to(() => BetalingsbeheerInvoiceScreen());
      } else {
        EasyLoading.showError('Failed to fetch invoice: ${response.body}');
        debugPrint("Failed to fetch invoice: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError('Error occurred while fetching invoice: $e');
      debugPrint("Error: $e");
    }
  }

  @override
  void onClose() {
    namecontroller.dispose();
    phonecontroller.dispose();
    emailcontroller.dispose();
    citycontroller.dispose();
    postcodecontroller.dispose();
    describecontroller.dispose();
    problemcontroller.dispose();
    stopPeriodicStatusCheck();
    super.onClose();
  }
}