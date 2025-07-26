// import 'package:baxton/features/klant_flow/message_screen/models/message_model.dart';

// class ChatModel {
//   final String id;
//   final ChatData data;

//   ChatModel({required this.id, required this.data});

//   factory ChatModel.fromJson(Map<String, dynamic> json) {
//     return ChatModel(
//       id: json['id'] ?? '',
//       data: ChatData.fromJson(json['data'] ?? {}),
//     );
//   }
// }

// class ChatData {
//   final UserModel otherUser;
//   final MessageModel? lastMessage;

//   ChatData({required this.otherUser, this.lastMessage});

//   factory ChatData.fromJson(Map<String, dynamic> json) {
//     return ChatData(
//       otherUser: UserModel.fromJson(json['otherUser'] ?? {}),
//       lastMessage:
//           json['lastMessage'] != null
//               ? MessageModel.fromJson(json['lastMessage'])
//               : null,
//     );
//   }
// }

// class UserModel {
//   final String id;
//   final String name;
//   final ProfilePic? profilePic;

//   UserModel({required this.id, required this.name, this.profilePic});

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? 'User',
//       profilePic:
//           json['profilePic'] != null
//               ? ProfilePic.fromJson(json['profilePic'])
//               : null,
//     );
//   }
// }

// class ProfilePic {
//   final String url;

//   ProfilePic({required this.url});

//   factory ProfilePic.fromJson(Map<String, dynamic> json) {
//     return ProfilePic(url: json['url'] ?? '');
//   }

//   bool get isValid => url.isNotEmpty && url != "null" && url.trim() != "";
// }
