// lib/features/Admin_flow/betalingsbeheer/model/invoice_model.dart
// lib/features/Admin_flow/betalingsbeheer/model/invoice_model.dart
enum PaymentStatus { pending, confirmed, overdue }

class Invoice {
  final String? id; // Added id field
  final String invoiceNumber;
  final String customerName;
  final String taskName;
  final String amount;
  final String date;
  final PaymentStatus status;

  Invoice({
    this.id,
    required this.invoiceNumber,
    required this.customerName,
    required this.taskName,
    required this.amount,
    required this.date,
    required this.status,
  });
}

class TaskModel {
  String assignedTo;
  String expertise;
  String status;
  String amount;

  TaskModel({
    required this.assignedTo,
    required this.expertise,
    required this.status,
    required this.amount,
  });
}


// lib/features/Admin_flow/betalingsbeheer/model/task_status_model.dart
class TaskStatsModel {
  final int assigned;
  final int inProgress;
  final int completed;
  final int overdue;
  final int unassigned;

  TaskStatsModel({
    required this.assigned,
    required this.inProgress,
    required this.completed,
    required this.overdue,
    required this.unassigned,
  });

  // Add toJson method to serialize the model
  Map<String, dynamic> toJson() {
    return {
      'assigned': assigned,
      'inProgress': inProgress,
      'completed': completed,
      'overdue': overdue,
      'unassigned': unassigned,
    };
  }
}

