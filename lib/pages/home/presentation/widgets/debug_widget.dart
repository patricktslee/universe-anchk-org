import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class DebugWidget extends StatelessWidget {
  const DebugWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    RxList<dynamic> _item = controller.apiLogList;
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _item
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: item.toString(),
                        size: standardTextSize,
                        weight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  )
                  .toList(),
            )),
      ),
    );
  }
}
