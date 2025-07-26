import 'dart:ui';

import 'package:baxton/core/utils/constants/colors.dart';

class RecentTask {
  final String name;
  final String location;
  final String workerName;
  final String timeAgo;
  final String status;
  final Color statusColor;
  final Color statusTextColor;

  RecentTask({
    required this.name,
    required this.location,
    required this.workerName,
    required this.timeAgo,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
  });
}

// Example list of tasks (you can fetch this from your controller)
final List<RecentTask> recentTasks = [
  RecentTask(
    name: "Inspecteer het dak",
    location: "New York",
    workerName: "Albert Flores",
    timeAgo: "2h ago",
    status: "In Behandeling",
    statusColor: Color(0xffE9F4FF),
    statusTextColor: AppColors.buttonPrimary,
  ),
  RecentTask(
    name: "Repareer lekkage",
    location: "New York",
    workerName: "John Doe",
    timeAgo: "5h ago",
    status: "Toegewezen",
    statusColor: Color(0xffE9F4FF),
    statusTextColor: AppColors.buttonPrimary,
  ),
  RecentTask(
    name: "Repareer lekkage",
    location: "New York",
    workerName: "John Doe",
    timeAgo: "5h ago",
    status: "Toegewezen",
    statusColor: const Color(0xffE9F4FF),
    statusTextColor: AppColors.buttonPrimary,
  ),
  RecentTask(
    name: "Repareer lekkage",
    location: "New York",
    workerName: "John Doe",
    timeAgo: "5h ago",
    status: "Toegewezen",
    statusColor: const Color(0xffE9F4FF),
    statusTextColor: AppColors.buttonPrimary,
  ),
];
