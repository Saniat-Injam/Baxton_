// ignore_for_file: deprecated_member_use, unused_element

import 'package:baxton/features/werknemer_flow/chatting/widgets/custom_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/message_screen/controller/conversation_controller.dart';
import 'package:baxton/features/klant_flow/message_screen/models/message_model.dart';
import 'package:baxton/features/klant_flow/message_screen/screens/full_image.dart';

class ConversationScreen extends StatefulWidget {
  final Map<String, dynamic> chat;
  final String conversetionID;

  const ConversationScreen({
    super.key,
    required this.chat,
    required this.conversetionID,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with WidgetsBindingObserver {
  late ConversationController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    controller = Get.put(
      ConversationController(conversationId: widget.conversetionID),
      tag: widget.conversetionID,
    );

    focusNode = FocusNode();
    focusNode.addListener(() {
      // Check if controller is still available before using it
      if (Get.isRegistered<ConversationController>(
        tag: widget.conversetionID,
      )) {
        if (focusNode.hasFocus) {
          controller.hideEmojiPicker();
        }
      }
    });
  }

  @override
  void dispose() {
    debugPrint('🔥 Disposing ConversationScreen'); // Debug log

    // Remove observer
    WidgetsBinding.instance.removeObserver(this);

    // Unfocus and dispose focus node first
    focusNode.unfocus();
    focusNode.dispose();

    // Then dispose controller
    try {
      if (Get.isRegistered<ConversationController>(
        tag: widget.conversetionID,
      )) {
        Get.delete<ConversationController>(tag: widget.conversetionID);
      }
    } catch (e) {
      debugPrint('🔥 Controller already disposed: $e');
    }

    super.dispose();
  }

  void _handleBackNavigation() {
    // Unfocus text field first
    focusNode.unfocus();

    // Small delay to ensure unfocus completes
    Future.delayed(const Duration(milliseconds: 50), () {
      try {
        if (Get.isRegistered<ConversationController>(
          tag: widget.conversetionID,
        )) {
          Get.delete<ConversationController>(tag: widget.conversetionID);
        }
      } catch (e) {
        debugPrint('🔥 Error during back navigation cleanup: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Connection status or other header widgets (optional)
          // _buildConnectionStatus(),

          // Messages list (fills available space)
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _buildInitialLoadingView();
              }
              if (controller.messages.isEmpty) {
                return _buildEmptyView();
              }
              return _buildMessagesList();
            }),
          ),

          // Selected image preview (optional, above input)
          Obx(() {
            if (controller.selectedImage.value != null) {
              return _buildSelectedImagePreview();
            }
            return const SizedBox.shrink();
          }),

          _buildMessageInputArea(),
          _buildEmojiPicker(),
        ],
      ),
    );
  }

  // ✅ Header/AppBar Section
  PreferredSizeWidget _buildAppBar() {
    final otherUser = widget.chat['data']?['otherUser'];
    final userName = otherUser?['name'] ?? 'User';
    final imageUrl = otherUser?['profilePic']?['url'];

    return AppBar(
      backgroundColor: AppColors.textWhite,
      elevation: 15,
      leading: _buildBackButton(),
      // leadingWidth: 20,
      title: _buildAppBarTitle(userName, imageUrl),
      // actions: _buildAppBarActions(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        side: BorderSide(
          color: Colors.grey, // 👈 your border color here
          width: 1, // 👈 thickness
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        width: 40,
        height: 40,
        // color: Colors.red,
        child: IconButton(
          padding: EdgeInsets.zero, // ✅ Remove default padding
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          // Image.asset(
          //   IconPath.arrowleft,
          //   width: 16,
          //   height: 12,
          //   color: AppColors.textPrimary,
          // ),
        ),
      ),
    );
  }

  Widget _buildAppBarTitle(String userName, String? imageUrl) {
    return Row(
      children: [
        _buildUserAvatar(imageUrl),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              _buildConnectionStatus(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserAvatar(String? imageUrl) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      backgroundImage:
          (imageUrl != null &&
                  imageUrl.isNotEmpty &&
                  imageUrl.trim() != "" &&
                  imageUrl != "null")
              ? NetworkImage(imageUrl)
              : null,
      child:
          (imageUrl == null ||
                  imageUrl.isEmpty ||
                  imageUrl.trim() == "" ||
                  imageUrl == "null")
              ? Icon(Icons.person, color: AppColors.textPrimary)
              : null,
    );
  }

  Widget _buildConnectionStatus() {
    return GetBuilder<ConversationController>(
      tag: widget.conversetionID,
      builder: (ctrl) {
        if (!Get.isRegistered<ConversationController>(
          tag: widget.conversetionID,
        )) {
          return const Text(
            'Disconnected',
            style: TextStyle(fontSize: 12, color: Colors.red),
          );
        }
        return Obx(
          () => Text(
            ctrl.isConnected.value ? 'Online' : 'Offline',
            style: TextStyle(
              color:
                  ctrl.isConnected.value
                      ? Color(0xff008D36)
                      : Color(0xffF00000),
              fontSize: 14,
              fontWeight: FontWeight.w200,
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    return [ChatCustomPopUpMenui()];
  }

  // ✅ Messages List Section
  Widget _buildMessagesListView() {
    return Expanded(
      child: Obx(() {
        // Show initial loading spinner when first loading messages
        if (controller.messages.isEmpty && controller.isLoading.value) {
          return _buildInitialLoadingView();
        }

        // Show empty state when no messages and not loading
        if (controller.messages.isEmpty &&
            !controller.isLoading.value &&
            !controller.isLoadingMore.value) {
          return _buildEmptyView();
        }

        // Show messages list
        return _buildMessagesList();
      }),
    );
  }

  Widget _buildInitialLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.buttonPrimary),
          const SizedBox(height: 16),
          Text(
            'Loading messages...',
            style: getTextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    final otherUser = widget.chat['data']?['otherUser'];
    final imageUrl = otherUser?['profilePic']?['url'];
    final userName = otherUser?['name'] ?? 'User';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade300,
            backgroundImage:
                (imageUrl != null &&
                        imageUrl.isNotEmpty &&
                        imageUrl.trim() != "" &&
                        imageUrl != "null")
                    ? NetworkImage(imageUrl)
                    : null,
            child:
                (imageUrl == null ||
                        imageUrl.isEmpty ||
                        imageUrl.trim() == "" ||
                        imageUrl == "null")
                    ? Icon(Icons.person, color: AppColors.textPrimary)
                    : null,
          ),
          const SizedBox(height: 10),
          Text(
            userName,
            overflow: TextOverflow.ellipsis,
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          const SizedBox(height: 8),
          Text(
            'Zag hallo tegen Samantha Green',
            style: getTextStyle(
              fontSize: 14,
              color: Colors.grey[500]!,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 20),
      itemCount: _getMessageListItemCount(),
      itemBuilder: (context, index) {
        return _buildMessageListItem(index);
      },
    );
  }

  int _getMessageListItemCount() {
    int count = 0;

    // Add "no more messages" indicator at top
    if (controller.noMoreMessages.value && !controller.isLoadingMore.value) {
      count += 1;
    }

    // Add loading indicator at top
    if (controller.isLoadingMore.value && controller.messages.isNotEmpty) {
      count += 1;
    }

    // Add all messages
    count += controller.messages.length;

    return count;
  }

  Widget _buildMessageListItem(int index) {
    int currentIndex = 0;

    // ✅ Show "No more messages" at the very top
    if (controller.noMoreMessages.value && !controller.isLoadingMore.value) {
      if (index == currentIndex) {
        return _buildNoMoreMessagesIndicator();
      }
      currentIndex++;
    }

    // ✅ Show loading indicator at top (after "no more messages")
    if (controller.isLoadingMore.value && controller.messages.isNotEmpty) {
      if (index == currentIndex) {
        return _buildLoadingMoreIndicator();
      }
      currentIndex++;
    }

    // ✅ Show messages in chronological order (oldest to newest)
    final messageIndex = index - currentIndex;
    if (messageIndex >= 0 && messageIndex < controller.messages.length) {
      final msg = controller.messages[messageIndex];
      return _buildMessageBubble(msg);
    }

    return const SizedBox.shrink();
  }

  Widget _buildNoMoreMessagesIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.history, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                "📜 No more messages",
                style: getTextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.buttonPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Loading more messages...',
            style: getTextStyle(fontSize: 14, color: Colors.grey[600]!),
          ),
        ],
      ),
    );
  }

  // ✅ Message Bubble Section
  Widget _buildMessageBubble(MessageModel message) {
    if (message.isSender) {
      // 🟢 My message (right side)
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: _buildMessageContainer(message),
        ),
      );
    } else {
      // 🔵 Other user message (left side with avatar)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Avatar on the left
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _getOtherUserAvatar(), // see helper below
              child:
                  _getOtherUserAvatar() == null
                      ? Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.grey.shade700,
                      )
                      : null,
            ),
            const SizedBox(width: 8),
            // 💬 Bubble
            Flexible(child: _buildMessageContainer(message)),
          ],
        ),
      );
    }
  }

  ImageProvider? _getOtherUserAvatar() {
    final otherUser = widget.chat['data']?['otherUser'];
    final imageUrl = otherUser?['profilePic']?['url'];
    if (imageUrl != null &&
        imageUrl.isNotEmpty &&
        imageUrl.trim() != "" &&
        imageUrl != "null") {
      return NetworkImage(imageUrl);
    }
    return null;
  }

  Widget _buildSenderName(String senderName) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 4),
      child: Text(
        'xcvzcv',
        style: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600]!,
        ),
      ),
    );
  }

  Widget _buildMessageContainer(MessageModel message) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.75),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            message.isSender ? AppColors.buttonPrimary : Colors.grey.shade200,

        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(16),
          bottomRight: const Radius.circular(16),
          topLeft: Radius.circular(message.isSender ? 16 : 2),
          topRight: Radius.circular(message.isSender ? 4 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            message.isSender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: [
          _buildMessageContent(message),
          const SizedBox(height: 6),
          _buildMessageFooter(message),
        ],
      ),
    );
  }

  Widget _buildMessageContent(MessageModel message) {
    return Column(
      crossAxisAlignment:
          message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (message.file != null && message.file!.url.isNotEmpty)
          _buildFileContent(message),
        if (message.content.isNotEmpty) _buildTextContent(message),
      ],
    );
  }

  Widget _buildFileContent(MessageModel message) {
    final file = message.file!;

    return Column(
      children: [
        if (message.fileType == 'image')
          _buildImageContent(file.url)
        else
          _buildOtherFileContent(message.fileType, message.isSender),
        if (message.content.isNotEmpty) const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildImageContent(String imageUrl) {
    return GestureDetector(
      onTap: () => Get.to(() => FullImageView(imagePath: imageUrl)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              // Image finished loading, trigger scroll to bottom
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Get.isRegistered<ConversationController>()) {
                  final controller = Get.find<ConversationController>();
                  controller.scrollToBottomWhenReady();
                }
              });
              return child;
            }
            return Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonPrimary,
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(height: 8),
                  Text(
                    'Failed to load image',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtherFileContent(String fileType, bool isSender) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFileIcon(fileType),
            color: isSender ? Colors.white : AppColors.textPrimary,
          ),
          const SizedBox(width: 8),
          Text(
            'File attachment',
            style: TextStyle(
              color: isSender ? Colors.white : AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(MessageModel message) {
    return Text(
      message.content,
      style: getTextStyle(
        lineHeight: 13,
        color: message.isSender ? Colors.white : AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildMessageFooter(MessageModel message) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message.formattedTime,
          style: TextStyle(
            fontSize: 11,
            color: message.isSender ? Colors.white70 : Colors.black54,
          ),
        ),
        if (message.isSender) ...[
          const SizedBox(width: 4),

          //
        ],
      ],
    );
  }

  // ✅ Selected Image Preview Section
  Widget _buildSelectedImagePreview() {
    return GetBuilder<ConversationController>(
      tag: widget.conversetionID,
      builder: (ctrl) {
        if (!Get.isRegistered<ConversationController>(
          tag: widget.conversetionID,
        )) {
          return const SizedBox.shrink();
        }

        return Obx(() {
          if (ctrl.selectedImage.value != null) {
            return Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildSelectedImageThumbnail(),
                  const SizedBox(width: 12),
                  _buildSelectedImageInfo(),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        });
      },
    );
  }

  Widget _buildSelectedImageThumbnail() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            controller.selectedImage.value!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: GestureDetector(
            onTap: () {
              if (Get.isRegistered<ConversationController>(
                tag: widget.conversetionID,
              )) {
                controller.clearSelectedImage();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedImageInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Image',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Ready to send',
            style: getTextStyle(fontSize: 12, color: Colors.grey[600]!),
          ),
        ],
      ),
    );
  }

  // ✅ Message Input Area Section
  Widget _buildMessageInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.transparent),
      child: SafeArea(
        child: Row(
          children: [
            // _buildImagePickerButton(),
            _buildTextInputField(),
            // _buildEmojiButton(),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return GetBuilder<ConversationController>(
      tag: widget.conversetionID,
      builder: (ctrl) {
        if (!Get.isRegistered<ConversationController>(
          tag: widget.conversetionID,
        )) {
          return IconButton(
            icon: Icon(Icons.send, color: Colors.grey.shade500),
            onPressed: null,
          );
        }

        return Obx(() {
          final canSend =
              (ctrl.messageText.value.trim().isNotEmpty ||
                  ctrl.selectedImage.value != null) &&
              !ctrl.isSending.value;

          return IconButton(
            icon:
                ctrl.isSending.value
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : Icon(
                      Icons.send,
                      color:
                          canSend
                              ? AppColors.primaryGold
                              : Colors.grey.shade500,
                    ),
            onPressed: canSend ? () => ctrl.sendMessage() : null,
            tooltip: 'Send message',
          );
        });
      },
    );
  }

  Widget _buildImagePickerButton() {
    return IconButton(
      icon: Icon(Icons.image, color: AppColors.primaryGold),
      onPressed: () {
        if (Get.isRegistered<ConversationController>(
          tag: widget.conversetionID,
        )) {
          controller.showImagePickerOptions();
        }
      },
      tooltip: 'Add image',
    );
  }

  Widget _buildEmojiButton() {
    return GetBuilder<ConversationController>(
      tag: widget.conversetionID,
      builder: (ctrl) {
        if (!Get.isRegistered<ConversationController>(
          tag: widget.conversetionID,
        )) {
          return IconButton(
            icon: Icon(Icons.emoji_emotions, color: Colors.grey),
            onPressed: null,
          );
        }

        return Obx(
          () => IconButton(
            icon: Icon(
              ctrl.isEmojiVisible.value ? Icons.keyboard : Icons.emoji_emotions,
              color: AppColors.primaryGold,
            ),
            onPressed: () {
              ctrl.toggleEmojiPicker();
              if (ctrl.isEmojiVisible.value) {
                focusNode.unfocus();
              } else {
                focusNode.requestFocus();
              }
            },
            tooltip:
                ctrl.isEmojiVisible.value ? 'Show keyboard' : 'Show emojis',
          ),
        );
      },
    );
  }

  // ✅ Emoji Picker Section
  Widget _buildEmojiPicker() {
    return GetBuilder<ConversationController>(
      tag: widget.conversetionID,
      builder: (ctrl) {
        if (!Get.isRegistered<ConversationController>(
          tag: widget.conversetionID,
        )) {
          return const SizedBox.shrink();
        }

        return Obx(() {
          if (ctrl.isEmojiVisible.value) {
            return Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  if (Get.isRegistered<ConversationController>(
                    tag: widget.conversetionID,
                  )) {
                    ctrl.addEmoji(emoji.emoji);
                  }
                },
                config: Config(
                  height: 250,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    emojiSizeMax: 28,
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: const SizedBox.shrink(),
                    buttonMode: ButtonMode.MATERIAL,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        });
      },
    );
  }

  Widget _buildTextInputField() {
    return Expanded(
      child: GetBuilder<ConversationController>(
        tag: widget.conversetionID,
        builder: (ctrl) {
          if (!Get.isRegistered<ConversationController>(
            tag: widget.conversetionID,
          )) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                'Chat disconnected',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return TextField(
            cursorColor: AppColors.primaryGold,
            focusNode: focusNode,
            controller: ctrl.messageController,
            onChanged: (val) {
              if (Get.isRegistered<ConversationController>(
                tag: widget.conversetionID,
              )) {
                ctrl.messageText.value = val;
              }
            },
            decoration: InputDecoration(
              hintText: "Type a message...",
              hintStyle: TextStyle(color: Colors.grey[500]),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.grey4, width: 1.5),
              ),

              suffixIcon: GestureDetector(
                onTap: () {
                  if (Get.isRegistered<ConversationController>(
                    tag: widget.conversetionID,
                  )) {
                    ctrl.showImagePickerOptions();
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 6,
                  child: Image.asset(
                    IconPath.chatattachfile,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),

              //  IconButton(
              //   icon: Icon(Icons.attach_file_rounded, color: AppColors.primaryGold),
              //   onPressed: () {
              //     if (Get.isRegistered<ConversationController>(
              //       tag: widget.conversetionID,
              //     )) {
              //       ctrl.showImagePickerOptions();
              //     }
              //   },
              //   tooltip: 'Add image',
              // ),
              prefixIcon: Obx(() {
                return
                // GestureDetector(
                //   onTap: () {
                //                       },
                //   child: CircleAvatar(
                //               backgroundColor: Colors.transparent,
                //               radius: 12,
                //               child: Image.asset(IconPath.chatemoji, width: 24, height: 24),
                //             ),
                // ),
                IconButton(
                  icon: Icon(
                    ctrl.isEmojiVisible.value
                        ? Icons.keyboard
                        : Icons.emoji_emotions_outlined,
                    color: AppColors.primaryGold,
                  ),
                  onPressed: () {
                    ctrl.toggleEmojiPicker();
                    if (ctrl.isEmojiVisible.value) {
                      focusNode.unfocus();
                    } else {
                      focusNode.requestFocus();
                    }
                  },
                  tooltip:
                      ctrl.isEmojiVisible.value
                          ? 'Show keyboard'
                          : 'Show emojis',
                );
              }),
            ),
            maxLines: null,
            textInputAction: TextInputAction.newline,
            onSubmitted: (_) {
              if (Get.isRegistered<ConversationController>(
                    tag: widget.conversetionID,
                  ) &&
                  !ctrl.isSending.value) {
                ctrl.sendMessage();
              }
            },
          );
        },
      ),
    );
  }

  // ✅ Helper Methods
  IconData _getFileIcon(String fileType) {
    switch (fileType) {
      case 'image':
        return Icons.image;
      case 'video':
        return Icons.video_file;
      case 'document':
        return Icons.description;
      default:
        return Icons.attach_file;
    }
  }

  void _showDebugInfo() {
    if (!Get.isRegistered<ConversationController>(tag: widget.conversetionID)) {
      Get.dialog(
        AlertDialog(
          title: const Text('Debug Info'),
          content: const Text('Controller not available'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Close')),
          ],
        ),
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text('Debug Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Messages: ${controller.messages.length}'),
            Text('Connected: ${controller.isConnected.value}'),
            Text('Loading: ${controller.isLoading.value}'),
            Text('Sending: ${controller.isSending.value}'),
            Text('Conversation ID: ${widget.conversetionID}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }
}
