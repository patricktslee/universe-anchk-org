import 'dart:typed_data';

import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:get/get.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/appwrite_image_memory.dart';
import 'package:universe/pages/home/domain/entity/preacher.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';

class PreacherWidget extends StatelessWidget {
  const PreacherWidget({
    Key? key,
    required this.controller,
    required this.responsiveFontSize,
    required this.width,
  }) : super(key: key);

  final HomeController controller;
  final double responsiveFontSize;
  final double width;

  @override
  Widget build(BuildContext context) {
    return getPreacher();
  }

  Widget getPreacher() {
    controller.getPreacher();
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), // if you need this
            side: BorderSide(
              color: Colors.grey.withOpacity(0.6),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropCapText(
              controller.preacher.value.message.toString(),
//              controller.preachersMessagetext.value,
//                  (snapshot.hasData) ? snapshot.data!.message! : "No data",
              dropCapPosition: DropCapPosition.end,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: defaultFont,
                  fontSize: responsiveFontSize,
                  color: dark,
                  height: 1.5,
                  fontWeight: FontWeight.bold),
              dropCap: DropCap(
                width: width / 4,
                height: width / 3,
                child: ClipOval(
                    child: Image.memory(
                  controller.preacher.value.photoFile as Uint8List,
//                  controller.preachersMessagePhotoFile.value,
                  fit: BoxFit.cover,
                )
                    //AppwriteImageMemory(
                    //    fileId: controller.preachersMessagePhoto.value),

                    //                child: Image.asset(
                    //                  preachersPhoto,
//                      child: Image.network(
//                        menuController.preachersMessagePhoto.value,
//                        (snapshot.hasData) ? snapshot.data!.photo! : "No data",
//                        fit: BoxFit.cover,
                    //                  width: width / 6,
                    //                  height: width / 6,
//                      ),
                    ),
              ),
            ),
          ),
        ),
      );
    });
  }

  FutureBuilder<Preacher> newMethod() {
    return FutureBuilder<Preacher>(
        future: controller.getPreacher().then((value) => value),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.6),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropCapText(
//                menuController.preachersMessagetext.value,
                  (snapshot.hasData) ? snapshot.data!.message! : "No data",
                  dropCapPosition: DropCapPosition.end,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: defaultFont,
                      fontSize: responsiveFontSize,
                      color: dark,
                      height: 1.5,
                      fontWeight: FontWeight.bold),
                  dropCap: DropCap(
                    width: width / 4,
                    height: width / 3,
                    child: ClipOval(
                      child: (snapshot.hasData)
                          ? AppwriteImageMemory(fileId: snapshot.data!.photo!)
                          : Image.asset("assets/images/anchk-logo.PNG"),
                      //                child: Image.asset(
                      //                  preachersPhoto,
//                      child: Image.network(
//                        menuController.preachersMessagePhoto.value,
//                        (snapshot.hasData) ? snapshot.data!.photo! : "No data",
//                        fit: BoxFit.cover,
                      //                  width: width / 6,
                      //                  height: width / 6,
//                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
