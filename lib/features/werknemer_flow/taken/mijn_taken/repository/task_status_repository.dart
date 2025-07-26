import 'dart:convert';

import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/task_status_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskStatusRepository {
  final String baseUrl = "https://freepik.softvenceomega.com";
  // final String baseUrl = "https://1aa6ef016c19.ngrok-free.app";

  Future<List<TaskStatusModel>> fetchTasks(String status) async {
    final String? token = await AuthService.getToken();
    if (token == null) throw Exception('Token not found');
    // final url = Uri.parse(
    //   "$baseUrl/ts/worker/my-tasks?take=10&skip=0&status=$status",
    // );
    final url = Uri.parse("$baseUrl/ts/worker/my-tasks?status=$status");
    final response = await http.get(
      url,
      headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      debugPrint(' 📩 [TaskStatusRepository] ${response.body}');
      final body = jsonDecode(response.body);
      if (body['success'] == true) {
        final List data = body['data'] ?? [];
        return data.map((e) => TaskStatusModel.fromJson(e)).toList();
      } else {
        throw Exception(body['message'] ?? 'Unknown error');
      }
    } else {
      throw Exception(
        'Failed with status: ${response.statusCode}, body: ${response.body}',
      );
    }
  }
}
