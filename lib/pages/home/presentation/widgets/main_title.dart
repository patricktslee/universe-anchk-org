import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    Key? key,
    //  required this.menuController,
  }) : super(key: key);

//  final HomeController menuController;
  static HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
//            height: 75,
            margin: EdgeInsets.only(
                top: ResponsiveWidget.isSmallScreen(context) ? 0 : 6),
            child: CustomText(
              text: controller.activeItem.value,
              size: standardTextSize,
              weight: FontWeight.bold,
              color: redWine,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: const [
                CustomText(
                    text: "所以，你們要去，使萬民作我的門徒，奉父、子、聖靈的名給他們施浸。",
                    size: 12,
                    color: Colors.red,
                    weight: FontWeight.normal),
                CustomText(
                    text: "馬太福音 28:19",
                    size: 12,
                    color: Colors.red,
                    weight: FontWeight.normal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
