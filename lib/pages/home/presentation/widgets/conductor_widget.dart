import 'dart:typed_data';

import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/appwrite_image_memory.dart';
import 'package:universe/pages/home/domain/entity/conductor.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';

class ConductorWidget extends StatelessWidget {
  ConductorWidget({
    Key? key,
    required this.controller,
    required this.responsiveFontSize,
    required this.width,
  }) : super(key: key);

  final HomeController controller;
  final double responsiveFontSize;
  final double width;
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  @override
  Widget build(BuildContext context) {
    //logger.i("ConductorWidget width is " + width.toString());
    // 62148e3a9e00d52ee4e6 6214991e3809ab2e5078
    return getConductor();
  }

  Widget getConductor() {
    controller.getConductor();
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
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: DropCapText(
              controller.conductor.value.message.toString(),
              //controller.conductorMessagetext.value,
              dropCapPosition: DropCapPosition.end,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontSize: responsiveFontSize,
                  color: dark,
                  height: 1.5,
                  fontWeight: FontWeight.bold),
              dropCap: DropCap(
                width: width / 2.5,
                height: width / 2.2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 4,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.memory(
                        controller.conductor.value.photoFile as Uint8List,
//                        controller.conductorMessagePhotoFile.value,
                        fit: BoxFit.cover,
                      )
                      //AppwriteImageMemory(
                      //  fileId: controller.conductorMessagePhoto.value,
                      //  quality: 100,
                      //),
                      //                  child: Image.asset(
                      //                    mrIPPhoto,
//                        child: Image.network(
//                          menuController.conductorMessagePhoto.value,
//                          (snapshot.hasData)
//                              ? snapshot.data!.photo!
//                              : "No data",
                      //                    'https://appwrite.anchk.org/v1/storage/files/62148e3a9e00d52ee4e6/view?project=61b0428203f09&mode=admin',
//                          fit: BoxFit.cover,
                      //                  width: width / 3,
                      //                  height: width / 2,
//                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  FutureBuilder<Conductor> newMethod() {
    return FutureBuilder<Conductor>(
        future: controller.getConductor().then((value) => value),
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
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: DropCapText(
//                  controller.conductorMessagetext.value,
                  (snapshot.hasData) ? snapshot.data!.message! : "No data",
                  dropCapPosition: DropCapPosition.end,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: responsiveFontSize,
                      color: dark,
                      height: 1.5,
                      fontWeight: FontWeight.bold),
                  dropCap: DropCap(
                    width: width / 2.5,
                    height: width / 2.2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 4,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: (snapshot.hasData)
                            ? AppwriteImageMemory(
                                fileId: snapshot.data!.photo!,
                                quality: 100,
                              )
                            : Image.asset("assets/images/anchk-logo.PNG"),
                        //                  child: Image.asset(
                        //                    mrIPPhoto,
//                        child: Image.network(
//                          menuController.conductorMessagePhoto.value,
//                          (snapshot.hasData)
//                              ? snapshot.data!.photo!
//                              : "No data",
                        //                    'https://appwrite.anchk.org/v1/storage/files/62148e3a9e00d52ee4e6/view?project=61b0428203f09&mode=admin',
//                          fit: BoxFit.cover,
                        //                  width: width / 3,
                        //                  height: width / 2,
//                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
