class TaskStatsModel {
  final int assigned;
  final int inProgress;
  final int completed;
  final int overdue;
  int unassigned;

  TaskStatsModel({
    required this.assigned,
    required this.inProgress,
    required this.completed,
    required this.overdue,
    required this.unassigned,
  });

  int get total => assigned + inProgress + completed + overdue + unassigned;
}

class TaskRequestModel {
  final String title;
  final String user;
  final String timeAgo;

  TaskRequestModel({required this.title, required this.user, required this.timeAgo});
}
