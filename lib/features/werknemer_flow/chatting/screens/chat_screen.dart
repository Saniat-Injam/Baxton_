import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/werknemer_flow/chatting/controller/chat_controller.dart';
import 'package:baxton/features/werknemer_flow/chatting/controller/wchat_list_controller.dart';
import 'package:baxton/features/werknemer_flow/chatting/screens/single_page_chat.dart';
import 'package:baxton/features/werknemer_flow/chatting/widgets/custon_chatlist.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final WChatController singlePageChatController = Get.put(WChatController());
  final WChatListController wChatListController = Get.put(
    WChatListController(),
  );

  @override
  Widget build(BuildContext context) {
    singlePageChatController.connectWebSocket();
    wChatListController.chatList();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Chatten",
          style: getTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: singlePageChatController.chats.length,
          itemBuilder: (context, index) {
            final chat = singlePageChatController.chats[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => WSinglePageChat(chat: chat));
              },
              child: CustomChatList(
                imagePath: chat['image'] ?? '',
                name: chat['name'] ?? '',
                lastMessage: chat['message'] ?? '',
                time: chat['time'] ?? '',
              ),
            );
          },
        ),
      ),
    );
  }
}
