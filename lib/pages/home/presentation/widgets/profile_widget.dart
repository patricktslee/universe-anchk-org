import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/error_tanslate.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/application_widget.dart';
import 'package:universe/routing/routes.dart';
import 'package:universe/widgets/custom_text.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  Column profileColumn(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomText(
                    text: controller.currentUser.name.toString(),
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                //nextLoginTime()
              ]),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 250,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Stack(
                                  clipBehavior: Clip.none,
                                  children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: InkWell(
                                      child: const CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CustomPasswordFeildInput(
                                        customController:
                                            currentPasswordController,
                                        customHintText: "當前密碼",
                                        customIcon: const Icon(Icons.password),
                                      ),
                                      CustomPasswordFeildInput(
                                        customController: passwordController,
                                        customHintText: "密碼",
                                        customIcon: const Icon(Icons.password),
                                      ),
                                      CustomConfirmedPasswordFeildInput(
                                        passwordController: passwordController,
                                        confirmPasswordController:
                                            confirmedPasswordController,
                                        customHintText: "確認密碼",
                                        customIcon: const Icon(Icons.password),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            child: CustomText(
                                                text: '更新',
                                                size: standardTextSize,
                                                color: dark,
                                                weight: FontWeight.normal),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                int code = 0;
                                                controller
                                                    .updateAccountPassword(
                                                        passwordController.text,
                                                        currentPasswordController
                                                            .text)
                                                    .then((value) {
                                                  print(
                                                      "updateAccountPassword value \n${value.toString()}");
                                                  if (value.runtimeType ==
                                                      AppwriteException) {
                                                    print(
                                                        "value type is AppwriteException & code is ${value.code.toString()}");
                                                    code = value.code;
                                                    throw Exception(value);
                                                  }
                                                  controller.changeActiveItemTo(
                                                      profilePageDisplayName);
                                                  controller.navigateTo(
                                                      profilePageRoute);
                                                  Navigator.pop(context);
                                                }).catchError((onError) {
                                                  print(
                                                      "catchError((onError)  \n${onError.toString()}");
                                                  _showErrorSnackBar(
                                                      context, onError, code);
                                                });
                                              }
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                              ]));
                        });
                  },
                  child: CustomText(
                      text: '更新密碼',
                      size: standardTextSize,
                      color: dark,
                      weight: FontWeight.normal),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller
//                        .userLogout(sessionId: controller.sessionId.value)
                        .userLogout(sessionId: 'current')
                        .then((value) {
                      controller.changeActiveItemTo(whatNewsPageDisplayName);
                      if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                      controller.navigateTo(whatNewsPageRoute);
                    });
                  },
                  child: CustomText(
                      text: '登出',
                      size: standardTextSize,
                      color: dark,
                      weight: FontWeight.normal),
                ),
              ],
            ),
          )
        ],
      );

  Padding nextLoginTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomText(
            text: "下次登錄時間",
            size: standardTextSize,
            weight: FontWeight.bold,
            color: blackColor,
          ),
          const SizedBox(
            width: 8,
          ),
          CustomText(
            text: DateFormat('yyyy-MM-dd kk:mm').format(
                DateTime.fromMillisecondsSinceEpoch(
                    controller.currentSession.expire * 1000)),
            size: standardTextSize,
            weight: FontWeight.bold,
            color: blackColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return profileColumn(context);
  }

  void _showErrorSnackBar(BuildContext context, onError, int code) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: RichText(
        text: TextSpan(
            text: ErrorTanslate().findValue(code),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      )),
    );
  }
}
