import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:universe/pages/home/domain/entity/chat_room.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';

class ChatDetail extends StatelessWidget {
  ChatDetail({Key? key, required this.chatRoom}) : super(key: key);
  final ChatRoom chatRoom;

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  @override
  Widget build(BuildContext context) {
    return ChatDetailWidget(
      chatRoom: chatRoom,
    );
  }
}

class ChatDetailWidget extends StatelessWidget {
  final ChatRoom chatRoom;
  const ChatDetailWidget({Key? key, required this.chatRoom}) : super(key: key);
  static HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getChatMessages();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        MemoryImage(chatRoom.photoFile as Uint8List),
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          chatRoom.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: controller.chatMessages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                print(
                    "getChatMessages() Current User is ${controller.currentUser.id} and message is ${controller.chatMessages[index].messageContent}");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: (controller.currentUser.id !=
                            controller.chatMessages[index].messageFrom
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: TextMessageWidget(
                      controller: controller,
                      index: index,
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (controller.currentUser.id !=
                controller.chatMessages[index].messageFrom
            ? Colors.grey.shade200
            : Colors.blue[200]),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(controller.chatMessages[index].messageContent,
          style: const TextStyle(fontSize: 15)),
    );
  }
}
