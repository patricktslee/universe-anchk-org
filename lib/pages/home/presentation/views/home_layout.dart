//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';

import 'package:universe/pages/home/presentation/widgets/custom_widgets.dart';
import 'package:universe/routing/router.dart';
import 'package:universe/routing/routes.dart';
import 'package:universe/shared/enum.dart';
import 'package:universe/widgets/bottom_nav.dart';
import 'package:universe/widgets/custom_box_decoration.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:universe/widgets/organization_text.dart';
import 'package:universe/widgets/side_menu.dart';
//import 'package:universe/pages/home/presentation/controllers/navigation_controller.dart';
//import 'package:universe/pages/home/presentation/controllers/menu_controller.dart1';

import 'package:universe/shared/app_constants.dart';
//import '../../../../shared/app_constants.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeLayout extends GetResponsiveView<HomeController> {
//  final TargetPlatform platform;
//  HomeLayout(this.platform);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  static HomeController menuController = Get.find();
//  static NavigationController navigationController = Get.find();

  HomeLayout({Key? key}) : super(key: key);
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  void _countryPath() async {
    Get.toNamed(AppConstants.countryPath);
  }

  void _profilePath() async {
    Get.toNamed(AppConstants.profilePath);
  }

  @override
//  Widget build(BuildContext context) {
  Widget builder() {
//    logger.i("The Platform is ${platform.toString()}");
//    var isMobile =
//        platform == TargetPlatform.iOS || platform == TargetPlatform.android;
//    logger.i("Starting HomeLayout and check the Login Status");
//    logger.i("menuController.loginStatus is " +        menuController.loginStatus.toString());
//    return !kIsWeb ? iPhoneScreen() : webScreen();
    return Obx(() => controller.dataStatus.value == 'Status.uninitialized'
        ? splashScreen()
        : !kIsWeb
            ? iPhoneScreen()
            : webScreen());
  }
//    return Obx(() => controller.dataStatus.value == 'Status.dataUpdated'
//        ? !kIsWeb
//            ? iPhoneScreen()
//            : webScreen()
//        : splashScreen());
//  }

  Widget splashScreen() {
    return Container(
      decoration: customBoxDecoration(),
      child: Center(
        child: screen.width < ResponsiveWidget.getMediumScreenSize()
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  heading(),
                  slogon(),
                  logoSizedBox(),
                  //dataLoading(),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  heading(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      slogon(),
                      logoSizedBox(),
                      //dataLoading(),
                    ],
                  ),
//                  SizedBox(
//                    child: debug(),
//                  ),
                ],
              ),
      ),
    );
  }

  SizedBox slogon() => SizedBox(
        width: 350,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 10),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://appwrite.anchk.org/v1/storage/files/slogon/view?project=61b0428203f09&mode=admin"),
                    fit: BoxFit.cover)),
          ),
        ),
      );

  CustomText heading() => CustomText(
        text: organizationName,
        size: 40,
        weight: FontWeight.bold,
        textAlign: TextAlign.center,
      );

  CustomText dataLoading() => const CustomText(
        text: "數據加載中....",
        color: AppConstants.defaultTextColor,
        size: 30,
        weight: FontWeight.bold,
        textAlign: TextAlign.center,
      );

  CustomText debug() => CustomText(
        text: controller.datalog.value.toString(),
        size: 30,
        weight: FontWeight.bold,
        textAlign: TextAlign.center,
      );

  SizedBox logoSizedBox() => SizedBox(
        height: 200,
        child: Image.asset(logoPath),
      );

  Container webScreen() {
//    final MenuController menuController = Get.find();
//    final NavigationController navigationController = Get.find();
//    bool smallScreen = screen.width < 600;
    bool smallScreen = screen.width < ResponsiveWidget.getMediumScreenSize();
//    logger.i(        "screen.width is ${screen.width.toString()} /n smallScreen is ${smallScreen.toString()})");
    TargetPlatform.android;
    return Container(
      decoration: customBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
//        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: HomeAppBar(),
        ),
        drawer: smallScreen
            ? const Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: SideMenu(),
              )
            : null,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: !smallScreen
                  ? Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: MenuList(
                            menuController: menuController,
                          ),
                          // navigationController: menuController),
                        ),
                      ),
                    )
                  : null,
            ),
            Expanded(
              flex: 3,
              child: Navigator(
                key: controller.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: whatNewsPageRoute,
              ),
              //Center(child: Text('My Page!')),
            )
          ],
        ),
      ),
    );
  }

  Container iPhoneScreen() {
//    final MenuController menuController = Get.find();
//    final NavigationController navigationController = Get.find();
    bool smallScreen = screen.width < ResponsiveWidget.getMediumScreenSize();
    logger.i(
        "screen.width is ${screen.width.toString()} /n smallScreen is ${smallScreen.toString()})");
    TargetPlatform.android;
    return Container(
      decoration: customBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
//        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: HomeAppBar(),
        ),
        bottomNavigationBar: BottomNavigation(),
        //drawer: smallScreen
        //    ? const Drawer(
        //        // Add a ListView to the drawer. This ensures the user can scroll
        //        // through the options in the drawer if there isn't enough vertical
        //        // space to fit everything.
        //        child: SideMenu(),
        //      )
        //    : null,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: !smallScreen
                  ? Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: MenuList(
                            menuController: menuController,
                          ),
                          // navigationController: menuController),
                        ),
                      ),
                    )
                  : null,
            ),
            Expanded(
              flex: 3,
              child: Navigator(
                key: controller.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: whatNewsPageRoute,
              ),
              //Center(child: Text('My Page!')),
            )
          ],
        ),
      ),
    );
  }

  Container iPhoneScreen2() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(AppConstants.bgImage),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: CustomAppBarText(
            text: 'covid',
            screen: screen,
            mobileStyle: AppConstants.mobileTitleTextStyle,
            desktopStyle: AppConstants.desktopTitleTextStyle,
          ),
          backgroundColor: Colors.white10,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: controller.obx(
            (state) {
              return GetBuilder<HomeController>(
                builder: (value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      CustomTextWidget(
                        text: 'total_confirmed'.tr,
                        textStyle: AppConstants.mobileTitleTextStyle,
                      ),
                      CustomTextWidget(
                        text: '${state!.global.totalConfirmed}',
                        textStyle: AppConstants.mobileDataTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextWidget(
                        text: 'total_deaths'.tr,
                        textStyle: AppConstants.mobileTitleTextStyle,
                      ),
                      CustomTextWidget(
                        text: '${state.global.totalDeaths}',
                        textStyle: AppConstants.mobileDataTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomOutlinedButton(
                        text: 'fetch_country',
                        textStyle: AppConstants.mobileOutlineBtnTextStyle,
                        mobileTextStyle: AppConstants.mobileTextStyle,
                        path: AppConstants.countryPath,
                        function: _countryPath,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomOutlinedButton(
                        text: 'profile_screen',
                        textStyle: AppConstants.mobileOutlineBtnTextStyle,
                        mobileTextStyle: AppConstants.mobileTextStyle,
                        path: AppConstants.profilePath,
                        function: _profilePath,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);
  static HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40, child: Image.asset(logoPath)),
                  const SizedBox(
                    width: 8,
                  ),
                  OrganizationText(
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: dark,
                  ),
                ],
              ),
            ),
          ),
//             Expanded(child: Container()),
//          const SizedBox(
//            width: 8,
//          ),
          SizedBox(
            width: ResponsiveWidget.isSmallScreen(context)
                ? 100
                : ResponsiveWidget.isSmallScreen(context)
                    ? 150
                    : 200,
            child: InkWell(
              onTap: () {
                print(
                    "controller.providerBox.value is ${controller.providerBox.value}");
                print(
                    "controller.loginStatus.value is ${controller.loginStatus.value}");
                if ((controller.providerBox.value == "anonymous") ||
                    (controller.loginStatus.value !=
                        Status.authenticated.toString())) {
                  controller.changeActiveItemTo(authenticationPageDisplayName);
                  if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                  controller.navigateTo(authenticationPageRoute);
                } else {
                  controller.changeActiveItemTo(profilePageDisplayName);
                  if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                  controller.navigateTo(profilePageRoute);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
//                Container(
//                  width: 1,
//                  height: 22,
//                  color: dark,
//                ),
//                const SizedBox(
//                  width: 8,
//                ),
                  Obx(() => CustomText(
                        text: controller.displayName.value,
                        color: dark,
                        size: standardTextSize,
                        weight: FontWeight.normal,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: active.withOpacity(.5),
                        borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        backgroundColor: light,
                        child: Icon(
                          Icons.person_outline,
                          color: dark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
