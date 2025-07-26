class Task {
  final String title;
  final String location;
  final String assignee;
  final DateTime date;
  final TaskStatus status;

  Task({
    required this.title,
    required this.location,
    required this.assignee,
    required this.date,
    required this.status,
  });
}

enum TaskStatus { bezig, voltooid, teLaat, nietToegewezen }


