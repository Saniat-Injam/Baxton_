import 'package:flutter/material.dart';

class NotificationItem {
  final String? avatarInitials;
  final Color? avatarBackgroundColor;
  final Color? avatarTextColor;
  final String message;
  final Color messageColor;
  final String time;
  bool isUnread;
  final Color backgroundColor;

  NotificationItem({
    this.avatarInitials,
    this.avatarBackgroundColor,
    this.avatarTextColor,
    required this.message,
    required this.messageColor,
    required this.time,
    required this.isUnread,
    required this.backgroundColor,
  });
}

class NotificationController {
  final ValueNotifier<List<NotificationItem>> notifications =
      ValueNotifier<List<NotificationItem>>([
    NotificationItem(
      avatarInitials: 'SJ',
      avatarBackgroundColor: const Color(0xFFE2E8F0),
      avatarTextColor: const Color(0xFF72839A),
      message:
          'Je taak om het dak van het XYZ-pand te inspecteren is toegewezen. Bekijk de details.',
      messageColor: const Color(0xFF0D3C6B),
      time: '15h',
      isUnread: true,
      backgroundColor: const Color(0xFFEDF3FF),
    ),
    NotificationItem(
      message:
          'Het loodgietersysteem van het ABC-gebouw heeft onderhoud nodig. Plan een bezoek.',
      messageColor: const Color(0xFF333333),
      time: '2d',
      isUnread: false,
      backgroundColor: Colors.white,
    ),
    NotificationItem(
      message:
          'Je hebt een vergadering over het HVAC-systeem op het DEF-kantoor. Bevestig je aanwezigheid.',
      messageColor: const Color(0xFF333333),
      time: '1d',
      isUnread: false,
      backgroundColor: Colors.white,
    ),
    NotificationItem(
      message:
          'Het landschapsontwerp voor het GHI-park is afgerond. Bekijk de voorstellen.',
      messageColor: const Color(0xFF0D3C6B),
      time: '3d',
      isUnread: true,
      backgroundColor: const Color(0xFFEDF3FF),
    ),
    NotificationItem(
      message:
          'Evalueer alstublieft de elektrische bedrading in het JKL-magazijn. Rapporteer bevindingen.',
      messageColor: const Color(0xFF333333),
      time: '5h',
      isUnread: false,
      backgroundColor: Colors.white,
    ),
    NotificationItem(
      message:
          'De brandveiligheidsaudit voor het MNO-complex is binnenkort verschuldigd. Bereid de benodigde documenten voor.',
      messageColor: const Color(0xFF333333),
      time: '1w',
      isUnread: false,
      backgroundColor: Colors.white,
    ),
    NotificationItem(
      message:
          'Je analyse van bouwmaterialen voor de PQR-locatie is nu nodig. Dien je rapport in.',
      messageColor: const Color(0xFF333333),
      time: '4d',
      isUnread: false,
      backgroundColor: Colors.white,
    ),
  ]);

  void markAllAsRead() {
    final updatedNotifications = notifications.value
        .map((notification) => NotificationItem(
              avatarInitials: notification.avatarInitials,
              avatarBackgroundColor: notification.avatarBackgroundColor,
              avatarTextColor: notification.avatarTextColor,
              message: notification.message,
              messageColor: const Color(0xFF333333),
              time: notification.time,
              isUnread: false,
              backgroundColor: Colors.white,
            ))
        .toList();
    notifications.value = updatedNotifications;
  }

  void markAsRead(int index) {
    final updatedNotifications = List<NotificationItem>.from(notifications.value);
    updatedNotifications[index] = NotificationItem(
      avatarInitials: updatedNotifications[index].avatarInitials,
      avatarBackgroundColor: updatedNotifications[index].avatarBackgroundColor,
      avatarTextColor: updatedNotifications[index].avatarTextColor,
      message: updatedNotifications[index].message,
      messageColor: const Color(0xFF333333),
      time: updatedNotifications[index].time,
      isUnread: false,
      backgroundColor: Colors.white,
    );
    notifications.value = updatedNotifications;
  }
}