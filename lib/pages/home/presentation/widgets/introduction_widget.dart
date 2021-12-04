import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    Key? key,
  }) : super(key: key);
  static HomeController controller = Get.find();

  Column introductionColumn() => Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.anchkOrganizationItem
                .map(
                  (item) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: CustomText(
                            text: item.text.toString(),
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: blackColor,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      controller.anchkOrganizationItem.indexOf(item) <
                              controller.anchkOrganizationItem.length - 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Container(
                                height: 20,
                                width: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(divider),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 24,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(anchkOrgPhoto),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return introductionColumn();
  }
}
