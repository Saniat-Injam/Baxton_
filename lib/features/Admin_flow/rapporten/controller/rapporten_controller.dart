// import 'package:get/get.dart';

// class RapportenController extends GetxController {
//   var tasksCompleted = 120.obs;
//   var tasksPending = 25.obs;
//   var totalEmployees = 15.obs;
//   var revenue = 10000.obs;
//   var revenueGrowth = 5.34.obs;

//   void updateStats() {
//     // Simulate stats update
//     tasksCompleted.value = 125;
//     tasksPending.value = 20;
//     totalEmployees.value = 16;
//     revenue.value = 11000;
//     revenueGrowth.value = 6.45;
//   }

//   List<Map<String, dynamic>> reviews = [
//     {
//       'name': 'Emily Parker',
//       'profileImage': 'assets/icons/profilepic.png',
//       'rating': 4.5,
//       'reviewText':
//           'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
//     },
//     {
//       'name': 'John Doe',
//       'profileImage': 'assets/icons/profilepic.png',
//       'rating': 5.0,
//       'reviewText':
//           'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
//     },
//     {
//       'name': 'Emily Parker',
//       'profileImage': 'assets/icons/profilepic.png',
//       'rating': 4.5,
//       'reviewText':
//           'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
//     },
//     {
//       'name': 'John Doe',
//       'profileImage': 'assets/icons/profilepic.png',
//       'rating': 5.0,
//       'reviewText':
//           'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
//     },
//     // Add more reviews as needed
//   ];

//   var totalTasks = 40.obs;
//   var inBehandeling = 50.0.obs; // 50%
//   var nietToegewezen = 25.0.obs; // 25%
//   var voltooid = 20.0.obs; // 20%

//   @override
//   // ignore: unnecessary_overrides
//   void onInit() {
//     super.onInit();
//     // Initialize data if needed
//   }

//   var selectedValue = 'Deze Maand'.obs;

//   // Update the selected value when user selects a new option
//   void updateSelectedValue(String newValue) {
//     selectedValue.value = newValue;
//   }
// }

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:baxton/features/Admin_flow/rapporten/model/month_model.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RapportenController extends GetxController {
  var tasksCompleted = 120.obs;
  var tasksPending = 25.obs;
  var totalEmployees = 15.obs;
  var revenue = 10000.obs;
  var revenueGrowth = 5.34.obs;

  var totalTasks = 40.obs;
  var inBehandeling = 50.0.obs; // 50%
  var nietToegewezen = 25.0.obs; // 25%
  var voltooid = 20.0.obs; // 20%

  var averageRating = 4.5.obs; // For UI display
  var positivePercentage = 92.obs; // For UI display

  var isLoading = false.obs; // Loading state

  var selectedValue = 'Deze Maand'.obs;

  var reviews = <Map<String, dynamic>>[].obs; // RxList<Map<String, dynamic>>

  @override
  void onInit() {
    super.onInit();
    // Initialize reviews with default data
    reviews.assignAll([
      <String, dynamic>{
        'name': 'Emily Parker',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 4.5,
        'reviewText':
            'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
      },
      <String, dynamic>{
        'name': 'John Doe',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 5.0,
        'reviewText':
            'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
      },
      <String, dynamic>{
        'name': 'Emily Parker',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 4.5,
        'reviewText':
            'Lorem ipsum dolor sit amet \nconsectetur. Diam sagittis \ncursus volutpat leo nibh dui maecenas.',
      },
      <String, dynamic>{
        'name': 'John Doe',
        'profileImage': 'assets/icons/profilepic.png',
        'rating': 5.0,
        'reviewText':
            'Amazing service! The \nteam was quick and professional. \nHighly recommend!',
      },
    ]);
    // Call API with 'thisMonth' when the screen is initialized
    fetchReportData('thisMonth');
  }

  // Update the selected value and fetch new data
  void updateSelectedValue(String newValue) {
    selectedValue.value = newValue;
    // Map dropdown value to API query
    String query = newValue == 'Deze Maand' ? 'thisMonth' : 'lastMonth';
    fetchReportData(query);
  }

  // Function to fetch data from the API
  Future<void> fetchReportData(String query) async {
    try {
      debugPrint('Fetching token...');
      String? token = await AuthService.getToken();
      debugPrint(
        'Token retrieved: ${token != null ? 'Valid token' : 'Null or empty token'}',
      );

      // Handle case where token is missing
      if (token == null || token.isEmpty) {
        debugPrint('No token found. User is not authenticated.');
        await EasyLoading.showError('Authentication error: No token available');
        throw Exception('Token is not available');
      }

      isLoading.value = true; // Start loading
      debugPrint('Loading started...');

      // Prepare the URL
      final url = Uri.parse(
        'https://freepik.softvenceomega.com/ts/admin/report-analyses?query=$query',
      );
      debugPrint('URL: $url');

      // Send GET request with Authorization header
      debugPrint('Sending GET request with token...');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('Response received: ${response.statusCode}');

      // Check for response status and handle accordingly
      if (response.statusCode == 200) {
        debugPrint('Response status is OK (200). Processing data...');

        try {
          // Parse the JSON response using Month model
          final month = monthFromJson(response.body);
          debugPrint('JSON response parsed successfully: ${month.toJson()}');

          // Update observables with data from Month model
          tasksCompleted.value =
              month.monthlyCompletionRate.totalCompletedTasks;
          debugPrint('tasksCompleted: ${tasksCompleted.value}');

          tasksPending.value = month.pendingServiceRequestsCount;
          debugPrint('tasksPending: ${tasksPending.value}');

          totalEmployees.value = month.totalWorkerCount;
          debugPrint('totalEmployees: ${totalEmployees.value}');

          revenue.value = month.confirmedInvoicesLineChartData.totalRevenue;
          debugPrint('revenue: ${revenue.value}');

          revenueGrowth.value =
              month.monthlyTurnoverReport.progressRate.toDouble();
          debugPrint('revenueGrowth: ${revenueGrowth.value}');

          totalTasks.value = month.monthlyCompletionRate.currentMonth;
          debugPrint('totalTasks: ${totalTasks.value}');

          // Update rating and positive percentage for UI
          averageRating.value = month.averageRatingAndReviews.averageRating;
          debugPrint('averageRating: ${averageRating.value}');

          positivePercentage.value =
              month.averageRatingAndReviews.positivePercentage;
          debugPrint('positivePercentage: ${positivePercentage.value}');

          // Calculate task status percentages
          int totalStatusCount = month.taskStatus.fold(
            0,
            (sum, status) => sum + status.count.status,
          );

          if (totalStatusCount > 0) {
            month.taskStatus.forEach((status) {
              double percentage =
                  (status.count.status / totalStatusCount) * 100;
              if (status.status.toLowerCase() == 'in behandeling') {
                inBehandeling.value = percentage;
                debugPrint('inBehandeling: ${inBehandeling.value}');
              } else if (status.status.toLowerCase() == 'niet toegewezen') {
                nietToegewezen.value = percentage;
                debugPrint('nietToegewezen: ${nietToegewezen.value}');
              } else if (status.status.toLowerCase() == 'voltooid') {
                voltooid.value = percentage;
                debugPrint('voltooid: ${voltooid.value}');
              }
            });
          }

          // Update reviews from averageRatingAndReviews.firstThreeReviews
          if (month.averageRatingAndReviews.firstThreeReviews.isNotEmpty) {
            reviews.assignAll(
              month.averageRatingAndReviews.firstThreeReviews.map((review) {
                return <String, dynamic>{
                  'name': review.clientProfile.userName,
                  'profileImage':
                      review.clientProfile.profilePic.url.isNotEmpty
                          ? review.clientProfile.profilePic.url
                          : 'assets/icons/profilepic.png',
                  'rating': review.rating.toDouble(),
                  'reviewText': review.review,
                };
              }).toList(),
            );
            debugPrint('reviews: ${reviews.toString()}');
          } else {
            debugPrint('No reviews available from API');
            reviews.clear();
          }
        } catch (jsonError) {
          // Handle JSON parsing errors
          debugPrint('Error parsing JSON response: $jsonError');
          await EasyLoading.showError('Failed to parse data from the server');
        }
      } else {
        // Handle different HTTP status codes
        debugPrint(
          'Response status code is not OK. Status code: ${response.statusCode}',
        );
        String errorMessage =
            'Failed to fetch report data: ${response.statusCode}';

        if (response.statusCode == 401) {
          errorMessage = 'Unauthorized: Invalid or expired token';
          // Optionally redirect to login screen
          // Get.offAllNamed('/login');
        } else if (response.statusCode == 404) {
          errorMessage = 'Resource not found';
        } else if (response.statusCode == 500) {
          errorMessage = 'Internal server error';
        }
        await EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      // Handle general errors
      debugPrint('An error occurred: $e');
      await EasyLoading.showError('An error occurred: $e');
    } finally {
      isLoading.value = false; // Stop loading
      debugPrint('Loading finished');
    }
  }

  RxList<TaskTypeStatistic> taskStats = <TaskTypeStatistic>[].obs;

  // Example: call this after fetching your JSON
  void loadData(Map<String, dynamic> json) {
    final list = json['taskTypeStatistics'] as List<dynamic>;
    taskStats.value = list.map((e) => TaskTypeStatistic.fromJson(e)).toList();
    isLoading.value = false;
  }
}
