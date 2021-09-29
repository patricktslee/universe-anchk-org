import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/overview_cards_large.dart';
import 'package:universe/pages/home/presentation/widgets/overview_cards_medium.dart';
import 'package:universe/pages/home/presentation/widgets/overview_cards_small.dart';
import 'package:universe/pages/home/presentation/widgets/revenue_section_large.dart';
import 'package:universe/pages/home/presentation/widgets/revenue_section_small.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/presentation/controllers/menu_controller.dart';

class IntroductionPage extends StatelessWidget {
  static HomeController menuController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top:
                              ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                      child: CustomText(
                        text: menuController.activeItem.value,
                        size: 24,
                        weight: FontWeight.bold,
                        color: blackColor,
                      )),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                if (ResponsiveWidget.isLargeScreen(context) ||
                    ResponsiveWidget.isMediumScreen(context))
                  if (ResponsiveWidget.isCustomSize(context))
                    OverviewCardsMediumScreen()
                  else
                    OverviewCardsLargeScreen()
                else
                  OverviewCardsSmallScreen(),
                if (!ResponsiveWidget.isSmallScreen(context))
                  RevenueSectionLarge()
                else
                  RevenueSectionSmall(),
                Container(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
