import 'package:baxton/features/klant_flow/task_screen/model/all_task_model.dart';

class ServiceResponse {
  final List<ServiceRequest> data;
  final String message;
  final bool success;

  ServiceResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<ServiceRequest> serviceRequests = list.map((i) => ServiceRequest.fromJson(i)).toList();

    return ServiceResponse(
      data: serviceRequests,
      message: json['message']?.toString() ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> serviceRequests = data.map((e) => e.toJson()).toList();
    return {
      'data': serviceRequests,
      'message': message,
      'success': success,
    };
  }
}