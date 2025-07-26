import 'dart:ui';

class Task {
  final String title;
  final String userName;
  final String date;
  final String status;
  final Color statusColor;
  final Color statusTextColor;

  Task({
    required this.title,
    required this.userName,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
  });
}
