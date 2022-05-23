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

//  final MenuItem currentTab;
//  final ValueChanged<MenuItem> onSelectTab;
  static HomeController menuController = Get.find();
//  static NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
<<<<<<< HEAD
        for (CustomMenuItem item in sideMenuItemRoutes)
=======
        for (MenuItem item in sideMenuItemRoutes)
>>>>>>> 6077b954d1085a48aa239ddb1f826fb3e36cb110
          BottomNavigationBarItem(
            icon: menuController.returnIconFor(item.name),
            label: item.name,
          )
      ],
      currentIndex: menuController.selectedIndex.value,
      selectedItemColor: active,
      unselectedItemColor: Colors.amber[800],
      onTap: (value) {
        logger.i("bottomNavigation index is $value");
        menuController.changeSelectedIndex(value);
        if (sideMenuItemRoutes[value].route == authenticationPageRoute) {
          Get.offAllNamed(authenticationPageRoute);
          menuController.changeSelectedIndex(0);
          menuController.changeActiveItemTo(introductionPageDisplayName);
        } else {
          menuController.changeActiveItemTo(sideMenuItemRoutes[value].name);
          menuController.navigateTo(sideMenuItemRoutes[value].route);
        }
      },
    );
  }
}
