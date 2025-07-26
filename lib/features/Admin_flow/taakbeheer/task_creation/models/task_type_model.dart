import 'dart:convert';

List<TaskType> taskTypeListFromJson(String str) =>
    List<TaskType>.from(json.decode(str).map((x) => TaskType.fromJson(x)));

String taskTypeListToJson(List<TaskType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskType {
  String id;
  String name;

  TaskType({
    required this.id,
    required this.name,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        id: json["id"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}