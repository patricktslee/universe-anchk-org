//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/domain/entity/conductor.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:get/get.dart';

class ConductorPage extends StatelessWidget {
  static HomeController controller = Get.find();

  const ConductorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Conductor>(
        future: controller.getConductor().then((value) => value),
        builder: (context, snapshot) {
          return Padding(
            padding: customMainTitleEdgeInsets(),
            child: Column(
              children: [
                const MainTitle(),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount:
                        ResponsiveWidget.isSmallScreen(context) ? 1 : 2,
                    childAspectRatio:
                        ResponsiveWidget.isSmallScreen(context) ? 0.85 : 0.5,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              //                  child: Image.asset(
                              //                    mrIPPhoto,
                              child: Image.network(
                                'https://appwrite.anchk.org/v1/storage/files/62148e3a9e00d52ee4e6/view?project=61b0428203f09&mode=admin',
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
//                          text: controller.conductorMessagetext.value,
                            text: (snapshot.hasData)
                                ? snapshot.data!.message!
                                : "No data",
                            size: standardTextSize,
                            weight: FontWeight.bold,
                            color: blackColor,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
