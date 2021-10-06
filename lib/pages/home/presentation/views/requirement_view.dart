import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RequirementPage extends StatelessWidget {
  static HomeController menuController = Get.find();
  @override
  Widget build(BuildContext context) {
    print('requirement ${MediaQuery.of(context).size.width - 760 - 400}');
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          MainTitle(menuController: menuController),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: ResponsiveWidget.isSmallScreen(context)
                              ? 599
                              : 767,
//                        height:
//                            ResponsiveWidget.isSmallScreen(context) ? 350 : 450,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(requirementPhoto)),
                        ),
                      ),
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
                  children: menuController.requirementItem
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                menuController.requirementItem.indexOf(item) ==
                                        4
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
                                        text:
                                            '${(menuController.requirementItem.indexOf(item) + 1).toString()}.  ',
                                        size: 22,
                                        weight: FontWeight.bold,
                                        color: blackColor,
                                      ),
                                Expanded(
                                  child: CustomText(
                                    text: item.text.toString(),
                                    size: 22,
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
        ],
      ),
    );
  }
}
