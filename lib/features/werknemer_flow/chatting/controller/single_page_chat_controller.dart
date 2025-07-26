// ignore: file_names
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatMessage {
  final String message;
  final String time;
  final bool isUser;
  final String imageUrl;

  ChatMessage({
    required this.message,
    required this.time,
    required this.isUser,
    required this.imageUrl,
  });
}

final scrollController = ScrollController();
FocusNode messageFocusNode = FocusNode();

class WSinglePageChatController extends GetxController {
  var chatMessages =
      <ChatMessage>[
        ChatMessage(
          message: "Hi there!",
          time: "10:30 AM",
          isUser: false,
          imageUrl: "",
        ),
        ChatMessage(
          message: "Hello! How can I help you?",
          time: "10:31 AM",
          isUser: true,
          imageUrl: "",
        ),
        ChatMessage(
          message: "I have a question regarding your service.",
          time: "10:32 AM",
          isUser: false,
          imageUrl: "",
        ),
      ].obs;

  final messageController = TextEditingController();
  var messageText = ''.obs;
  var isEmojiVisible = false.obs;

  final ImagePicker _picker = ImagePicker();

  void onMessageChanged(String value) {
    messageText.value = value;
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      chatMessages.add(
        ChatMessage(
          message: message,
          time: TimeOfDay.now().format(Get.context!),
          isUser: true,
          imageUrl: "",
        ),
      );
      messageController.clear();
      messageText.value = '';
      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
  // Inside SpSinglePageChatController

  var selectedImage = Rx<XFile?>(null);
  Future<void> pickImage() async {
    final pickedOption = await showModalBottomSheet<String>(
      context: Get.context!,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          height: 170,
          child: Column(
            children: [
              Text(
                'Select Image',
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.buttonPrimary,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera option
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop('camera');
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.buttonPrimary.withValues(
                            alpha: 0.1,
                          ),
                          radius: 25,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.buttonPrimary,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Camera',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.buttonPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gallery option
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop('gallery');
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.buttonPrimary.withValues(
                            alpha: 0.1,
                          ),
                          radius: 25,
                          child: Icon(
                            Icons.photo,
                            color: AppColors.buttonPrimary,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Gallery',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.buttonPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (pickedOption != null) {
      XFile? pickedFile;

      if (pickedOption == 'gallery') {
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      } else if (pickedOption == 'camera') {
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
      }

      if (pickedFile != null) {
        selectedImage.value = pickedFile;
      }
    }
  }

  void sendImage() {
    if (selectedImage.value != null) {
      chatMessages.add(
        ChatMessage(
          message: "",
          time: TimeOfDay.now().format(Get.context!),
          isUser: true,
          imageUrl: selectedImage.value!.path,
        ),
      );
      selectedImage.value = null;
      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
}
