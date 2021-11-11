import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/video_player.dart';
import 'package:get/get.dart';

class VideoPage extends StatelessWidget {
  static HomeController menuController = Get.find();

  const VideoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          MainTitle(menuController: menuController),
          const Expanded(
            child: VideoPlayer(title: "title"),
          )
        ],
      ),
    );
  }
}
