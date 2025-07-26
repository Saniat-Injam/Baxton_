class NotificationModel {
  final String message;
  final String time;
  final String userImage;
  final bool isRead;
  final String type;

  NotificationModel({
    required this.message,
    required this.time,
    required this.userImage,
    required this.isRead,
    required this.type,
  });
}
