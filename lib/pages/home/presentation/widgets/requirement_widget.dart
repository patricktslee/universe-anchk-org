import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class RequirementWidget extends StatelessWidget {
  const RequirementWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return _requirementWidget(context);
  }

  Widget _requirementWidget(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width:
                            ResponsiveWidget.isSmallScreen(context) ? 599 : 767,
//                        height:
//                            ResponsiveWidget.isSmallScreen(context) ? 350 : 450,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(requirementPhoto)),
                      ),
                    ),
                    SizedBox(
                        width: ResponsiveWidget.isLargeScreen(context)
                            ? 200
                            : ResponsiveWidget.isMediumScreen(context)
                                ? 100
                                : 1)
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.requirementItem
                    .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.requirementItem.indexOf(item) ==
                                      controller.requirementItem.length - 1
                                  ? Row(
                                      children: [
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Icon(Icons.star_border_sharp,
                                            size: 22, color: blackColor),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    )
                                  : CustomText(
                                      text:
                                          '${(controller.requirementItem.indexOf(item) + 1).toString()}.  ',
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                              Expanded(
                                child: CustomText(
                                  text: item.text.toString(),
                                  size: standardTextSize,
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      );
}
