import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/shared/app_constants.dart';
import 'package:universe/widgets/custom_text.dart';

class WhatnewsGroupWidget extends StatelessWidget {
  const WhatnewsGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = ResponsiveWidget.isSmallScreen(context)
        ? 400
        : ResponsiveWidget.isLargeScreen(context)
            ? 650
            : 500;
    return getWhatNews(cardWidth);
  }

  Widget getWhatNews(double cardWidth) {
    HomeController controller = Get.find();
    controller.getWhatNews();
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return (controller.whatNews.isEmpty)
                  ? const CustomText(
                      text: "數據加載中....",
                      color: AppConstants.defaultTextColor,
                      size: 30,
                      weight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: controller.whatNews
                            .map((item) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: cardWidth,
                                          height: 9 / 16 * cardWidth,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: item.isCompleted!
                                                    ? const [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              253, 253, 150, 1),
                                                          blurRadius: 20.0,
                                                        ),
                                                      ]
                                                    : const [
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          blurRadius: 20.0,
                                                        ),
                                                      ],
                                                image: DecorationImage(
//                        image: AssetImage(whatNewsBG), fit: BoxFit.cover)),
                                                    image: MemoryImage(
                                                        item.bgPhotoFile
                                                            as Uint8List),
                                                    fit: BoxFit.cover)),
                                            //NetworkImage(
                                            //    item.bgPhoto.toString()),
                                            //fit: BoxFit.cover)),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Positioned(
                                                  top: 5 +
                                                      (cardWidth / 15.5) / 2,
                                                  child: SizedBox(
                                                    width: cardWidth * (1 / 2),
                                                    height: 10 /
                                                        16 *
                                                        (cardWidth * (1 / 2)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              //                                  image: AssetImage(item.photo.toString()),
                                                              image:
                                                                  //NetworkImage(item
                                                                  //    .bgPhoto
                                                                  //    .toString()),
                                                                  //fit: BoxFit.cover)),
                                                                  MemoryImage(item.photoFile as Uint8List),
                                                              fit: BoxFit.cover)),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom:
                                                      (9 / 16 * cardWidth) / 5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomText(
                                                      text:
                                                          item.event.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      size: standardTextSize,
                                                      weight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom:
                                                      ((9 / 16 * cardWidth) /
                                                              5) -
                                                          30,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomText(
                                                      text:
                                                          item.place.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      size: standardTextSize,
                                                      weight: FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: item.isCompleted!
                                                      ? const Icon(
                                                          Icons.done_outline,
                                                          color: Colors.green,
                                                          size: 60,
                                                        )
                                                      : const Icon(
                                                          Icons.run_circle,
                                                          color: Colors.yellow,
                                                          size: 50,
                                                        ),
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  left: 5,
                                                  child: SizedBox(
                                                    width: cardWidth / 7,
                                                    height:
                                                        (cardWidth / 15.5) * 2,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.blue),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromRGBO(
                                                                61, 61, 61, 1),
                                                            Colors.white,
                                                          ],
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: CustomText(
                                                          text: item.year
                                                                  .toString() +
                                                              "年",
                                                          textAlign:
                                                              TextAlign.center,
                                                          size: smallTextSize,
                                                          weight:
                                                              FontWeight.bold,
                                                          color: blackColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  left: 5 + (cardWidth / 7),
                                                  child: SizedBox(
                                                    width: cardWidth / 11,
                                                    height: (cardWidth / 15.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.blue),
                                                        color: blackColor,
                                                      ),
                                                      child: Center(
                                                        child: CustomText(
                                                          text: item.day! < 10
                                                              ? "0" +
                                                                  item.day
                                                                      .toString()
                                                              : item.day
                                                                  .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          size: smallTextSize,
                                                          weight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 5 + (cardWidth / 15.5),
                                                  left: 5 + (cardWidth / 7),
                                                  child: SizedBox(
                                                    width: cardWidth / 11,
                                                    height: (cardWidth / 15.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.blue),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: CustomText(
                                                          text: item.month
                                                                  .toString() +
                                                              "月",
                                                          textAlign:
                                                              TextAlign.center,
                                                          size: smallTextSize,
                                                          weight:
                                                              FontWeight.bold,
                                                          color: blackColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}