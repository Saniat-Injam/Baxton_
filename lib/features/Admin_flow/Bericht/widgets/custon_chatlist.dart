import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/features/klant_flow/profile_screen/controller/profile_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomChatList extends StatelessWidget {
  final String imagePath;
  final String name;
  final String lastMessage;
  final String time;

  CustomChatList({
    super.key,
    required this.imagePath,
    required this.name,
    required this.lastMessage,
    required this.time,
  });
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 24,
        child: Image.asset(imagePath, width: 48, height: 48, fit: BoxFit.cover),
      ),
      title: Text(
        name,
        style: getTextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        lastMessage,
        style: getTextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.textEighth,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: getTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.textEighth,
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
