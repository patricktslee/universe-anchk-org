import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/presentation/controllers/navigation_controller.dart';
import 'package:universe/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/presentation/controllers/menu_controller.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation(BuildContext context, GlobalKey<ScaffoldState> key)
      : super(key: key);

//  final MenuItem currentTab;
//  final ValueChanged<MenuItem> onSelectTab;
  static MenuController menuController = Get.find();
  static NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        for (MenuItem item in sideMenuItemRoutes)
          BottomNavigationBarItem(
            icon: menuController.returnIconFor(item.name),
            label: item.name,
          )
      ],
      currentIndex: menuController.selectedIndex.value,
      selectedItemColor: active,
      unselectedItemColor: Colors.amber[800],
      onTap: (value) {
        print("bottomNavigation index is $value");
        menuController.changeSelectedIndex(value);
        if (sideMenuItemRoutes[value].route == authenticationPageRoute) {
          Get.offAllNamed(authenticationPageRoute);
          menuController.changeSelectedIndex(0);
          menuController.changeActiveItemTo(overviewPageDisplayName);
        } else {
          menuController.changeActiveItemTo(sideMenuItemRoutes[value].name);
          navigationController.navigateTo(sideMenuItemRoutes[value].route);
        }
      },
    );
  }
}
