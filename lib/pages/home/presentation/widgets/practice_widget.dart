//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
//import 'package:universe/helpers/appwrite_image_memory.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/shared/app_constants.dart';
import 'package:universe/widgets/custom_text.dart';

class PracticeWidget extends StatelessWidget {
  const PracticeWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();
  static String bgPhoto = "";
  static List practicePlaceItem = [];
  static List practiceTimeItem = [];

  @override
  Widget build(BuildContext context) {
    return getPractice(context);
  }

  Widget getPractice(BuildContext context) {
    controller.getPracticeInfo();
    return Obx(
      () {
        return (controller.practice.value.photo == "loadingdata")
            ? const CustomText(
                text: "數據加載中....",
                color: AppConstants.defaultTextColor,
                size: 30,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: ResponsiveWidget.isSmallScreen(context)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _practiceTime(),
                              const SizedBox(
                                width: 16,
                              ),
                              _practicePlace(),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: _practiceTime()),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(child: _practicePlace()),
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: ResponsiveWidget.isSmallScreen(context)
                                ? 485
                                : 588,
                            height: ResponsiveWidget.isSmallScreen(context)
                                ? 314
                                : 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.memory(
                                      controller.practice.value.photoFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                CustomText(
                                    text: "鳴謝宣道浸信會提供地圖相片",
                                    size: 12,
                                    color: dark,
                                    weight: FontWeight.normal),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }

//  Widget practiceColumn(BuildContext context) => Expanded(
//          child: SingleChildScrollView(
//        child: Column(
//          children: [
//            Padding(
//              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//              child: ResponsiveWidget.isSmallScreen(context)
//                  ? Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        _practiceTime(),
//                        const SizedBox(
//                          width: 16,
//                        ),
//                        _practicePlace(),
//                      ],
//                    )
//                  : Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        Expanded(child: _practiceTime()),
//                        const SizedBox(
//                          width: 16,
//                        ),
//                        Expanded(child: _practicePlace()),
//                      ],
//                    ),
//            ),
//            Padding(
//              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: [
//                  Expanded(
//                    flex: 1,
//                    child: SizedBox(
//                      width:
//                          ResponsiveWidget.isSmallScreen(context) ? 485 : 588,
//                      height:
//                          ResponsiveWidget.isSmallScreen(context) ? 314 : 400,
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisSize: MainAxisSize.max,
//                        children: [
//                          Expanded(
//                            child: AspectRatio(
//                              aspectRatio: 16 / 9,
//                              child: Container(
//                                width: 250,
//                                decoration: BoxDecoration(
//                                    image: DecorationImage(
//                                        //                                  image: AssetImage(item.photo.toString()),
//                                        image: NetworkImage(bgPhoto),
//                                        fit: BoxFit.cover)),
//                              ),
//                            ),
//                          ),
//                          CustomText(
//                              text: "鳴謝宣道浸信會提供地圖相片",
//                              size: 12,
//                              color: dark,
//                              weight: FontWeight.normal),
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ));
//
//  Widget practiceListView(BuildContext context) => Expanded(
//          child: ListView(
//        children: [
//          Padding(
//            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//            child: ResponsiveWidget.isSmallScreen(context)
//                ? Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      _practiceTime(),
//                      const SizedBox(
//                        width: 16,
//                      ),
//                      _practicePlace(),
//                    ],
//                  )
//                : Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      Expanded(child: _practiceTime()),
//                      const SizedBox(
//                        width: 16,
//                      ),
//                      Expanded(child: _practicePlace()),
//                    ],
//                  ),
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                Expanded(
//                  flex: 1,
//                  child: SizedBox(
//                    width: ResponsiveWidget.isSmallScreen(context) ? 485 : 588,
//                    height: ResponsiveWidget.isSmallScreen(context) ? 314 : 400,
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisSize: MainAxisSize.max,
//                      children: [
//                        CustomText(
//                            text: "鳴謝宣道浸信會提供地圖相片",
//                            size: 12,
//                            color: dark,
//                            weight: FontWeight.normal)
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ));

  Column _practicePlace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: '練習地點',
          size: standardTextSize,
          weight: FontWeight.bold,
          color: redWine,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.practice.value.practicePlace!
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SelectionArea(
                      child: CustomText(
                        text: item.text.toString(),
                        size: standardTextSize,
                        weight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Column _practiceTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: '練習詩間',
          size: standardTextSize,
          weight: FontWeight.bold,
          color: redWine,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.practice.value.practiceTime!
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SelectionArea(
                      child: CustomText(
                        text: item.text.toString(),
                        size: standardTextSize,
                        weight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
