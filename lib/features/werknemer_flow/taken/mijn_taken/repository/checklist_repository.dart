import 'dart:convert';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:http/http.dart' as http;

class ChecklistRepository {
  final _baseUrl = 'https://freepik.softvenceomega.com/ts/worker';
  // final _baseUrl = 'https://1aa6ef016c19.ngrok-free.app/ts/worker';

  Future<Map<String, dynamic>> addChecklistItem({
    required String serviceRequestId,
    required String name,
  }) async {
    final token = await AuthService.getToken();
    final url = Uri.parse('$_baseUrl/add-task');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: jsonEncode({
        "name": name,
        "price": 0, // ✅ must pass price as 0
        "serviceRequestId": serviceRequestId,
      }),
    );

    final data = jsonDecode(response.body);
    return data; // { success, message, data }
  }

  Future<Map<String, dynamic>> updateChecklistDone({
    required String serviceRequestId,
    required String taskId,
    required bool done,
  }) async {
    final token = await AuthService.getToken();
    final url = Uri.parse('$_baseUrl/update-task');

    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: jsonEncode({
        "serviceRequestId": serviceRequestId,
        "taskId": taskId,
        "done": done,
      }),
    );

    final data = jsonDecode(response.body);
    return data;
  }
}
