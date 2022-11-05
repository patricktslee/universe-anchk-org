import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
//import 'package:universe/helpers/appwrite_image_memory.dart';
//import 'package:universe/pages/home/domain/entity/paragraph_model.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';
//import 'package:universe/widgets/selectable_custom_text.dart';

class MissionWidget extends StatelessWidget {
  const MissionWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();
  static String bgPhoto = "";

//  Column mission(List<Paragraph> missionItems) => Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: [
//          Column(
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: missionItems
//                .map((item) => Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: [
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: CustomText(
//                            text:
//                                '${(missionItems.indexOf(item) + 1).toString()}.  ',
//                            size: standardTextSize,
//                            weight: FontWeight.bold,
//                            color: blackColor,
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: Padding(
//                            padding: const EdgeInsets.symmetric(vertical: 8),
//                            child: CustomText(
//                              text: item.text.toString(),
//                              size: standardTextSize,
//                              weight: FontWeight.bold,
//                              color: blackColor,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ))
//                .toList(),
//          ),
//          const SizedBox(
//            height: 24,
//          ),
//          ClipRRect(
//              borderRadius: BorderRadius.circular(8.0),
//              child: AppwriteImageMemory(
//                fileId: bgPhoto,
//              )
//              //Image.asset(anchkMissionPhoto),
//              ),
//        ],
//      );

  @override
  Widget build(BuildContext context) {
    return getMission();
  }

  Widget getMission() {
    controller.getAnchkMissionItem();
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.mission.value.message!
                .map((item) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectionArea(
                            child: CustomText(
                              text:
                                  '${(controller.mission.value.message!.indexOf(item) + 1).toString()}.  ',
                              size: standardTextSize,
                              weight: FontWeight.bold,
                              color: blackColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SelectionArea(
                              child: CustomText(
                                text: item.text.toString(),
                                size: standardTextSize,
                                weight: FontWeight.bold,
                                color: blackColor,
                              ),
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
            child: Image.memory(
              controller.mission.value.photoFile as Uint8List,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    });
  }

//  Future<FutureBuilder<List<Paragraph>>> newMethod() async {
//    return FutureBuilder<List<Paragraph>>(
//        future: controller.getAnchkMissionItem().then((value) async {
//          await controller.getPhotoFileId("anchkMission").then((value) {
//            bgPhoto = value;
////          return value;
//          });
//          return value;
//        }),
//        builder: (context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return const Center(child: CircularProgressIndicator());
//          } else if (snapshot.hasData) {
//            return Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                Column(
//                  mainAxisSize: MainAxisSize.min,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: snapshot.data!
//                      .map((item) => Row(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: [
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: CustomText(
//                                  text:
//                                      '${(snapshot.data!.indexOf(item) + 1).toString()}.  ',
//                                  size: standardTextSize,
//                                  weight: FontWeight.bold,
//                                  color: blackColor,
//                                ),
//                              ),
//                              Expanded(
//                                flex: 1,
//                                child: Padding(
//                                  padding:
//                                      const EdgeInsets.symmetric(vertical: 8),
//                                  child: CustomText(
//                                    text: item.text.toString(),
//                                    size: standardTextSize,
//                                    weight: FontWeight.bold,
//                                    color: blackColor,
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ))
//                      .toList(),
//                ),
//                const SizedBox(
//                  height: 24,
//                ),
//                ClipRRect(
//                  borderRadius: BorderRadius.circular(8.0),
//                  child: (snapshot.hasData && bgPhoto != "")
//                      ? AppwriteImageMemory(
//                          fileId: bgPhoto,
//                        )
//                      : Image.asset("assets/images/anchk-logo.PNG"),
//                  //Image.asset(anchkMissionPhoto),
//                ),
//              ],
//            );
//            //mission(snapshot.data!);
////            return Text("DATA: ${snapshot.data}");
//          } else if (snapshot.hasError) {
//            return Text("ERROR: ${snapshot.error}");
//          } else {
//            return const Text('None');
//          }
////          return missionColumn();
//        });
//  }
}
