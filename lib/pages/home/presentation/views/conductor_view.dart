import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:get/get.dart';

class ConductorPage extends StatelessWidget {
  static HomeController menuController = Get.find();

  const ConductorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          MainTitle(menuController: menuController),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 1 : 2,
              childAspectRatio:
                  ResponsiveWidget.isSmallScreen(context) ? 0.85 : 0.5,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(mrIPPhoto),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: menuController.conductorMessagetext.value,
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: blackColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
