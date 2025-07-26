import 'dart:convert';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:baxton/features/werknemer_flow/taken/mijn_taken/model/payment_pending_task_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PaymentPendingRepository {
  final String baseUrl = 'https://freepik.softvenceomega.com';
  // final String baseUrl = "https://1aa6ef016c19.ngrok-free.app";

  Future<List<PaymentPendingTaskModel>> fetchPaymentPendingTasks() async {
    final String? token = await AuthService.getToken();
    if (token == null) throw Exception('Token not found');

    final url = Uri.parse('$baseUrl/ts/worker/my-payment-pending');

    final response = await http.get(
      url,
      headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
    );

    debugPrint('📩 [PaymentPendingRepository] Status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      debugPrint('PaymentPendingData $data');
      final List<dynamic> rawList = data['data'] ?? [];

      // Filter only invoiceStatus == IN_PROGRESS
      final filteredList =
          rawList.where((e) {
            final invoice = e['Invoice'];
            return invoice != null && invoice['invoiceStatus'] == 'IN_PROGRESS';
          }).toList();

      return filteredList
          .map((e) => PaymentPendingTaskModel.fromJson(e))
          .toList();
    } else {
      throw Exception(
        'Failed to fetch Payment Pending tasks: ${response.body}',
      );
    }
  }
}
