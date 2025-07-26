import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:baxton/features/Admin_flow/meldingen/model/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final bool isUnread = !notification.isRead;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFEDF3FF) : AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //CircleAvatar(backgroundImage: AssetImage(ImagePath.user), radius: 24),
              if (isUnread)
                Icon(Icons.circle, color: AppColors.primaryBlue, size: 10),
              const SizedBox(width: 6),

              // User Image
              Image.asset(ImagePath.user),
              const SizedBox(width: 6),

              // Notification Message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0D3C6B),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              SizedBox(width: 4),
              Text(
                notification.time,
                style: getTextStyle3(
                  color: Color(0xff475569),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
