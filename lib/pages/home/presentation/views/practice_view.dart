import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PracticePage extends StatelessWidget {
  static HomeController menuController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          MainTitle(menuController: menuController),
          Expanded(
            child: ListView(
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
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(mapPhoto),
                                ),
                              ),
                              CustomText(
                                  text: "鳴謝宣道浸信會提供地圖相片",
                                  size: 12,
                                  color: dark,
                                  weight: FontWeight.normal)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
          children: menuController.practicePlaceItem
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomText(
                      text: item.text.toString(),
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: blackColor,
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
          children: menuController.practiceTimeItem
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomText(
                      text: item.text.toString(),
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
