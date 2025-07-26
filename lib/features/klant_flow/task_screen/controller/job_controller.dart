// import 'package:baxton/core/urls/endpoint.dart';
// import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
// import 'package:baxton/features/klant_flow/task_screen/model/job_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:baxton/features/klant_flow/task_screen/model/request_overview_model.dart';

// class JobController extends GetxController {
//   var jobList = <Job>[].obs;
//   var requestedList = <Completed>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     debugPrint('JobController onInit called');
//     fetchServiceRequests();
//   }

//   Future<void> fetchServiceRequests({bool retry = false}) async {
//     debugPrint('Starting fetchServiceRequests API call (retry: $retry)');
//     isLoading.value = true;
//     errorMessage.value = '';

//     try {
//       await EasyLoading.show(
//         status: 'Loading service requests...',
//         maskType: EasyLoadingMaskType.black,
//       );

//       String? token = await AuthService.getToken();
//       if (token == null || token.isEmpty) {
//         errorMessage.value = 'Authentication token is missing';
//         await EasyLoading.showError(errorMessage.value);
//         return;
//       }

//       final url = Urls.servicerequestoverview;
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       ).timeout(Duration(seconds: 30), onTimeout: () {
//         throw Exception('Request timed out');
//       });

//       debugPrint('API Response: ${response.body}'); // Log raw response for debugging

//       if (response.statusCode == 200) {
//         final requestOverview = requestoverviewFromJson(response.body);

//         // Update requested list
//         requestedList.assignAll(requestOverview.data.requested);

//         // Populate job list
//         jobList.assignAll([
//           ...requestOverview.data.requested.map((request) => _mapToJob(request)),
//           ...requestOverview.data.confirmed.map((request) => _mapToJob(request)),
//           ...requestOverview.data.completed.map((request) => _mapToJob(request)),
//         ]);
//       } else {
//         errorMessage.value = 'Failed to load service requests: ${response.statusCode}';
//         await EasyLoading.showError(errorMessage.value);
//       }
//     } catch (e) {
//       errorMessage.value = 'Error fetching service requests: $e';
//       debugPrint(errorMessage.value); // Log error for debugging
//       await EasyLoading.showError(errorMessage.value);
//     } finally {
//       isLoading.value = false;
//       await EasyLoading.dismiss();
//     }
//   }
  

//   Job _mapToJob(Completed request) {
//     return Job(
//       title: request.taskTypeId ?? 'Unknown Task',
//       location: request.city ?? 'Unknown City',
//       description: request.problemDescription ?? 'No Description',
//       date: DateFormat('dd MMMM, yyyy').format(request.preferredDate),
//       status: request.status ?? 'Unknown Status',
//     );
//   }

//   List<Job> getJobs() {
//     return jobList.toList();
//   }

//   List<Completed> getRequestedServices() {
//     return requestedList.toList();
//   }

//   void retryFetch() {
//     fetchServiceRequests(retry: true);
//   }
// }





import 'dart:convert';
import 'package:baxton/core/urls/endpoint.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/klant_flow/task_screen/model/all_task_model.dart';
import 'package:baxton/features/klant_flow/task_screen/model/job_model.dart';
import 'package:baxton/features/klant_flow/task_screen/model/request_overview_model.dart';
import 'package:baxton/features/klant_flow/task_screen/model/service_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class JobController extends GetxController {
  var jobList = <Job>[].obs;
  var requestedList = <ServiceRequest>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint('JobController onInit called');
    fetchServiceRequests();
  }

  Future<void> fetchServiceRequests({bool retry = false}) async {
    debugPrint('Starting fetchServiceRequests API call (retry: $retry)');
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await EasyLoading.show(
        status: 'Loading service requests...',
        maskType: EasyLoadingMaskType.black,
      );

      String? token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Authentication token is missing';
        await EasyLoading.showError(errorMessage.value);
        return;
      }

      final url = Urls.servicerequestoverview;
      debugPrint('Fetching from URL: $url');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30), onTimeout: () {
        throw Exception('Request timed out');
      });

      debugPrint('fetchServiceRequests Response: ${response.body}');

      if (response.statusCode == 200) {
        final requestOverview = RequestOverview.fromJson(json.decode(response.body));
        debugPrint('Requested Services Parsed: ${requestOverview.requested.map((e) => e.toJson()).toList()}');

        requestedList.assignAll(requestOverview.requested);

        jobList.assignAll([
          ...requestOverview.requested.map((request) => _mapToJob(request)),
          ...requestOverview.confirmed.map((request) => _mapToJob(request)),
          ...requestOverview.completed.map((request) => _mapToJob(request)),
        ]);
      } else {
        errorMessage.value = 'Failed to load service requests: ${response.statusCode}';
        await EasyLoading.showError(errorMessage.value);
      }
    } catch (e, stackTrace) {
      errorMessage.value = 'Error fetching service requests: $e';
      debugPrint('Error: $errorMessage');
      debugPrint('Stack trace: $stackTrace');
      await EasyLoading.showError(errorMessage.value);
    } finally {
      isLoading.value = false;
      await EasyLoading.dismiss();
    }
  }

  Job _mapToJob(ServiceRequest request) {
    DateTime preferredDate;
    try {
      preferredDate = DateTime.parse(request.preferredDate ?? '');
    } catch (e) {
      preferredDate = DateTime.now();
    }

    return Job(
      title: request.name??'',
      location: request.city ?? '',
      description: request.problemDescription ?? '' ,
      date: DateFormat('dd MMMM, yyyy').format(preferredDate),
      status: request.status.isEmpty ? 'Unknown Status' : request.status,
    );
  }

  Future<List<ServiceRequest>> fetchServiceRequestsForStatus(String status) async {
    final url = Uri.parse('https://freepik.softvenceomega.com/ts/service-request/get-all-client-service-request?take=10&skip=0&taskType=$status');
    String? token = await AuthService.getToken();

    if (token == null || token.isEmpty) {
      errorMessage.value = 'Authentication token is missing';
      await EasyLoading.showError(errorMessage.value);
      return [];
    }

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      debugPrint('fetchServiceRequestsForStatus ($status) Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          final serviceResponse = ServiceResponse.fromJson(data);
          debugPrint('Service Requests for $status: ${serviceResponse.data.map((e) => e.toJson()).toList()}');
          return serviceResponse.data;
        } else {
          throw Exception('Failed to load service requests: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to load service requests: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      errorMessage.value = 'Error fetching service requests for $status: $e';
      debugPrint('Error: $errorMessage');
      debugPrint('Stack trace: $stackTrace');
      await EasyLoading.showError(errorMessage.value);
      return [];
    }
  }

  Future<void> fetchAllServiceRequests() async {
    isLoading.value = true;
    try {
      final confirmedRequests = await fetchServiceRequestsForStatus('CONFIRMED');
      final pendingRequests = await fetchServiceRequestsForStatus('PENDING');
      final completedRequests = await fetchServiceRequestsForStatus('COMPLETED');

      final allRequests = [
        ...confirmedRequests,
        ...pendingRequests,
        ...completedRequests,
      ];

      jobList.assignAll(allRequests.map((request) => _mapToJob(request)).toList());
    } catch (e, stackTrace) {
      errorMessage.value = 'Error fetching all service requests: $e';
      debugPrint('Error: $errorMessage');
      debugPrint('Stack trace: $stackTrace');
      await EasyLoading.showError(errorMessage.value);
    } finally {
      isLoading.value = false;
      await EasyLoading.dismiss();
    }
  }

  List<Job> getJobs() {
    return jobList.toList();
  }

  List<ServiceRequest> getRequestedServices() {
    debugPrint('Requested Services: ${requestedList.map((e) => e.toJson()).toList()}');
    return requestedList.toList();
  }

  void retryFetch() {
    fetchServiceRequests(retry: true);
  }
}



// import 'dart:convert';
// import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
// import 'package:baxton/features/klant_flow/task_screen/model/all_task_model.dart';
// import 'package:baxton/features/klant_flow/task_screen/model/job_model.dart';
// import 'package:baxton/features/klant_flow/task_screen/model/test_task_request.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class JobController extends GetxController {
//   var jobList = <Job>[].obs;
//   var requestedList = <ServiceRequest>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     debugPrint('JobController onInit called');
//     fetchServiceRequestsForPending(); // Call the function on init
//   }

//   // Fetch Service Requests for PENDING status
//   Future<void> fetchServiceRequestsForPending() async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     try {
//       await EasyLoading.show(
//         status: 'Loading PENDING service requests...',
//         maskType: EasyLoadingMaskType.black,
//       );

//       String? token = await AuthService.getToken();
//       if (token == null || token.isEmpty) {
//         errorMessage.value = 'Authentication token is missing';
//         await EasyLoading.showError(errorMessage.value);
//         return;
//       }

//       final url = Uri.parse('https://freepik.softvenceomega.com/ts/service-request/get-all-client-service-request?take=10&skip=0&taskType=PENDING');
//       debugPrint('Fetching from URL: $url');

//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       ).timeout(const Duration(seconds: 30), onTimeout: () {
//         throw Exception('Request timed out');
//       });

//       debugPrint('fetchServiceRequestsForPending Response: ${response.body}');

//       if (response.statusCode == 200) {
//         final taskrequested = Taskrequested.fromJson(json.decode(response.body));
//         debugPrint('Taskrequested Parsed: ${taskrequested.data.map((e) => e.toJson()).toList()}');

//         // Assign the fetched data to job list by mapping to Job
//         jobList.assignAll(taskrequested.data.map((request) => _mapToJob(request)));
//       } else {
//         errorMessage.value = 'Failed to load service requests: ${response.statusCode}';
//         await EasyLoading.showError(errorMessage.value);
//       }
//     } catch (e, stackTrace) {
//       errorMessage.value = 'Error fetching service requests: $e';
//       debugPrint('Error: $errorMessage');
//       debugPrint('Stack trace: $stackTrace');
//       await EasyLoading.showError(errorMessage.value);
//     } finally {
//       isLoading.value = false;
//       await EasyLoading.dismiss();
//     }
//   }

//   Job _mapToJob(Datum request) {
//     DateTime preferredDate;
//     try {
//       preferredDate = request.preferredDate;
//     } catch (e) {
//       preferredDate = DateTime.now();
//     }

//     return Job(
//       title: request.name ,
//       location: request.city ,
//       description: request.problemDescription ,
//       date: DateFormat('dd MMMM, yyyy').format(preferredDate),
//       status: request.status.isEmpty ? 'Unknown Status' : request.status,
//     );
//   }

//   List<Job> getJobs() {
//     return jobList.toList();
//   }
// }
