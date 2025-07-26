import 'dart:convert';
import 'dart:io';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PhotoRepository {
  Future<Map<String, dynamic>> uploadPhoto({
    required String taskId,
    required File file,
    bool? isPrev,
    required String caption,
  }) async {
    final String? token = await AuthService.getToken();
    final String baseUrl = 'https://freepik.softvenceomega.com/ts/worker';
    // final String baseUrl = "https://1aa6ef016c19.ngrok-free.app/ts/worker";
    final uri = Uri.parse('$baseUrl/add-service-after-before/$taskId');
    // 🔥 Debug what we are sending
    debugPrint('📤 [uploadPhoto] taskId: $taskId');
    debugPrint('📤 [uploadPhoto] caption: $caption');
    debugPrint('📤 [uploadPhoto] isPrev: $isPrev'); // 👈 log the isPrev value
    debugPrint('📤 [uploadPhoto] file path: ${file.path}');

    final request =
        http.MultipartRequest('POST', uri)
          ..headers.addAll({'Authorization': 'Bearer $token', 'accept': '*/*'})
          ..fields['caption'] = caption;
    // ✅ Always include isPrev field
    if (isPrev == true) {
      request.fields['isPrev'] = 'true';
      debugPrint('✅ [uploadPhoto] isPrev set to true');
    } else {
      // Send an empty value instead of skipping
      request.fields['isPrev'] = '';
      debugPrint('✅ [uploadPhoto] isPrev set to empty string');
    }

    // ✅ Add the image file with explicit content type
    request.files.add(
      await http.MultipartFile.fromPath(
        'pic',
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'jpeg'), // 👈 fix here
      ),
    );

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();

    if (streamedResponse.statusCode == 200 ||
        streamedResponse.statusCode == 201) {
      debugPrint('✅ photoUrldata: $responseBody');
      return jsonDecode(responseBody);
    } else {
      debugPrint(
        '❌ upload error: ${streamedResponse.statusCode} $responseBody',
      );
      return {
        'success': false,
        'message': 'Error: ${streamedResponse.statusCode} $responseBody',
      };
    }
  }
}
