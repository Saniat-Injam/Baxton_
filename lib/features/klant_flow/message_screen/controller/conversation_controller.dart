// ignore_for_file: curly_braces_in_flow_control_structures, unused_local_variable

import 'dart:io';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:baxton/features/klant_flow/message_screen/models/message_model.dart';
import 'package:baxton/features/klant_flow/message_screen/services/chat_api_service.dart';
import 'package:baxton/features/klant_flow/message_screen/services/chat_websocket_service.dart';

class ConversationController extends GetxController {
  final String conversationId;

  ConversationController({required this.conversationId});

  // Services
  late ChatWebSocketService _webSocketService;

  // State
  final RxBool isConnected = false.obs;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isLoading = true.obs; // ✅ Add this back
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxBool noMoreMessages = false.obs;
  final RxBool isSending = false.obs;

  // Pagination - Following the correct flow
  final int pageSize = 20; // How many messages per request
  String? nextCursor; // ID of the oldest message we have (for next page)

  // UI State
  final RxBool isEmojiVisible = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString messageText = ''.obs;

  // Controllers
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Lifecycle flags
  bool _isDisposed = false;
  bool _isInitialized = false;

  @override
  void onInit() {
    super.onInit();
    debugPrint('🔄 ===== CONTROLLER INIT =====');
    debugPrint('🔄 Conversation ID: $conversationId');
    _initializeController();
  }

  void _initializeController() {
    if (_isDisposed) return;

    _setupWebSocket();
    _setupTextController();
    _setupScrollController();
    _loadInitialMessages();
    _isInitialized = true;
  }

  void _setupWebSocket() {
    if (_isDisposed) return;

    _webSocketService = ChatWebSocketService(
      conversationId: conversationId,
      onMessageReceived: _handleNewMessage,
      onConnectionChanged: (connected) {
        if (!_isDisposed && _isInitialized) {
          isConnected.value = connected;
        }
      },
    );
    _webSocketService.connect();
  }

  void _setupTextController() {
    if (_isDisposed) return;

    messageController.addListener(() {
      if (!_isDisposed && _isInitialized) {
        messageText.value = messageController.text;
      }
    });
  }

  void _setupScrollController() {
    if (_isDisposed) return;

    scrollController.addListener(() {
      // When user scrolls to top, load more (older) messages
      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        loadMoreMessages();
      }
    });
  }

  void _handleNewMessage(MessageModel message) {
    if (_isDisposed || !_isInitialized) return;

    debugPrint('📨 ===== NEW WEBSOCKET MESSAGE =====');
    debugPrint('📨 ID: ${message.id}');
    debugPrint('📨 Content: "${message.content}"');
    debugPrint('📨 Sender: ${message.name}');
    debugPrint('📨 Is Sender: ${message.isSender}');
    debugPrint('📨 Created At: ${message.createdAt}');

    // Check if message already exists
    final existingIndex = messages.indexWhere((msg) => msg.id == message.id);
    if (existingIndex != -1) {
      debugPrint('📨 ⚠️ Message already exists, skipping');
      return;
    }

    // Add new message to the end (it's the newest)
    messages.add(message);
    messages.refresh();

    debugPrint('📨 ✅ Message added. Total: ${messages.length}');

    // Smart scroll behavior like WhatsApp/Telegram:
    // - Always scroll for sender's own messages
    // - Only scroll for received messages if user is near bottom
    final shouldAutoScroll = message.isSender || isAtBottom;

    if (shouldAutoScroll) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isDisposed && _isInitialized) {
          _scrollToBottom(
            animate: message.isSender,
          ); // Animate for sent messages
        }
      });
      debugPrint('📨 ✅ Auto-scrolling to new message');
    } else {
      debugPrint('📨 ℹ️ User not at bottom, not auto-scrolling');
    }
  }

  // ✅ Step 1: Load initial messages (newest first)
  Future<void> _loadInitialMessages() async {
    if (_isDisposed) return;

    debugPrint('📥 ===== LOADING INITIAL MESSAGES =====');
    debugPrint('📥 Conversation ID: $conversationId');
    debugPrint('📥 Page Size: $pageSize');
    debugPrint('📥 Cursor: null (first page)');

    isLoading.value = true;
    isLoadingMore.value = false;

    try {
      // ✅ Fetch initial messages (API already gives oldest → newest)
      final fetchedMessages = await ChatApiService.getMessages(
        conversationId: conversationId,
        take: pageSize,
      );

      debugPrint('📥 ===== INITIAL LOAD RESULT =====');
      debugPrint('📥 Fetched: ${fetchedMessages.length} messages');

      messages.clear(); // clear previous
      messages.addAll(fetchedMessages); // ✅ use as-is (no reverse)

      // ✅ Set pagination cursor (oldest message id)
      if (fetchedMessages.isNotEmpty) {
        nextCursor = fetchedMessages.first.id; // oldest in this page
        debugPrint('📥 Next Cursor (oldest message ID): $nextCursor');

        if (fetchedMessages.length < pageSize) {
          hasMore.value = false;
          noMoreMessages.value = true;
        } else {
          hasMore.value = true;
        }

        // ✅ Scroll to bottom (latest)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isDisposed && _isInitialized && scrollController.hasClients) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (!_isDisposed && scrollController.hasClients) {
                _scrollToBottom(animate: false);
                debugPrint('📥 ✅ Initial scroll to bottom completed');
              }
            });
          }
        });
      } else {
        // no messages
        hasMore.value = false;
        noMoreMessages.value = true;
      }

      messages.refresh();
    } catch (e) {
      debugPrint('📥 ❌ Error loading initial messages: $e');
      if (!_isDisposed && _isInitialized) {
        Get.snackbar('Error', 'Failed to load messages: $e');
      }
    } finally {
      if (!_isDisposed) {
        isLoading.value = false;
      }
    }
  }

  // ✅ Step 3: Load more messages when user scrolls up
  Future<void> loadMoreMessages() async {
    if (!hasMore.value || isLoadingMore.value || _isDisposed) return;

    isLoadingMore.value = true;

    try {
      debugPrint('📥 ===== LOADING MORE MESSAGES =====');
      debugPrint('📥 Current nextCursor: $nextCursor');

      // ✅ Fetch older messages before current oldest
      final fetchedMessages = await ChatApiService.getMessages(
        conversationId: conversationId,
        take: pageSize,
        cursor: nextCursor,
      );

      if (fetchedMessages.isNotEmpty) {
        // ✅ Insert at top (older messages)
        messages.insertAll(0, fetchedMessages); // use as-is (no reverse)

        // ✅ Update cursor for next pagination
        nextCursor = fetchedMessages.first.id; // oldest in this new batch
        debugPrint('📥 New nextCursor: $nextCursor');
      } else {
        hasMore.value = false;
        noMoreMessages.value = true;
      }

      messages.refresh();
    } catch (e) {
      debugPrint('📥 ❌ Error loading more messages: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> sendMessage() async {
    if (_isDisposed) return;

    final content = messageController.text.trim();
    final file = selectedImage.value;

    if (content.isEmpty && file == null) {
      debugPrint('📤 ⚠️ Cannot send empty message');
      return;
    }
    if (file != null && content.isEmpty) {
      _showImageRequiresTextMessage();
      return;
    }

    debugPrint('📤 ===== SENDING MESSAGE =====');
    debugPrint('📤 Content: "$content"');
    debugPrint('📤 Has File: ${file != null}');

    isSending.value = true;

    try {
      final sentMessage = await ChatApiService.sendMessage(
        conversationId: conversationId,
        content: content,
        file: file,
      );

      debugPrint('📤 ===== MESSAGE SENT =====');
      debugPrint('📤 ID: ${sentMessage.id}');
      debugPrint('📤 Content: "${sentMessage.content}"');
      debugPrint('📤 Created At: ${sentMessage.createdAt}');

      // Check if message already exists (might have come via WebSocket)
      final existingIndex = messages.indexWhere(
        (msg) => msg.id == sentMessage.id,
      );

      if (existingIndex == -1) {
        // Add sent message to the end (it's the newest)
        messages.add(sentMessage);
        messages.refresh();
        debugPrint('📤 ✅ Sent message added to UI. Total: ${messages.length}');
      } else {
        debugPrint('📤 ⚠️ Sent message already exists in list');
      }

      _clearInput();

      // Always scroll to bottom after sending (like all messaging apps)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isDisposed && _isInitialized) {
          _scrollToBottom(animate: true); // Smooth animation for sent messages
        }
      });
    } catch (e) {
      debugPrint('📤 ❌ Error sending message: $e');
      if (!_isDisposed && _isInitialized) {
        Get.snackbar('Error', 'Failed to send message: $e');
      }
    } finally {
      if (!_isDisposed) {
        isSending.value = false;
      }
    }
  }

  void _showImageRequiresTextMessage() {
    if (_isDisposed) return;

    Get.showSnackbar(
      GetSnackBar(
        title: "Add a message",
        message:
            "Please add a text message with your image for better communication",
        // icon: Container(
        //   padding: const EdgeInsets.all(6),
        //   decoration: BoxDecoration(
        //     color: Colors.white.withOpacity(0.2),
        //     borderRadius: BorderRadius.circular(6),
        //   ),
        //   child: const Icon(Icons.image, color: Colors.white, size: 18),
        // ),
        backgroundColor: AppColors.primaryGold,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        borderRadius: 12,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 600),
        shouldIconPulse: true,
        mainButton: TextButton(
          onPressed: () {
            Get.back(); // Close snackbar
          },
          child: const Text(
            'GOT IT',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> refreshMessages() async {
    if (_isDisposed) return;

    debugPrint('🔄 ===== REFRESHING MESSAGES =====');

    // Reset pagination state
    nextCursor = null;
    hasMore.value = true;
    noMoreMessages.value = false;
    messages.clear();

    // Load fresh messages
    await _loadInitialMessages();
    // Initial load will handle scrolling to bottom
  }

  void _clearInput() {
    if (_isDisposed) return;

    messageController.clear();
    messageText.value = '';
    selectedImage.value = null;
    isEmojiVisible.value = false;
  }

  void scrollToBottomWhenReady({int attempt = 0}) {
    if (!_isDisposed && scrollController.hasClients) {
      final maxScroll = scrollController.position.maxScrollExtent;
      debugPrint(
        'Attempt $attempt: maxScrollExtent=$maxScroll, messages=${messages.length}',
      );
      if (maxScroll > 0) {
        scrollController.jumpTo(maxScroll);
        debugPrint('📥 ✅ Initial scroll to bottom completed');
      } else if (attempt < 10) {
        Future.delayed(const Duration(milliseconds: 200), () {
          scrollToBottomWhenReady(attempt: attempt + 1);
        });
      } else {
        debugPrint('📥 ⚠️ ListView not ready after multiple attempts');
      }
    }
  }

  void _scrollToBottom({bool animate = true}) {
    if (!_isDisposed && scrollController.hasClients) {
      final maxScroll = scrollController.position.maxScrollExtent;

      if (animate) {
        scrollController.animateTo(
          maxScroll,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        scrollController.jumpTo(maxScroll);
      }
    }
  }

  void scrollToBottom({bool animate = true}) {
    _scrollToBottom(animate: animate);
  }

  bool get isAtBottom {
    if (!scrollController.hasClients) return true;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    // Consider user "at bottom" if within 100 pixels of bottom
    // This gives a better UX - user doesn't need to be exactly at bottom
    return (maxScroll - currentScroll) <= 100;
  }

  // Image Picker
  Future<void> showImagePickerOptions() async {
    if (_isDisposed) return;

    final ImagePicker picker = ImagePicker();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImagePickerOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  color: Colors.blue,
                  onTap: () async {
                    Get.back();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                    );
                    if (image != null && !_isDisposed) {
                      selectedImage.value = File(image.path);
                    }
                  },
                ),
                _buildImagePickerOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  color: Colors.green,
                  onTap: () async {
                    Get.back();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (image != null && !_isDisposed) {
                      selectedImage.value = File(image.path);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  void clearSelectedImage() {
    if (!_isDisposed) {
      selectedImage.value = null;
    }
  }

  // Emoji Methods
  void toggleEmojiPicker() {
    if (!_isDisposed) {
      isEmojiVisible.value = !isEmojiVisible.value;
    }
  }

  void hideEmojiPicker() {
    if (!_isDisposed) {
      isEmojiVisible.value = false;
    }
  }

  void addEmoji(String emoji) {
    if (_isDisposed) return;

    final currentText = messageController.text;
    final currentPosition = messageController.selection.start;

    if (currentPosition < 0) {
      messageController.text = currentText + emoji;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: messageController.text.length),
      );
    } else {
      final newText =
          currentText.substring(0, currentPosition) +
          emoji +
          currentText.substring(currentPosition);
      messageController.text = newText;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: currentPosition + emoji.length),
      );
    }

    messageText.value = messageController.text;
  }

  // Enhanced debug method
  void printDebugInfo() {
    debugPrint('🔍 ===== CONVERSATION DEBUG INFO =====');
    debugPrint('🔍 Conversation ID: $conversationId');
    debugPrint('🔍 Messages Count: ${messages.length}');
    debugPrint('🔍 WebSocket Connected: ${isConnected.value}');
    debugPrint('🔍 Is Loading (Initial): ${isLoading.value}');
    debugPrint('🔍 Is Loading More: ${isLoadingMore.value}');
    debugPrint('🔍 Is Sending: ${isSending.value}');
    debugPrint('🔍 Has More Messages: ${hasMore.value}');
    debugPrint('🔍 No More Messages: ${noMoreMessages.value}');
    debugPrint('🔍 Next Cursor: $nextCursor');
    debugPrint('🔍 Page Size: $pageSize');
    debugPrint('🔍 Current Message Text: "${messageText.value}"');
    debugPrint('🔍 Selected Image: ${selectedImage.value?.path ?? 'None'}');
    debugPrint('🔍 Emoji Picker Visible: ${isEmojiVisible.value}');
    debugPrint('🔍 Is Disposed: $_isDisposed');
    debugPrint('🔍 Is Initialized: $_isInitialized');

    if (messages.isNotEmpty) {
      debugPrint('🔍 ===== MESSAGE TIMELINE =====');
      debugPrint('🔍 Oldest Message (first in list):');
      debugPrint('    ID: ${messages.first.id}');
      debugPrint('    Content: "${messages.first.content}"');
      debugPrint('    Created: ${messages.first.createdAt}');
      debugPrint('    Sender: ${messages.first.name}');

      debugPrint('🔍 Newest Message (last in list):');
      debugPrint('    ID: ${messages.last.id}');
      debugPrint('    Content: "${messages.last.content}"');
      debugPrint('    Created: ${messages.last.createdAt}');
      debugPrint('    Sender: ${messages.last.name}');

      debugPrint('🔍 ===== PAGINATION STATUS =====');
      debugPrint('🔍 Next cursor will be: $nextCursor');
      debugPrint('🔍 Can load more: ${hasMore.value}');

      // Show last 3 messages for context
      debugPrint('🔍 ===== RECENT MESSAGES =====');
      final recentCount = messages.length > 3 ? 3 : messages.length;
      for (int i = messages.length - recentCount; i < messages.length; i++) {
        final msg = messages[i];
        debugPrint('🔍 [$i] ${msg.createdAt} - "${msg.content}" (${msg.name})');
      }
    } else {
      debugPrint('🔍 ⚠️ No messages in list');
    }

    debugPrint('🔍 =====================================');
  }

  @override
  void onClose() {
    debugPrint('🗑️ ===== CONTROLLER DISPOSAL =====');
    debugPrint('🗑️ Conversation ID: $conversationId');

    _isDisposed = true;
    _isInitialized = false;

    // Print final state
    printDebugInfo();

    // Dispose services and controllers
    try {
      _webSocketService.dispose();
    } catch (e) {
      debugPrint('🗑️ ❌ WebSocket disposal error: $e');
    }

    try {
      messageController.dispose();
    } catch (e) {
      debugPrint('🗑️ ❌ Message controller disposal error: $e');
    }

    try {
      scrollController.dispose();
    } catch (e) {
      debugPrint('🗑️ ❌ Scroll controller disposal error: $e');
    }

    super.onClose();
    debugPrint('🗑️ ✅ Controller disposal completed');
  }
}
