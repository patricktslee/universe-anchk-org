import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/mission_widget.dart';
import 'package:get/get.dart';

class MissionPage extends StatelessWidget {
  static HomeController menuController = Get.find();

  const MissionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: const [
          MainTitle(),
          Expanded(
            child: SingleChildScrollView(
              child: MissionWidget(),
            ),
            //ListView(
            //  children: [
            //    Column(
            //      mainAxisSize: MainAxisSize.min,
            //      crossAxisAlignment: CrossAxisAlignment.start,
            //      children: menuController.anchkMissionItem
            //          .map((item) => Padding(
            //                padding: const EdgeInsets.symmetric(vertical: 8),
            //                child: CustomText(
            //                  text: item.text.toString(),
            //                  size: standardTextSize,
            //                  weight: FontWeight.bold,
            //                  color: blackColor,
            //                ),
            //              ))
            //          .toList(),
            //    ),
            //    const SizedBox(
            //      height: 24,
            //    ),
            //    ClipRRect(
            //      borderRadius: BorderRadius.circular(8.0),
            //      child: Image.asset(anchkMissionPhoto),
            //    ),
            //  ],
            //),
          )
        ],
      ),
    );
  }
}
