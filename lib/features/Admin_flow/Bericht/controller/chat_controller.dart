import 'dart:io';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class BerichtChatController extends GetxController {
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
    connectWebSocket();
  }

  Future<String> _getFcmToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final fCMToken = await firebaseMessaging.getToken();
    debugPrint('FCM Token: $fCMToken');
    return fCMToken ?? '';
  }


  Future<void> connectWebSocket() async {
    debugPrint('Starting connectWebSocket function');
    try {
      debugPrint('Attempting to get FCM token');
      final fcmToken = await _getFcmToken();
      debugPrint('FCM token retrieved: $fcmToken');
      debugPrint('Attempting to get auth token');
      final token = await AuthService.getToken();
      debugPrint('Auth token retrieved: $token');

      String baseUrl = 'wss://freepik.softvenceomega.com/ts/weak_up';
      debugPrint('Base WebSocket URL: $baseUrl');

      final urlWithToken = '$baseUrl?fcm_token=$fcmToken';
      debugPrint('WebSocket URL with FCM token: $urlWithToken');

      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      debugPrint('Headers prepared: $headers');

      debugPrint('Attempting WebSocket connection');
      final socket = await WebSocket.connect(urlWithToken, headers: headers);
      debugPrint('WebSocket connected successfully');

      channel = IOWebSocketChannel(socket);
      debugPrint('IOWebSocketChannel initialized');

      isConnected.value = true;
      debugPrint('isConnected set to true');

      debugPrint('Setting up stream listener');
    } catch (e) {
      debugPrint('Failed to connect to WebSocket: $e');
    }
    debugPrint('connectWebSocket function completed');
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