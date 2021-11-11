import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/conductor_widget.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/preacher_widget.dart';
import 'package:get/get.dart';

class LeadersPage extends StatelessWidget {
  static HomeController menuController = Get.find();

  const LeadersPage({Key? key}) : super(key: key);

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
    print(
        "ResponsiveWidget.isSmallMediumScreen(context) is ${ResponsiveWidget.isSmallMediumScreen(context).toString()}");
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          MainTitle(menuController: menuController),
          ResponsiveWidget.isSmallScreen(context)
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
                            menuController: menuController,
                            responsiveFontSize: responsiveFontSize,
                            width: ResponsiveWidget.isSmallMediumScreen(context)
                                ? MediaQuery.of(context).size.width / 3 * 2.2
                                : MediaQuery.of(context).size.width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PreacherWidget(
                            menuController: menuController,
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
                              menuController: menuController,
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
                              menuController: menuController,
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
