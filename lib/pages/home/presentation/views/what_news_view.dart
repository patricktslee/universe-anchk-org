import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/what_news_group_widget.dart';
//import 'package:universe/pages/home/presentation/widgets/whatnews_widget.dart';
import 'package:get/get.dart';

class WhatNewsPage extends StatelessWidget {
  static HomeController menuController = Get.find();

  const WhatNewsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: const [
          MainTitle(),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: WhatnewsGroupWidget(),
          ),
        ],
      ),
    );
  }
}
