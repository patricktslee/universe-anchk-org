import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/whatnews_widget.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:get/get.dart';

class WhatNewsPage extends StatelessWidget {
  static HomeController menuController = Get.find();
  @override
  Widget build(BuildContext context) {
    double cardWidth = ResponsiveWidget.isSmallScreen(context)
        ? MediaQuery.of(context).size.width
        : ResponsiveWidget.isLargeScreen(context)
            ? 650
            : 500;
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          MainTitle(menuController: menuController),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: menuController.whatNewsItem
                  .map(
                    (item) => WhatnewsWidget(item: item),
                  )
                  .toList(),
            ),
          ))
        ],
      ),
    );
  }
}
