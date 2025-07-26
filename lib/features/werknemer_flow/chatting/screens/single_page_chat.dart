import 'dart:io' show File;

import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/profile_screen/controller/profile_controller.dart';
import 'package:baxton/features/werknemer_flow/chatting/controller/single_page_chat_controller.dart';
import 'package:baxton/features/werknemer_flow/chatting/screens/full_image.dart';
import 'package:baxton/features/werknemer_flow/chatting/widgets/custom_popup_menu.dart';
import 'package:baxton/features/werknemer_flow/chatting/widgets/single_textfield.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WSinglePageChat extends StatelessWidget {
  final Map<String, dynamic> chat;

  WSinglePageChat({super.key, required this.chat});
  final darkcontroller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isOnline = chat['isOnline'] == 'true';
    final wsinglePageChatController = Get.put(WSinglePageChatController());
    final FocusNode focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        wsinglePageChatController.isEmojiVisible.value = false;
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.chatBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: AppColors.textWhite,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.textPrimary.withValues(
                      alpha: 0.10,
                    ),
                    child: Image.asset(
                      IconPath.arrowleft,
                      width: 16,
                      height: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(chat['image'] ?? ''),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat['name'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          isOnline ? 'Online' : 'Offline',
                          style: TextStyle(
                            color:
                                isOnline
                                    ? Color(0xff008D36)
                                    : Color(0xffF00000),
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [ChatCustomPopUpMenui()],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: wsinglePageChatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message =
                        wsinglePageChatController.chatMessages[index];
                    return Align(
                      alignment:
                          message.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              message.isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  message.isUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                if (!message.isUser)
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      chat['image'] ?? '',
                                    ),
                                    radius: 16,
                                  ),
                                SizedBox(width: 10),
                                IntrinsicWidth(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    constraints: BoxConstraints(
                                      maxWidth: Get.width * 0.6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          message.imageUrl.isNotEmpty
                                              ? Colors.transparent
                                              : AppColors.buttonPrimary,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topLeft:
                                            message.isUser
                                                ? Radius.circular(15)
                                                : Radius.zero,
                                        topRight:
                                            message.isUser
                                                ? Radius.zero
                                                : Radius.circular(15),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          message.isUser
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                      children: [
                                        if (message.imageUrl.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                () => FullImageView(
                                                  imagePath: message.imageUrl,
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag: message.imageUrl,

                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.file(
                                                  File(message.imageUrl),
                                                  width: 250,
                                                  height: 250,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (message.message.isNotEmpty)
                                          Text(
                                            message.message,
                                            style: getTextStyle(
                                              color: AppColors.textWhite,
                                              fontSize: 16,
                                            ),
                                            softWrap: true,
                                          ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              message.time,
                                              style: TextStyle(
                                                color:
                                                    message.imageUrl.isNotEmpty
                                                        ? AppColors
                                                            .darkTextColor
                                                        : AppColors.textWhite,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Obx(() {
              if (wsinglePageChatController.selectedImage.value != null) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(
                            wsinglePageChatController.selectedImage.value!.path,
                          ),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          wsinglePageChatController.selectedImage.value = null;
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.redAccent,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSingleTextfield(
                      focusNode: focusNode,
                      wsinglePageChatController: wsinglePageChatController,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (wsinglePageChatController.isEmojiVisible.value) {
                return EmojiPicker(
                  // ignore: non_constant_identifier_names
                  onEmojiSelected: (Category, emoji) {
                    wsinglePageChatController.messageController.text +=
                        emoji.emoji;
                    wsinglePageChatController.messageText.value =
                        wsinglePageChatController.messageController.text;
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
