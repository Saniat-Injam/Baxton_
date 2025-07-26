class TaskCreationModel {
  String taskType;
  String description;
  String clientName;
  String clientPhone;
  String clientLocation;
  DateTime? preferredDate;
  String preferredTime;
  String assignedTo;
  String expertise;

  TaskCreationModel({
    required this.taskType,
    required this.description,
    required this.clientName,
    required this.clientPhone,
    required this.clientLocation,
    this.preferredDate,
    required this.preferredTime,
    required this.assignedTo,
    required this.expertise,
  });
}
