import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
//import 'package:universe/helpers/appwrite_image_memory.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class RequirementWidget extends StatelessWidget {
  const RequirementWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();
  static String bgPhoto = "";
  static List requirementItem = [];

  @override
  Widget build(BuildContext context) {
    return getRequirement(context);
  }

  Widget getRequirement(BuildContext context) {
    controller.getRequirementItem();
    return Obx(() {
      return _requirementWidget(context);
    });
  }

  Future<FutureBuilder<Object>> newMethod() async {
    return FutureBuilder<Object>(
        future: controller.getPhoto("requirement").then((value) async {
          bgPhoto = value;
          await controller
              .getRequirementItem()
              .then((value) => requirementItem = value);
          return value;
        }),
        builder: (context, snapshot) {
          return _requirementWidget(context);
        });
  }

  Widget _requirementWidget(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: SizedBox(
                  width: 750,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.memory(
                      controller.requirement.value.photoFile as Uint8List,
//                  controller.preachersMessagePhotoFile.value,
                      fit: BoxFit.cover,
                    ),
                    //AppwriteImageMemory(
                    //  fileId: controller.requirementPhoto.value,
                    //),
                    //Container(
                    //  decoration: BoxDecoration(
                    //      image: DecorationImage(
                    //          //                                  image: AssetImage(item.photo.toString()),
                    //          image: NetworkImage(bgPhoto),
                    //          fit: BoxFit.cover)),
                    //),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//                    Expanded(
//                      flex: 1,
//                      child: SizedBox(
//                        width:
//                            ResponsiveWidget.isSmallScreen(context) ? 599 : 767,
////                        height:
////                            ResponsiveWidget.isSmallScreen(context) ? 350 : 450,
//                        child: ClipRRect(
//                            borderRadius: BorderRadius.circular(8.0),
//                            child: Image.asset(requirementPhoto)),
//                      ),
//                    ),
                    SizedBox(
                        width: ResponsiveWidget.isLargeScreen(context)
                            ? 200
                            : ResponsiveWidget.isMediumScreen(context)
                                ? 100
                                : 1)
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: //requirementItem //
                    //controller.requirementItem
                    controller.requirement.value.message!
                        .map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
//                              requirementItem.indexOf(item) ==
//                                      requirementItem.length - 1
                                  //controller.requirementItem
                                  controller.requirement.value.message!
                                              .indexOf(item) ==
                                          // controller.requirementItem
                                          controller.requirement.value.message!
                                                  .length -
                                              1
                                      ? Row(
                                          children: [
                                            const SizedBox(
                                              width: 32,
                                            ),
                                            Icon(Icons.star_border_sharp,
                                                size: 22, color: blackColor),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        )
                                      : CustomText(
                                          text: '${(
                                              //controller.requirementItem
                                              controller.requirement.value.message!.indexOf(item) + 1).toString()}.  ',
//                                          '${(requirementItem.indexOf(item) + 1).toString()}.  ',
                                          size: standardTextSize,
                                          weight: FontWeight.bold,
                                          color: blackColor,
                                        ),
                                  Expanded(
                                    child: CustomText(
                                      text: item.text.toString(),
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
              ),
            ],
          ),
        ),
      );
}
