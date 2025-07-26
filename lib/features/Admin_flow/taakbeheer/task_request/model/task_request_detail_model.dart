class TaskRequestDetail {
  final String title;
  final String timeAgo;
  final String user;
  final String location;
  final String phoneNumber;
  final String date;
  final String time;
  final String category;

  TaskRequestDetail({
    required this.title,
    required this.user,
    required this.timeAgo,
    required this.location,
    required this.phoneNumber,
    required this.date,
    required this.time,
    required this.category,
  });
}
