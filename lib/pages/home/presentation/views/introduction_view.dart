import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/introduction_widget.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/presentation/widgets/mission_widget.dart';
import 'package:universe/widgets/custom_text.dart';

class IntroductionPage extends StatelessWidget {
  static HomeController controller = Get.find();

  CustomText missionName() => CustomText(
        text: "詠團宗旨",
        size: standardTextSize,
        weight: FontWeight.bold,
        textAlign: TextAlign.center,
        color: redWine,
      );

  Padding introductionColumn() => Padding(
        padding: customMainTitleEdgeInsets(),
        child: Column(
          children: [
            const MainTitle(),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const IntroductionWidget(),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomText(
                      text: "詠團宗旨",
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: redWine,
                    ),
                    const MissionWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Padding introductionRow() => Padding(
        padding: customMainTitleEdgeInsets(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MainTitle(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 1,
                    child: IntroductionWidget(),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        missionName(),
                        const MissionWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Padding introductionPaddingOldDesign() => Padding(
        padding: customMainTitleEdgeInsets(),
        child: Column(
          children: const [
            MainTitle(),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: IntroductionWidget(),
              ),
            ),
          ],
        ),
      );

  const IntroductionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isiPadScreen(context)
        ? introductionColumn()
        : introductionRow();
  }
}
