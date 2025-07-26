import 'dart:convert';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ServicePriceRepository {
  final String baseUrl = 'https://freepik.softvenceomega.com/ts/worker';
  // final String baseUrl = "https://1aa6ef016c19.ngrok-free.app/ts/worker";

  /// Adds a service price breakdown
  Future<Map<String, dynamic>> addServicePriceBreakdown({
    required String serviceRequestId,
    required String serviceName,
    required double servicePrice,
  }) async {
    debugPrint('🔵 ServicePriceRepository: Starting addServicePriceBreakdown');
    debugPrint('🔵 ServiceRequestId: $serviceRequestId');
    debugPrint('🔵 ServiceName: $serviceName');
    debugPrint('🔵 ServicePrice: $servicePrice');

    // ✅ Get the token from AuthService
    final String? token = await AuthService.getToken();

    if (token == null || token.isEmpty) {
      debugPrint('🔴 ServicePriceRepository: No valid token found');
      throw 'No valid token found. Please log in again.';
    }

    debugPrint('🔵 ServicePriceRepository: Token retrieved successfully');

    final url = Uri.parse('$baseUrl/add-service-price-breakdown');
    debugPrint('🔵 ServicePriceRepository: API URL: $url');

    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'serviceRequestId': serviceRequestId,
    });

    debugPrint('🔵 ServicePriceRepository: Request headers: $headers');
    debugPrint('🔵 ServicePriceRepository: Request body: $body');

    try {
      debugPrint('🔵 ServicePriceRepository: Making HTTP POST request...');
      final response = await http.post(url, headers: headers, body: body);

      debugPrint(
        '🔵 ServicePriceRepository: Response status code: ${response.statusCode}',
      );
      debugPrint('🔵 ServicePriceRepository: Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint('🔵 ServicePriceRepository: Parsed response data: $data');

        if (data['success'] == true) {
          debugPrint('🟢 ServicePriceRepository: Request successful');
          return data;
        } else {
          final errorMessage = data['message'] ?? 'Something went wrong';
          debugPrint(
            '🔴 ServicePriceRepository: API returned error: $errorMessage',
          );
          throw errorMessage;
        }
      } else {
        final errorMessage = 'Error ${response.statusCode}: ${response.body}';
        debugPrint('🔴 ServicePriceRepository: HTTP error: $errorMessage');
        throw errorMessage;
      }
    } catch (e) {
      debugPrint('🔴 ServicePriceRepository: Exception occurred: $e');
      rethrow;
    }
  }
}
