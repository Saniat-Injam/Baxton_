class TaskStats {
  final int assigned;
  final int inProgress;
  final int completed;
  final int overdue;
  final int unassigned;

  TaskStats({
    required this.assigned,
    required this.inProgress,
    required this.completed,
    required this.overdue,
    required this.unassigned,
  });

  int get total => assigned + inProgress + completed + overdue + unassigned;
}

class TaskRequest {
  final String id;
  final String title;
  final String user;
  final String timeAgo;

  TaskRequest({
    required this.id,
    required this.title,
    required this.user,
    required this.timeAgo,
  });
}