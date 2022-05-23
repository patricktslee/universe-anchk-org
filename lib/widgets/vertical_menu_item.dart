import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
//import 'package:universe/pages/home/presentation/controllers/menu_controller.dart1';

import 'custom_text.dart';

class VertticalMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const VertticalMenuItem(
      {Key? key, required this.itemName, required this.onTap})
      : super(key: key);
  static HomeController menuController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(() => Container(
              color: menuController.isHovering(itemName)
                  ? lightGrey.withOpacity(.1)
                  : Colors.transparent,
              child: Row(
                children: [
                  Visibility(
                    visible: menuController.isHovering(itemName) ||
                        menuController.isActive(itemName),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      width: 3,
                      height: 72,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: menuController.returnIconFor(itemName),
                        ),
                        if (!menuController.isActive(itemName))
                          Flexible(
                              child: CustomText(
                            text: itemName,
                            color: menuController.isHovering(itemName)
                                ? menuHoverColor
                                : menuColor,
                            size: standardTextSize,
                            weight: FontWeight.normal,
                          ))
                        else
                          Flexible(
                              child: CustomText(
                            text: itemName,
                            color: menuActiveColor,
                            size: standardTextSize,
                            weight: FontWeight.bold,
                          ))
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
