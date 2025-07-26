class TaskSettingsModel {
  List<String> categories;
  List<String> statuses;
  bool reminderEnabled;

  TaskSettingsModel({
    required this.categories,
    required this.statuses,
    this.reminderEnabled = true,
  });
}
