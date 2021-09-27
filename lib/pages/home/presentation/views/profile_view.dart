import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/pages/home/domain/entity/user.dart';
import 'package:universe/pages/home/presentation/controllers/profile_controller.dart';
import 'package:universe/pages/home/presentation/widgets/custom_widgets.dart';
import 'package:universe/shared/AppConstants.dart';
//import 'package:universe/pages/home/presentation/views/home_view.dart';
//import '../controllers/auth_controller.dart';

class ProfileView extends GetResponsiveView<ProfileController> {
  @override
  Widget builder() {
    print('Loading ProfileView');
    controller.checkLogin();
    return controller.obx(
      (state) {
        return screen.isPhone ? iPhoneScreen(state!) : desktopScreen(state!);
      },
    );
  }

  Container iPhoneScreen(User state) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              CustomTextWidget(
                text: 'email'.tr,
                textStyle: AppConstants.mobileTitleTextStyle,
              ),
              CustomTextWidget(
                text: state.email.toString() == "name@email.com"
                    ? 'No Email'
                    : state.email.toString(),
                textStyle: AppConstants.mobileProfileDataTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextWidget(
                text: 'name'.tr,
                textStyle: AppConstants.mobileTitleTextStyle,
              ),
              CustomTextWidget(
                text: '${state.name}',
                textStyle: AppConstants.mobileProfileDataTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextWidget(
                text: 'session_id'.tr,
                textStyle: AppConstants.mobileTitleTextStyle,
              ),
              CustomTextWidget(
                text: '${controller.authRepository.session.id}',
                textStyle: AppConstants.mobileProfileDataTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextWidget(
                text: 'login_expired_date'.tr,
                textStyle: AppConstants.mobileTitleTextStyle,
              ),
              CustomTextWidget(
                text:
                    '${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.authRepository.session.expire! * 1000))}',
                textStyle: AppConstants.mobileProfileDataTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              CustomOutlinedButton(
                text: 'logout',
                textStyle: AppConstants.mobileOutlineBtnTextStyle,
                mobileTextStyle: AppConstants.mobileTextStyle,
                path: AppConstants.profilePath,
                function: _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container desktopScreen(User state) {
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
          child: Row(
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
                            height: 10,
                          ),
                          CustomTextWidget(
                            text: 'email'.tr,
                            textStyle: AppConstants.desktopTitleTextStyle,
                          ),
                          CustomTextWidget(
                            text: state.email.toString() == "name@email.com"
                                ? 'No Email'
                                : state.email.toString(),
                            textStyle: AppConstants.desktopProfileDataTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextWidget(
                            text: 'name'.tr,
                            textStyle: AppConstants.desktopTitleTextStyle,
                          ),
                          CustomTextWidget(
                            text: '${state.name}',
                            textStyle: AppConstants.desktopProfileDataTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextWidget(
                            text: 'session_id'.tr,
                            textStyle: AppConstants.desktopTitleTextStyle,
                          ),
                          CustomTextWidget(
                            text: '${controller.authRepository.session.id}',
                            textStyle: AppConstants.desktopProfileDataTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextWidget(
                            text: 'login_expired_date'.tr,
                            textStyle: AppConstants.desktopTitleTextStyle,
                          ),
                          CustomTextWidget(
                            text:
                                '${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.authRepository.session.expire! * 1000))}',
                            textStyle: AppConstants.desktopProfileDataTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomOutlinedButton(
                            text: 'logout',
                            textStyle: AppConstants.desktopOutlineBtnTextStyle,
                            mobileTextStyle: AppConstants.desktopTextStyle,
                            path: AppConstants.profilePath,
                            function: _logout,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout() async {
    bool isLogout;
    isLogout = await controller.appwriteLogout(
        sessionId: controller.authRepository.session.id!);
    print('IsLogout is ' + isLogout.toString());
    if (!isLogout) {
      Get.snackbar("Error to logout", controller.authRepository.error);
      Get.toNamed('/profile');
    } else {
      Get.back();
    }
  }
}
