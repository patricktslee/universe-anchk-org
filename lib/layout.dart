import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/local_navigator.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/widgets/bottom_nav.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:universe/widgets/large_screen.dart';
import 'package:universe/widgets/side_menu.dart';
import 'package:universe/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    var isMobile =
        platform == TargetPlatform.iOS || platform == TargetPlatform.android;
    print("Size of device is " +
        MediaQuery.of(context).size.width.toString()); //iPad air 820
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: isMobile
          ? AppBar(
              title: CustomText(
                text: "Dash",
                color: active,
                size: 20,
                weight: FontWeight.bold,
              ),
            )
          : topNavigationBar(context, scaffoldKey),
      bottomNavigationBar: (platform == TargetPlatform.iOS &&
                  MediaQuery.of(context).size.width < 400) ||
              platform == TargetPlatform.android
          ? Obx(() => BottomNavigation(context, scaffoldKey))
          : null,
      drawer: (platform == TargetPlatform.iOS &&
                  MediaQuery.of(context).size.width < 400) ||
              platform == TargetPlatform.android
          ? null
          : const Drawer(
              child: SideMenu(),
            ),
      body: ResponsiveWidget(
          largeScreen: const LargeScreen(),
          mediumScreen: const LargeScreen(),
          customScreen: const LargeScreen(),
          smallScreen: Padding(
            padding: isMobile
                ? const EdgeInsets.fromLTRB(16, 30, 16, 0)
                : const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          )),
    );
  }
}
