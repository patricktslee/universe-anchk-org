import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class MissionWidget extends StatelessWidget {
  const MissionWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();

  Column missionColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.anchkMissionItem
                .map((item) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text:
                                '${(controller.anchkMissionItem.indexOf(item) + 1).toString()}.  ',
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomText(
                              text: item.text.toString(),
                              size: standardTextSize,
                              weight: FontWeight.bold,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
          const SizedBox(
            height: 24,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(anchkMissionPhoto),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return missionColumn();
  }
}
