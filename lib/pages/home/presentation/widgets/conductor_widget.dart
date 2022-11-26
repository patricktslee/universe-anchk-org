import 'dart:typed_data';

import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
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
              dropCapPosition: DropCapPosition.end,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: defaultFont,
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
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
