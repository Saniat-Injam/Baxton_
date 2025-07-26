import 'dart:io';

import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class WChatController extends GetxController {
  final List<Map<String, String>> chats = [
    {
      "name": "Floyd Miles",
      "message": "Lorem ipsum dolor sit ...",
      "time": "7:56",
      "image": IconPath.chatlogo1,
      "isOnline": true.toString(),
    },
    {
      "name": "Samantha Green",
      "message": "Consectetur adipiscing elit ...",
      "time": "8:12",
      "image": IconPath.chatlogo2,
      "isOnline": false.toString(),
    },
    {
      "name": "Oliver Smith",
      "message": "Sed do eiusmod tempor ...",
      "time": "9:03",
      "image": IconPath.chatlogo3,
      "isOnline": false.toString(),
    },
    {
      "name": "Isabella Johnson",
      "message": "Ut enim ad minim veniam ...",
      "time": "10:45",
      "image": IconPath.chatlogo4,
      "isOnline": true.toString(),
    },
    {
      "name": "Liam Brown",
      "message": "Quis nostrud exercitation ...",
      "time": "11:20",
      "image": IconPath.chatlogo5,
      "isOnline": false.toString(),
    },
    {
      "name": "Mia Wilson",
      "message": "Duis aute irure dolor ...",
      "time": "12:15",
      "image": IconPath.chatlogo6,
      "isOnline": true.toString(),
    },
    {
      "name": "Noah Garcia",
      "message": "In reprehenderit in voluptate ...",
      "time": "13:30",
      "image": IconPath.chatlogo7,
      "isOnline": false.toString(),
    },
    {
      "name": "Emma Martinez",
      "message": "Excepteur sint occaecat ...",
      "time": "14:05",
      "image": IconPath.chatlogo8,
      "isOnline": true.toString(),
    },
    {
      "name": "Ava Taylor",
      "message": "Laboris nisi ut aliquip ...",
      "time": "15:22",
      "image": IconPath.chatlogo9,
      "isOnline": false.toString(),
    },
    {
      "name": "Emma Martinez",
      "message": "Excepteur sint occaecat ...",
      "time": "14:05",
      "image": IconPath.chatlogo8,
      "isOnline": false.toString(),
    },
  ];

  late IOWebSocketChannel channel;
  final RxList<String> messages = <String>[].obs;
  final RxBool isConnected = false.obs;
  @override
  void onInit() {
    super.onInit();
    debugPrint('🔥 onInit started');
    connectWebSocket();
  }

  Future<String> _getFcmToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final fCMToken = await firebaseMessaging.getToken();
    debugPrint('FCM Token: $fCMToken');
    return fCMToken ?? '';
  }

  // Future<void> connectWebSocket() async {
  //   try {
  //     final fcmToken = await _getFcmToken();
  //     final token = await AuthService.getToken();
  //     debugPrint('user Token from : $token');
  //     String baseUrl = 'wss://freepik.softvenceomega.com/ts/weak_up';
  //     final urlWithToken = '$baseUrl?fcm_token=$fcmToken';
  //     final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

  //     final socket = await WebSocket.connect(urlWithToken, headers: headers);
  //     channel = IOWebSocketChannel(socket);
  //     isConnected.value = true;
  //     channel.stream.listen(
  //       (data) {
  //         debugPrint('📥 Received: $data');
  //         messages.add(data.toString());
  //       },
  //       onError: (error) {
  //         isConnected.value = false;
  //         debugPrint('$error');
  //       },
  //       onDone: () {
  //         isConnected.value = false;
  //         debugPrint('webscoket closed');
  //       },
  //     );
  //   } catch (e) {
  //     debugPrint('not connected to webscoket $e');
  //   }
  // }
  Future<void> connectWebSocket() async {
    debugPrint('⚡ connectWebSocket() called');
    try {
      final fcmToken = await _getFcmToken();
      final token = await AuthService.getToken();
      debugPrint('✅ FCM Token: $fcmToken');
      debugPrint('✅ User Token: $token');

      String baseUrl = 'wss://freepik.softvenceomega.com/ts/weak_up';
      final urlWithToken = '$baseUrl?fcm_token=$fcmToken';
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

      debugPrint('🌐 Connecting to: $urlWithToken');

      final socket = await WebSocket.connect(urlWithToken, headers: headers);
      channel = IOWebSocketChannel(socket);
      isConnected.value = true;
      debugPrint('🔌 WebSocket connected');

      channel.stream.listen(
        (data) {
          debugPrint('📥 Received: $data');
          messages.add(data.toString());
        },
        onError: (error) {
          isConnected.value = false;
          debugPrint('❌ Error: $error');
        },
        onDone: () {
          isConnected.value = false;
          debugPrint('🔕 WebSocket closed');
        },
      );
    } catch (e) {
      debugPrint('❗ WebSocket connection error: $e');
    }
  }

  void closeSocket() {
    channel.sink.close();
    isConnected.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    closeSocket();
  }
}
