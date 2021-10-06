import 'package:flutter/material.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/controllers/menu_controller.dart1';
import 'package:universe/pages/home/presentation/controllers/navigation_controller.dart';
import 'package:universe/routing/routes.dart';
import 'package:universe/widgets/custom_box_decoration.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:universe/widgets/organization_text.dart';
import 'package:universe/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);
  static MenuController menuController = Get.find();
  static NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
//    double _width = MediaQuery.of(context).size.width;

    return Container(
      decoration: customBoxDecoration(),
//      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
//                    SizedBox(width: _width / 480),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          height: 50,
                          child: Image.asset(logoPath),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: OrganizationText(
                        size: 20,
                        weight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
//                    SizedBox(width: _width / 48),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          MenuList(
              menuController: menuController,
              navigationController: navigationController)
        ],
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  const MenuList({
    Key? key,
    required this.menuController,
    required this.navigationController,
  }) : super(key: key);

  final MenuController menuController;
  final NavigationController navigationController;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: sideMenuItemRoutes
          .map((item) => SideMenuItem(
              itemName: item.name,
              onTap: () {
                if (item.route == authenticationPageRoute) {
                  Get.offAllNamed(authenticationPageRoute);
                } else if (!controller.isActive(item.name)) {
                  controller.changeActiveItemTo(item.name);
                  if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                  controller.navigateTo(item.route);
                }
              }))
          .toList(),
    );
  }
}
