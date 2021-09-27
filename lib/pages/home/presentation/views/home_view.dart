import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:universe/pages/home/presentation/widgets/custom_widgets.dart';

import '../../../../shared/AppConstants.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  void _countryPath() async {
    Get.toNamed(AppConstants.countryPath);
  }

  void _profilePath() async {
    Get.toNamed(AppConstants.profilePath);
  }

  @override
//  Widget build(BuildContext context) {
  Widget builder() {
    return screen.isPhone ? iPhoneScreen() : desktopScreen();
  }

  Container desktopScreen() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
          backgroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: controller.obx(
            (state) {
              return GetBuilder<HomeController>(
                builder: (value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DesktopFittedBox(imageurl: AppConstants.bgImage),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          width: 100,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  CustomTextWidget(
                                    text: 'total_confirmed'.tr,
                                    textStyle:
                                        AppConstants.desktopTitleTextStyle,
                                  ),
                                  CustomTextWidget(
                                    text: '${state!.global.totalConfirmed}',
                                    textStyle:
                                        AppConstants.desktopDataTextStyle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextWidget(
                                    text: 'total_deaths'.tr,
                                    textStyle:
                                        AppConstants.desktopTitleTextStyle,
                                  ),
                                  CustomTextWidget(
                                    text: '${state.global.totalDeaths}',
                                    textStyle:
                                        AppConstants.desktopDataTextStyle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomOutlinedButton(
                                    text: 'fetch_country',
                                    textStyle:
                                        AppConstants.desktopOutlineBtnTextStyle,
                                    mobileTextStyle:
                                        AppConstants.desktopTextStyle,
                                    path: AppConstants.countryPath,
                                    function: _countryPath,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomOutlinedButton(
                                    text: 'profile_screen',
                                    textStyle:
                                        AppConstants.desktopOutlineBtnTextStyle,
                                    mobileTextStyle:
                                        AppConstants.desktopTextStyle,
                                    path: AppConstants.profilePath,
                                    function: _profilePath,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  Container iPhoneScreen() {
    return Container(
      decoration: BoxDecoration(
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
                      SizedBox(
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
                      SizedBox(
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
                      SizedBox(
                        height: 10,
                      ),
                      CustomOutlinedButton(
                        text: 'fetch_country',
                        textStyle: AppConstants.mobileOutlineBtnTextStyle,
                        mobileTextStyle: AppConstants.mobileTextStyle,
                        path: AppConstants.countryPath,
                        function: _countryPath,
                      ),
                      SizedBox(
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
