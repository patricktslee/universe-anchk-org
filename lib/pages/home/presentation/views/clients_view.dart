import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/presentation/controllers/menu_controller.dart1';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);
  static MenuController menuController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                      color: blackColor,
                    )),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              Container(),
            ],
          )),
        ],
      ),
    );
  }
}
