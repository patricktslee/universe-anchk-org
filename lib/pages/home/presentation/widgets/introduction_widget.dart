import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/appwrite_image_memory.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    Key? key,
  }) : super(key: key);
  static HomeController controller = Get.find();
  static String bgPhoto = "";

//  Column introductionColumn() => Column(
//        children: [
//          Column(
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: //controller.anchkOrganizationItem
//                .map(
//                  (item) => Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.symmetric(vertical: 8),
//                        child: Center(
//                          child: CustomText(
//                            text: item.text.toString(),
//                            size: standardTextSize,
//                            weight: FontWeight.bold,
//                            color: blackColor,
//                            textAlign: TextAlign.center,
//                          ),
//                        ),
//                      ),
//                      //controller.anchkOrganizationItem.indexOf(item) <
//                              //controller.anchkOrganizationItem.length - 1
//                          ? Padding(
//                              padding: const EdgeInsets.only(
//                                top: 8,
//                                bottom: 8,
//                              ),
//                              child: Container(
//                                height: 20,
//                                width: 200,
//                                decoration: BoxDecoration(
//                                  image: DecorationImage(
//                                      image: AssetImage(divider),
//                                      fit: BoxFit.cover),
//                                ),
//                              ),
//                            )
//                          : Container(),
//                    ],
//                  ),
//                )
//                .toList(),
//          ),
//          const SizedBox(
//            height: 24,
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
//            child: SizedBox(
//              width: 750,
//              child: AspectRatio(
//                aspectRatio: 4 / 3,
//                child: Container(
//                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                          //                                  image: AssetImage(item.photo.toString()),
//                          image: NetworkImage(bgPhoto),
//                          fit: BoxFit.cover)),
//                ),
//              ),
//            ),
//          ),
////          ClipRRect(
////            borderRadius: BorderRadius.circular(8.0),
////            child: Image.asset(anchkOrgPhoto),
////          ),
//        ],
//      );

  Column anchkOrganization(List<dynamic> anchkOrganizationItem) => Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: anchkOrganizationItem
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
                      anchkOrganizationItem.indexOf(item) <
                              anchkOrganizationItem.length - 1
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
          //Padding(
          //  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          //  child: SizedBox(
          //    width: 750,
          //    child: AspectRatio(
          //      aspectRatio: 4 / 3,
          //      child: Container(
          //        decoration: BoxDecoration(
          //            image: DecorationImage(
          //                //                                  image: AssetImage(item.photo.toString()),
          //                image: NetworkImage(bgPhoto),
          //                fit: BoxFit.cover)),
          //      ),
          //    ),
          //  ),
          //),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: AppwriteImageMemory(fileId: bgPhoto),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return anchkOrganizationMethod();
  }

  Widget anchkOrganizationMethod() {
    controller.getAnchkOrganizationItem();
    return Obx(() {
      return Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: //controller.anchkOrganizationItem
                controller.introdutcion.value.message!
                    .toList()
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
                          //controller.anchkOrganizationItem
                          controller.introdutcion.value.message!
                                      .toList()
                                      .indexOf(item) <
                                  //controller.anchkOrganizationItem
                                  controller.introdutcion.value.message!
                                          .toList()
                                          .length -
                                      1
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
            child: Image.memory(
              controller.introdutcion.value.photoFile as Uint8List,
//                  controller.preachersMessagePhotoFile.value,
              fit: BoxFit.cover,
            ),
            //AppwriteImageMemory(
            //  fileId: controller.anchkOrganizationPhoto.value,
            //  quality: 100,
            //),
          ),
        ],
      );
    });
  }

  Future<FutureBuilder<List<dynamic>>> newMethod() async {
    return FutureBuilder<List<dynamic>>(
        future: controller.getAnchkOrganizationItem().then((value) async {
          await controller.getPhotoFileId("anchkOrganization").then((photo) {
            bgPhoto = photo;
//          return value;
          });
          return value;
        }),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!
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
                            snapshot.data!.indexOf(item) <
                                    snapshot.data!.length - 1
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
                  child: (snapshot.hasData)
                      ? AppwriteImageMemory(
                          fileId: bgPhoto,
                        )
                      : Image.asset("assets/images/anchk-logo.PNG"),
                ),
              ],
            );
            //anchkOrganization(snapshot.data!);
//            return Text("DATA: ${snapshot.data}");
          } else if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          } else {
            return const Text('None');
          }
//          return introductionColumn();
        });
  }
}
