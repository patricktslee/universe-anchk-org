import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/domain/entity/chat_room.dart';
import 'package:universe/pages/home/presentation/views/chat_detail.dart';

class ConversationList extends StatelessWidget {
  const ConversationList(this.chatRoom, {Key? key, bool? isMessageRead})
      : isMessageRead = isMessageRead ?? false,
        super(key: key);
  final ChatRoom chatRoom;
  final bool isMessageRead;
  //const ConversationList({
  //  Key? key,
  //  required String? name,
  //  required String? messageText,
  //  String? imageUrl,
  //  required Uint8List? photoFile,
  //  bool? isMessageRead,
  //  required String? time,
  //})  : name = name ?? "name",
  //      messageText = messageText ?? "messageText",
  //      imageUrl = imageUrl ?? "asas",
  //      photoFile = photoFile ?? photoFile,
  //      isMessageRead = isMessageRead ?? false,
  //      time = time ?? "today",
  //      super(key: key);
  //final String name;
  //final String messageText;
  //final String imageUrl;
  //final Uint8List? photoFile;
  //final String time;
  //final bool isMessageRead;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ChatDetail(
          chatRoom: chatRoom,
        ));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        MemoryImage(chatRoom.photoFile as Uint8List),
                    //NetworkImage(imageUrl),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            chatRoom.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            chatRoom.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              chatRoom.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      isMessageRead ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
