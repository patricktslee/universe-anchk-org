import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/conversation_list_widget.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
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
    return const ListViewBuilder();
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          const MainTitle(),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
//          CustomText(text: 'Chat', weight: FontWeight.normal),
        ],
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  static HomeController controller = Get.find();

  const ListViewBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getChatRooms();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SubTitle(),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: controller.chatRooms.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConversationList(controller.chatRooms[index]);
                  //ConversationList(
                  //  name: controller.chatRooms[index].name,
                  //  messageText: controller.chatRooms[index].messageText,
                  //  imageUrl: controller.chatRooms[index].imageURL,
                  //  photoFile: controller.chatRooms[index].photoFile,
                  //  time: controller.chatRooms[index].time,
                  //  isMessageRead: (index == 0 || index == 3) ? true : false,
                  //);
                },
              ),
            ),

            //ListView.builder(
            //    itemCount: 3,
            //    itemBuilder: (BuildContext context, int index) {
            //      return ListTile(
            //        leading: const Icon(Icons.list),
            //        trailing: const Text(
            //          "GFG",
            //          style: TextStyle(color: Colors.green, fontSize: 15),
            //        ),
            //        title: Text("List item $index"),
            //        onTap: () {
            //          Get.to(AllChatPage());
            //        },
            //      );
            //    },),
          ),
        ],
      ),
    );
  }
}
