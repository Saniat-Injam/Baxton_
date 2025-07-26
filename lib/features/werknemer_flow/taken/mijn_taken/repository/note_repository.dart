import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';

class NoteRepository {
  final String _baseUrl = 'https://freepik.softvenceomega.com/ts/worker';
  // final String _baseUrl = "https://1aa6ef016c19.ngrok-free.app/ts/worker";

  Future<Map<String, dynamic>> completeTask({
    required String taskId,
    required String note,
  }) async {
    try {
      final token = await AuthService.getToken();
      final url = Uri.parse('$_baseUrl/completed-task/$taskId');

      debugPrint('📤 [completeTask] Hitting: $url');
      debugPrint('📝 [completeTask] note: $note');

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: jsonEncode({'note': note}),
      );

      debugPrint('📥 [completeTask] Status: ${response.statusCode}');
      debugPrint('📥 [completeTask] Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message':
              'Error: ${response.statusCode} ${response.reasonPhrase} ${response.body}',
        };
      }
    } catch (e) {
      debugPrint('❌ [completeTask] Exception: $e');
      return {'success': false, 'message': 'Exception: $e'};
    }
  }
}
