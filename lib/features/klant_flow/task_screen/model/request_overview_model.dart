import 'package:baxton/features/klant_flow/task_screen/model/all_task_model.dart';
import 'package:flutter/material.dart';

class RequestOverview {
  final List<ServiceRequest> requested;
  final List<ServiceRequest> confirmed;
  final List<ServiceRequest> completed;
  final String message;
  final bool success;

  RequestOverview({
    required this.requested,
    required this.confirmed,
    required this.completed,
    required this.message,
    required this.success,
  });

  factory RequestOverview.fromJson(Map<String, dynamic> json) {
    debugPrint('RequestOverview Raw Data: ${json['data']}');
    var requestedList = json['data']['requested'] as List? ?? [];
    var confirmedList = json['data']['confirmed'] as List? ?? [];
    var completedList = json['data']['completed'] as List? ?? [];

    // Filter out empty objects
    requestedList = requestedList.where((item) => item is Map && item.isNotEmpty).toList();
    confirmedList = confirmedList.where((item) => item is Map && item.isNotEmpty).toList();
    completedList = completedList.where((item) => item is Map && item.isNotEmpty).toList();

    debugPrint('Requested List (filtered): $requestedList');

    return RequestOverview(
      requested: requestedList.map((i) => ServiceRequest.fromJson(i)).toList(),
      confirmed: confirmedList.map((i) => ServiceRequest.fromJson(i)).toList(),
      completed: completedList.map((i) => ServiceRequest.fromJson(i)).toList(),
      message: json['message']?.toString() ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'requested': requested.map((e) => e.toJson()).toList(),
        'confirmed': confirmed.map((e) => e.toJson()).toList(),
        'completed': completed.map((e) => e.toJson()).toList(),
      },
      'message': message,
      'success': success,
    };
  }
}