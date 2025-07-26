import 'dart:convert';
import 'dart:io';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/werknemer_flow/profile_setup/model/worker_specialist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var specialistList = <WorkerSpecialist>[].obs;
  var selectedSpecialist = Rxn<WorkerSpecialist>();
  final Rx<String?> selectedMonth = Rx<String?>(null);
  final Rx<String?> selectedTaaktype = Rx<String?>(null);
  final Rx<String?> selectedTaakStatus = Rx<String?>(null);
  final Rx<String?> selectedYear = Rx<String?>(null);
  @override
  void onInit() {
    fetchSpecialists();
    super.onInit();
  }

  void setSelectedTaakStatus(String? status) {
    debugPrint('Setting selectedTaakStatus: $status');
    selectedTaakStatus.value = status;
  }

  bool get allFiltersSelected {
    final result =
        selectedMonth.value != null &&
        selectedYear.value != null &&
        selectedTaaktype.value != null &&
        selectedTaakStatus.value != null;
    debugPrint('allFiltersSelected checked: $result');
    return result;
  }

  void setSelectedYear(String? year) {
    debugPrint('Setting selectedYear: $year');
    selectedYear.value = year;
  }

  void clearAllFilters() {
    debugPrint('Clearing all filters');
    selectedMonth.value = null;
    selectedTaaktype.value = null;
    selectedTaakStatus.value = null;
    selectedYear.value = null;
    debugPrint('All filters cleared');
  }

  void selectSpecialist(WorkerSpecialist value) {
    debugPrint("Selected: ${value.name} (ID: ${value.id})");
    selectedSpecialist.value = value;
  }

  void setSelectedMonth(String? month) {
    debugPrint('Setting selectedMonth: $month');
    selectedMonth.value = month;
  }

  Future<void> fetchSpecialists() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        debugPrint("Token not found");
        return;
      }

      final url = Uri.parse(
        "https://freepik.softvenceomega.com/ts/meta/worker-specialist-type",
      );

      final response =
          await HttpClient().getUrl(url)
            ..headers.set("Authorization", "Bearer $token")
            ..headers.set("accept", "*/*");

      final result = await response.close();

      if (result.statusCode == 200) {
        final jsonStr = await result.transform(utf8.decoder).join();
        final List<dynamic> jsonData = jsonDecode(jsonStr);
        specialistList.value =
            jsonData.map((e) => WorkerSpecialist.fromJson(e)).toList();
      } else {
        debugPrint("Failed to fetch: ${result.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception during fetchSpecialists: $e");
    }
  }
}
