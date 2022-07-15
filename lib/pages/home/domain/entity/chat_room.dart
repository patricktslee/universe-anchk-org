import 'dart:typed_data';

import 'package:universe/pages/home/data/api_service.dart';

class ChatRoom {
  final String name;
  final String messageText;
  final String imageURL;
  final String time;
  ApiService apiService = ApiService.instance;

  ChatRoom({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
    this.photoFile,
  });

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      name: map['name'],
      messageText: map['messageText'],
      imageURL: map['imageURL'],
      time: map['time'],
    );
  }
  factory ChatRoom.fromObject(Map<String, dynamic> map, Uint8List file) {
    return ChatRoom(
      name: map['name'],
      messageText: map['messageText'],
      imageURL: map['imageURL'],
      time: map['time'],
      photoFile: file,
    );
  }
  Uint8List? photoFile;

  @override
  String toString() {
    return 'chatRoom\nname: $name\nmessageText: $messageText\nimageURL: $imageURL\ntime: $time';
  }
}
