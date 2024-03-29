import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class RequirementWidget extends StatelessWidget {
  RequirementWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();
  static String bgPhoto = "";
  static List requirementItem = [];
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SelectableRegion(
        focusNode: _focusNode,
        selectionControls: materialTextSelectionControls,
        child: getRequirement(context));
  }

  Widget getRequirement(BuildContext context) {
    controller.getRequirementItem();
    return Obx(() {
      return _requirementWidget(context);
    });
  }

  Widget _requirementWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: SizedBox(
              width: 750,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.memory(
                  controller.requirement.value.photoFile as Uint8List,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            children: controller.requirement.value.message!
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controller.requirement.value.message!.indexOf(item) ==
                                  controller.requirement.value.message!.length -
                                      1
                              ? Row(
                                  children: [
                                    //const SizedBox(
                                    //  width: 28,
                                    //),
                                    Icon(Icons.star_border_sharp,
                                        size: 22, color: blackColor),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    CustomText(
                                      text:
                                          '${(controller.requirement.value.message!.indexOf(item) + 1).toString()}.  ',
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: item.text.toString(),
                              size: standardTextSize,
                              weight: FontWeight.bold,
                              color: blackColor,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      );
}
