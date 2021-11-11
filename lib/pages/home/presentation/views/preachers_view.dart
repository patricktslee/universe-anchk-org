import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/preacher_widget.dart';
import 'package:get/get.dart';

class PreachersPage extends StatelessWidget {
  static HomeController menuController = Get.find();

  const PreachersPage({Key? key}) : super(key: key);
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

    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          MainTitle(menuController: menuController),
          //ResponsiveWidget.isSmallScreen(context)
          //    ? Expanded(
          //        child: ListView(
          //          children: [
          //            PreacherWidget(
          //                menuController: menuController,
          //                responsiveFontSize: responsiveFontSize),
          //          ],
          //        ),
          //      )
          //    :
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PreacherWidget(
                      menuController: menuController,
                      responsiveFontSize: responsiveFontSize,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
          ),
//          Expanded(
//            child: GridView.count(
//              crossAxisSpacing: 8,
//              mainAxisSpacing: 8,
//              crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 1 : 2,
//              childAspectRatio: 0.65,
//              children: [
//                _profile(),
//                _description(),
//              ],
//            ),
//          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
