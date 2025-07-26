import 'dart:convert';
import 'package:baxton/features/werknemer_flow/werknemer_home/Huis/model/my_task_model.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class TaskRepository {
  final String baseUrl = "https://freepik.softvenceomega.com/ts";
  // final String baseUrl = "https://1aa6ef016c19.ngrok-free.app/ts";

  Future<List<MyTask>> fetchMyTasks(String token) async {
    final url = Uri.parse('$baseUrl/worker/my-tasks?status=CONFIRMED');

    final response = await http.get(
      url,
      headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      debugPrint('confirmed api hit ${response.body}');
      final jsonBody = json.decode(response.body);
      if (jsonBody['success'] == true) {
        final List tasksJson = jsonBody['data'];
        return tasksJson.map((e) => MyTask.fromJson(e)).toList();
      } else {
        throw Exception(jsonBody['message'] ?? 'Unknown error');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
