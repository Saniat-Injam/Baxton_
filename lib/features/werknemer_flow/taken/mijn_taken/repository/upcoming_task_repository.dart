import 'dart:convert';

import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/task_details_model.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/upcoming_task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UpcomingTaskRepository {
  final String baseUrl = 'https://freepik.softvenceomega.com';
  // final String baseUrl = 'https://1aa6ef016c19.ngrok-free.app';

  Future<List<UpcomingTaskModel>> fetchUpcommingTask() async {
    final String? token = await AuthService.getToken();
    if (token == null) {
      throw Exception('Token not Found');
    }

    final url = Uri.parse('$baseUrl/ts/worker/non-price-task');
    final response = await http.get(
      url,
      headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('UpcomingListNonPrice $data');
      final List<dynamic> setPriceList = data['data'];
      return setPriceList.map((e) => UpcomingTaskModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch tasks: ${response.statusCode}');
    }
  }

  Future<TaskDetailsModel> getTaskDetails(String id) async {
    final String? token = await AuthService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final url = Uri.parse('$baseUrl/ts/service-request/get/$id');
    final response = await http.get(
      url,
      headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      debugPrint('non price list details ${response.body}');
      final data = jsonDecode(response.body);
      return TaskDetailsModel.fromJson(data);
    } else {
      throw Exception('Failed to load task details');
    }
  }

  Future<TaskDetailsModel> setPrice(String id, double price) async {
    debugPrint('🟡 [setPrice] Starting API call...');
    final String? token = await AuthService.getToken();
    debugPrint('🔑 [setPrice] Using token: $token');
    debugPrint('📌 [setPrice] Task ID: $id | Price: $price');

    final url = Uri.parse('$baseUrl/ts/worker/set-price');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: jsonEncode({"id": id, "price": price}),
    );

    debugPrint('📩 [setPrice] Status Code: ${response.statusCode}');
    debugPrint('📩 [setPrice] Raw Response: ${response.body}');

    // ✅ Accept both 200 and 201 as success
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      debugPrint('📦 [setPrice] Parsed JSON: $jsonData');

      if (jsonData['data'] != null) {
        debugPrint('✅ [setPrice] Price set successfully.');
        return TaskDetailsModel.fromJson(jsonData['data']);
      } else {
        debugPrint('⚠️ [setPrice] No data field in response.');
        throw Exception('Invalid response format: ${response.body}');
      }
    } else {
      debugPrint('❌ [setPrice] Failed with status: ${response.statusCode}');
      throw Exception('Failed to set price: ${response.body}');
    }
  }
}
