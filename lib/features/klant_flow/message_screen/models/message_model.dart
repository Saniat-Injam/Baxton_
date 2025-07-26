class MessageModel {
  final String id;
  final String conversationId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final FileModel? file;
  final String name;
  final String? senderProfilePic;
  final bool isSender;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    this.file,
    required this.name,
    this.senderProfilePic,
    required this.isSender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      userId: json['userId'] ?? '',
      file: json['file'] != null ? FileModel.fromJson(json['file']) : null,
      name: json['name'] ?? 'User',
      senderProfilePic: json['senderProfilePic'],
      isSender: json['isSender'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'file': file?.toJson(),
      'name': name,
      'senderProfilePic': senderProfilePic,
      'isSender': isSender,
    };
  }

  String get formattedTime {
    final now = DateTime.now();
    final localTime = createdAt.toLocal();

    if (localTime.day == now.day &&
        localTime.month == now.month &&
        localTime.year == now.year) {
      return '${localTime.hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')}';
    }

    return '${localTime.day}/${localTime.month} ${localTime.hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')}';
  }

  String get fileType {
    if (file == null) return '';

    final url = file!.url.toLowerCase();
    if (url.contains('.jpg') ||
        url.contains('.jpeg') ||
        url.contains('.png') ||
        url.contains('.gif')) {
      return 'image';
    } else if (url.contains('.mp4') ||
        url.contains('.avi') ||
        url.contains('.mov')) {
      return 'video';
    } else if (url.contains('.pdf') ||
        url.contains('.doc') ||
        url.contains('.docx')) {
      return 'document';
    }
    return 'file';
  }

  // Helper method to check if two messages are from the same day
  bool isSameDay(MessageModel other) {
    final thisDate = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final otherDate = DateTime(
      other.createdAt.year,
      other.createdAt.month,
      other.createdAt.day,
    );
    return thisDate.isAtSameMomentAs(otherDate);
  }
}

class FileModel {
  final String url;
  final String? name;
  final String? type;

  FileModel({required this.url, this.name, this.type});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      url: json['url'] ?? '',
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'name': name, 'type': type};
  }
}
