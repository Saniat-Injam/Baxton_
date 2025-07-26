import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/message_screen/controller/kchatList_controller.dart';
import 'package:baxton/features/klant_flow/message_screen/screens/conversation_screen.dart';
import 'package:baxton/features/klant_flow/message_screen/widgets/custon_chatlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final KchatlistController kChatListController = Get.put(
    KchatlistController(),
  );

  @override
  Widget build(BuildContext context) {
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
        // actions: [
        //   IconButton(
        //     onPressed: () => kChatListController.refreshChatList(),
        //     icon: Icon(Icons.refresh, color: AppColors.textPrimary),
        //   ),
        // ],
      ),
      body: Obx(() {
        if (kChatListController.chatList.isEmpty) {
          return Center(
            child: Text(
              'Geen chats gevonden',
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => kChatListController.refreshChatList(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: kChatListController.chatList.length,
              itemBuilder: (context, index) {
                final chat = kChatListController.chatList[index];
                final data = chat['data'];
                final otherUser = data?['otherUser'] ?? {};
                final lastMessage = data?['lastMessage'] ?? {};
                final imagePath = otherUser['profilePic']?['url'] ?? '';
                final userName = otherUser['name'] ?? 'No name';
                final message = lastMessage['content'] ?? 'No message';
                final conversationId = chat['id'];
                final time = kChatListController.formatMessageTime(
                  lastMessage['createdAt'],
                );

                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () =>
                      //---------------
                      ConversationScreen(
                        chat: chat,
                        conversetionID: conversationId,
                      ),
                      // SinglePageChat(chat: chat),
                    );
                  },
                  child: CustomChatList(
                    imagePath: imagePath,
                    name: userName,
                    lastMessage: message,
                    time: time,
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
