import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
//import 'package:universe/pages/home/presentation/controllers/navigation_controller.dart';
import 'package:universe/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:universe/pages/home/presentation/controllers/menu_controller.dart1';

class BottomNavigation extends StatelessWidget {
//  const BottomNavigation(BuildContext context, GlobalKey<ScaffoldState> key)
  BottomNavigation({Key? key}) : super(key: key);
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  static HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List<CustomMenuItem> _customMenuItem;
    return Obx(() {
      (controller.providerBox == "anonymous")
          ? _customMenuItem = mobileBottomNavigatorBarGuestRoutes
          : _customMenuItem = mobileBottomNavigatorBarRoutes;
      return customBottomNavigationBar1(_customMenuItem);
    });
  }

  BottomNavigationBar customBottomNavigationBar1(
      List<CustomMenuItem> customMenuItem) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        for (CustomMenuItem item in customMenuItem)
          BottomNavigationBarItem(
            icon: controller.returnIconFor(item.name),
            label: item.name,
          )
      ],
      currentIndex: controller.selectedIndex.value,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: blue,
      selectedItemColor: blueGreen,
      unselectedItemColor: lemon,
      onTap: (value) {
        logger.i("bottomNavigation index is $value");
        controller.changeSelectedIndex(value);
        if (customMenuItem[value].route == authenticationPageRoute) {
          Get.offAllNamed(authenticationPageRoute);
          controller.changeSelectedIndex(0);
          controller.changeActiveItemTo(introductionPageDisplayName);
        } else {
          controller.changeActiveItemTo(customMenuItem[value].name);
          controller.navigateTo(customMenuItem[value].route);
        }
      },
    );
  }
}
