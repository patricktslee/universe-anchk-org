import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/conductor_widget.dart';
import 'package:universe/pages/home/presentation/widgets/introduction_widget.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/mission_widget.dart';
import 'package:universe/pages/home/presentation/widgets/practice_widget.dart';
import 'package:universe/pages/home/presentation/widgets/preacher_widget.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/presentation/widgets/requirement_widget.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:universe/routing/routes.dart';

class AnchkORGPage extends StatelessWidget {
  static HomeController controller = Get.find();

  AnchkORGPage({Key? key}) : super(key: key);
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  @override
  Widget build(BuildContext context) {
    double size = 14;
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = ResponsiveWidget.isSmallScreen(context)
        ? screenWidth < 330
            ? size
            : screenWidth >= 300 && screenWidth < 400
                ? size + 2
                : size + 3
        : ResponsiveWidget.isMediumScreen(context)
            ? size + 8
            : size + 10;
    //logger.i("ResponsiveWidget.isSmallMediumScreen(context) is ${ResponsiveWidget.isSmallMediumScreen(context).toString()}");
    return anchkorgWidget(context, responsiveFontSize);
    //customPadding(context, responsiveFontSize);
  }

  Widget anchkorgWidget(BuildContext context, double responsiveFontSize) =>
      ResponsiveWidget.isiPadScreen(context)
          ? customColumn3(context, responsiveFontSize)
          : customRow(context, responsiveFontSize);

  CustomText missionName() => CustomText(
        text: missionPageDisplayName,
        size: standardTextSize,
        weight: FontWeight.bold,
        textAlign: TextAlign.center,
        color: redWine,
      );

  CustomText conductorName() => CustomText(
        text: "詠團$leadersPageDisplayName",
        size: standardTextSize,
        weight: FontWeight.bold,
        textAlign: TextAlign.center,
        color: redWine,
      );

  CustomText requirementDisplayName() => CustomText(
        text: requirementPageDisplayName,
        size: standardTextSize,
        weight: FontWeight.bold,
        textAlign: TextAlign.center,
        color: redWine,
      );

  Widget _buildListView(BuildContext context, double responsiveFontSize) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth,
      height: 550.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
//        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(
            width: deviceWidth,
//            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConductorWidget(
                controller: controller,
                responsiveFontSize: responsiveFontSize,
                width: ResponsiveWidget.isSmallMediumScreen(context)
                    ? MediaQuery.of(context).size.width / 3 * 2.2
                    : MediaQuery.of(context).size.width,
              ),
            ),
          ),
          SizedBox(
            width: 350,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PreacherWidget(
                controller: controller,
                responsiveFontSize: responsiveFontSize,
                width: ResponsiveWidget.isSmallMediumScreen(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customColumn3(BuildContext context, double responsiveFontSize) =>
      Padding(
        padding: customMainTitleEdgeInsets(),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: <Widget>[
              const MainTitle(),
              const IntroductionWidget(),
              const SizedBox(
                height: 50,
              ),
              missionName(),
              const MissionWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 36),
                child: conductorName(),
              ),
              _buildListView(context, responsiveFontSize),
              const PracticeWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 36),
                child: requirementDisplayName(),
              ),
              const RequirementWidget(),
            ],
          ),
        ),
      );

  Widget customColumn2(BuildContext context, double responsiveFontSize) =>
      Padding(
        padding: customMainTitleEdgeInsets(),
        child: Column(
          children: [
            const MainTitle(),
            Expanded(
              child: SizedBox(
                height: 500,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 400,
                      height: 450,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ConductorWidget(
                          controller: controller,
                          responsiveFontSize: responsiveFontSize,
                          width: ResponsiveWidget.isSmallMediumScreen(context)
                              ? MediaQuery.of(context).size.width / 3 * 2.2
                              : MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PreacherWidget(
                          controller: controller,
                          responsiveFontSize: responsiveFontSize,
                          width: ResponsiveWidget.isSmallMediumScreen(context)
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget customColumn(BuildContext context, double responsiveFontSize) =>
      Padding(
        padding: customMainTitleEdgeInsets(),
        child: Column(
          children: [
            const MainTitle(),
            Expanded(
//              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const IntroductionWidget(),
                    const SizedBox(
                      height: 50,
                    ),
                    missionName(),
                    const MissionWidget(),
                    Expanded(
                      child: SizedBox(
                        height: 600,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            SizedBox(
                              width: 350,
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ConductorWidget(
                                  controller: controller,
                                  responsiveFontSize: responsiveFontSize,
                                  width: ResponsiveWidget.isSmallMediumScreen(
                                          context)
                                      ? MediaQuery.of(context).size.width /
                                          3 *
                                          2.2
                                      : MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: PreacherWidget(
                                  controller: controller,
                                  responsiveFontSize: responsiveFontSize,
                                  width: ResponsiveWidget.isSmallMediumScreen(
                                          context)
                                      ? MediaQuery.of(context).size.width
                                      : MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const PracticeWidget(),
                    const RequirementWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Padding customRow(BuildContext context, double responsiveFontSize) => Padding(
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
                        ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ConductorWidget(
                                controller: controller,
                                responsiveFontSize: responsiveFontSize,
                                width: ResponsiveWidget.isSmallMediumScreen(
                                        context)
                                    ? MediaQuery.of(context).size.width /
                                        3 *
                                        2.2
                                    : MediaQuery.of(context).size.width,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PreacherWidget(
                                controller: controller,
                                responsiveFontSize: responsiveFontSize,
                                width: ResponsiveWidget.isSmallMediumScreen(
                                        context)
                                    ? MediaQuery.of(context).size.width
                                    : MediaQuery.of(context).size.width,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Padding customPadding(BuildContext context, double responsiveFontSize) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          const MainTitle(),
          ResponsiveWidget.isiPadScreen(context)
              ? Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ConductorWidget(
                            controller: controller,
                            responsiveFontSize: responsiveFontSize,
                            width: ResponsiveWidget.isSmallMediumScreen(context)
                                ? MediaQuery.of(context).size.width / 3 * 2.2
                                : MediaQuery.of(context).size.width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PreacherWidget(
                            controller: controller,
                            responsiveFontSize: responsiveFontSize,
                            width: ResponsiveWidget.isSmallMediumScreen(context)
                                ? MediaQuery.of(context).size.width
                                : MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.75,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConductorWidget(
                              controller: controller,
                              responsiveFontSize: responsiveFontSize,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.75,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PreacherWidget(
                              controller: controller,
                              responsiveFontSize: responsiveFontSize,
                              width: MediaQuery.of(context).size.width / 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
