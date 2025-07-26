// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:baxton/features/klant_flow/authentication/auth_service/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:intl/intl.dart'; // Add this import

class KchatlistController extends GetxController {
  late IOWebSocketChannel channel;
  final RxBool isConnected = false.obs;
  final RxList<Map<String, dynamic>> chatList = <Map<String, dynamic>>[].obs;
  final RxList<String> messages = <String>[].obs;
  // ✅ Add time formatting method to controller
  String formatMessageTime(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '';

    try {
      // Parse the UTC time
      DateTime utcTime = DateTime.parse(isoString);

      // Convert to local time
      DateTime localTime = utcTime.toLocal();

      // Format as HH:mm (24-hour format)
      return DateFormat('HH:mm').format(localTime);

      // Alternative: 12-hour format with AM/PM
      // return DateFormat('h:mm a').format(localTime);
    } catch (e) {
      debugPrint('Error parsing time: $e');
      return '';
    }
  }

  // ✅ Optional: More advanced time formatting with Today/Yesterday logic
  String formatMessageTimeAdvanced(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '';

    try {
      DateTime utcTime = DateTime.parse(isoString);
      DateTime localTime = utcTime.toLocal();
      DateTime now = DateTime.now();

      // Check if it's today
      if (localTime.day == now.day &&
          localTime.month == now.month &&
          localTime.year == now.year) {
        return DateFormat('HH:mm').format(localTime); // Today: show time
      }

      // Check if it's yesterday
      DateTime yesterday = now.subtract(Duration(days: 1));
      if (localTime.day == yesterday.day &&
          localTime.month == yesterday.month &&
          localTime.year == yesterday.year) {
        return 'Gisteren'; // Yesterday in Dutch
      }

      // Check if it's within this week
      if (localTime.isAfter(now.subtract(Duration(days: 7)))) {
        return DateFormat(
          'EEEE',
        ).format(localTime); // Day name (Monday, Tuesday, etc.)
      }

      // Older messages: show date
      return DateFormat('dd/MM').format(localTime); // DD/MM format
    } catch (e) {
      debugPrint('Error parsing advanced time: $e');
      return '';
    }
  }

  @override
  void onInit() async {
    connectWebSocket();
    await connectToChatListSocket();
    ever(
      chatList,
      (_) => debugPrint('📊 chatList updated: ${chatList.length} items'),
    );
    ever(isConnected, (val) => debugPrint('🔌 isConnected changed: $val'));

    super.onInit();
  }

  Future<String> _getFcmToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final fCMToken = await firebaseMessaging.getToken();
    debugPrint('FCM Token: $fCMToken');
    return fCMToken ?? '';
  }

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

  Future<void> connectToChatListSocket() async {
    try {
      final token = await AuthService.getToken();
      debugPrint('🔑 Token: $token');
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};

      final socket = await WebSocket.connect(
        'wss://freepik.softvenceomega.com/ts/chat-list',
        headers: headers,
      );

      channel = IOWebSocketChannel(socket);
      isConnected.value = true;
      debugPrint('✅ Connected to chat-list socket');

      // Send initial event
      channel.sink.add(jsonEncode({"event": "get_chat_list"}));

      // ✅ CRITICAL: Listen for ALL WebSocket messages
      channel.stream.listen(
        (data) {
          debugPrint('📥 Raw WebSocket Data: $data');
          try {
            final decoded = jsonDecode(data);
            debugPrint('📥 Decoded Data: $decoded');
            _handleIncomingMessage(decoded);
          } catch (e) {
            debugPrint('❌ JSON decode error: $e');
          }
        },
        onDone: () {
          isConnected.value = false;
          debugPrint('🔌 WebSocket connection closed');
        },
        onError: (error) {
          isConnected.value = false;
          debugPrint('❗ WebSocket error: $error');
        },
      );
    } catch (e) {
      debugPrint('❗ Connection error: $e');
      isConnected.value = false;
    }
  }

  // ✅ Handle ALL incoming WebSocket messages
  void _handleIncomingMessage(Map<String, dynamic> message) {
    final messageType = message['type'];
    final event = message['event'];

    debugPrint('🔍 Message Type: $messageType, Event: $event');

    // Handle different message patterns your API might send
    if (messageType == 'chat_list' || event == 'chat_list') {
      _handleInitialChatList(message);
    } else if (messageType == 'chat_list_update') {
      _handleChatListUpdate(message);
    } else if (messageType == 'new_message' ||
        messageType == 'message' ||
        event == 'new_message' ||
        event == 'message_received' ||
        message.containsKey('lastMessage')) {
      _handleNewMessage(message);
    } else if (messageType == 'chat_update' || event == 'chat_update') {
      _handleChatUpdate(message);
    } else {
      // ✅ FALLBACK: Try to extract message data anyway
      debugPrint('🤷 Unknown message type, attempting to parse...');
      _attemptMessageExtraction(message);
    }
  }

  // Handle initial chat list
  void _handleInitialChatList(Map<String, dynamic> message) {
    try {
      final payload = message['payload'] ?? message['data'];
      if (payload != null) {
        chatList.value = List<Map<String, dynamic>>.from(payload);
        debugPrint('✅ Initial chat list loaded: ${chatList.length} chats');
      }
    } catch (e) {
      debugPrint('❌ Error handling initial chat list: $e');
    }
  }

  // ✅ Handle chat_list_update
  void _handleChatListUpdate(Map<String, dynamic> message) {
    try {
      final payload = message['payload'];
      if (payload != null && payload is List) {
        // Replace the entire chat list with the updated one
        chatList.value = List<Map<String, dynamic>>.from(payload);
        chatList.refresh(); // Force UI update
        debugPrint(
          '✅ Chat list updated via chat_list_update: ${chatList.length} chats',
        );
      }
    } catch (e) {
      debugPrint('❌ Error handling chat_list_update: $e');
    }
  }

  // ✅ CRITICAL: Handle new messages in real-time
  void _handleNewMessage(Map<String, dynamic> message) {
    try {
      debugPrint('🆕 Processing new message: $message');

      // Extract data from different possible structures
      final payload = message['payload'] ?? message['data'] ?? message;
      final chatId =
          payload['chatId'] ??
          payload['conversationId'] ??
          payload['roomId'] ??
          payload['id'];

      final newMessage =
          payload['message'] ?? payload['lastMessage'] ?? payload;

      if (chatId != null) {
        _updateChatLastMessage(chatId.toString(), newMessage);
      } else {
        // If no specific chat ID, try to match by other user info
        _updateChatByContent(newMessage);
      }
    } catch (e) {
      debugPrint('❌ Error handling new message: $e');
    }
  }

  // Update specific chat's last message
  void _updateChatLastMessage(String chatId, Map<String, dynamic> newMessage) {
    try {
      // Find the index of the chat by ID
      int index = chatList.indexWhere((chat) {
        final id = chat['id']?.toString() ?? chat['data']?['id']?.toString();
        return id == chatId;
      });

      if (index != -1) {
        // 🧠 Clone the entire map and inner data to ensure reactivity
        final oldChat = chatList[index];
        final newChat = Map<String, dynamic>.from(oldChat);
        final oldData = oldChat['data'] ?? {};
        final newData = Map<String, dynamic>.from(oldData);

        // 🧠 Prepare new last message
        final updatedLastMessage = {
          'content': newMessage['content'] ?? '...',
          'createdAt':
              newMessage['createdAt'] ?? DateTime.now().toIso8601String(),
          'senderId': newMessage['senderId'] ?? newMessage['from'],
          ...newMessage,
        };

        // 🧠 Update the new data
        newData['lastMessage'] = updatedLastMessage;
        newChat['data'] = newData;

        // ✅ Replace the old chat with the new one and move to top
        chatList.removeAt(index);
        chatList.insert(0, newChat); // move to top
        chatList.refresh(); // ✅ trigger UI update

        debugPrint('✅ Chat updated and UI should refresh');
      } else {
        debugPrint('❌ Chat not found, reloading chat list...');
        _requestFreshChatList();
      }
    } catch (e) {
      debugPrint('❌ Error updating chat: $e');
    }
  }

  // Fallback: update by message content matching
  void _updateChatByContent(Map<String, dynamic> newMessage) {
    try {
      final senderId = newMessage['senderId'] ?? newMessage['from'];
      if (senderId == null) return;

      for (int i = 0; i < chatList.length; i++) {
        final chat = chatList[i];
        final otherUserId =
            chat['data']?['otherUser']?['id'] ??
            chat['data']?['otherUser']?['_id'];

        if (otherUserId?.toString() == senderId.toString()) {
          _updateChatLastMessage(
            chat['id']?.toString() ?? i.toString(),
            newMessage,
          );
          break;
        }
      }
    } catch (e) {
      debugPrint('❌ Error updating chat by content: $e');
    }
  }

  // Handle chat updates
  void _handleChatUpdate(Map<String, dynamic> message) {
    try {
      final payload = message['payload'] ?? message['data'];
      if (payload != null) {
        final chatId = payload['id']?.toString() ?? payload['_id']?.toString();
        if (chatId != null) {
          _updateChatLastMessage(chatId, payload);
        }
      }
    } catch (e) {
      debugPrint('❌ Error handling chat update: $e');
    }
  }

  // Attempt to extract message from unknown format
  void _attemptMessageExtraction(Map<String, dynamic> message) {
    if (message.containsKey('content') ||
        message.containsKey('text') ||
        message.containsKey('message')) {
      _handleNewMessage(message);
    }
  }

  // Request fresh chat list
  void _requestFreshChatList() {
    if (isConnected.value) {
      debugPrint('🔄 Requesting fresh chat list...');
      channel.sink.add(jsonEncode({"event": "get_chat_list"}));
    }
  }

  // Manual refresh (for pull-to-refresh)
  Future<void> refreshChatList() async {
    debugPrint('🔄 Manual refresh requested...');
    if (isConnected.value) {
      _requestFreshChatList();
    } else {
      await connectToChatListSocket();
    }
  }

  void closeSocket() {
    try {
      if (isConnected.value) {
        channel.sink.close();
        isConnected.value = false;
      }
    } catch (e) {
      debugPrint('❌ Error closing socket: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('❗ KchatlistController disposed');
    closeSocket();
  }
}
