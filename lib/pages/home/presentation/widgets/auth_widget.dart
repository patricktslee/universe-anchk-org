import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/error_tanslate.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/application_widget.dart';
import 'package:universe/routing/routes.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
//import 'package:flutter_toggle_tab/helper.dart';

class AuthWidget extends StatelessWidget {
  AuthWidget({Key? key}) : super(key: key);
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  static HomeController controller = Get.find();
  final _listToggleText = ["登錄", "註冊"];
  final _listIconTabToggle = [Icons.login, Icons.create];
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: _width <= 240
              ? 220
              : (_width > 240 && _width <= 500)
                  ? _width * 0.9
                  : (_width > 240 && _width <= 500)
                      ? _width * 0.9
                      : (_width > 500 && _width <= 1024)
                          ? 500
                          : 800,
          child: Column(
            children: [
              _toggleTab(_width),
              Obx(() => (controller.tabAuthIndexSelected.value == 0)
                  ? _loginForm(context)
                  : _signUpForm(context)),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleTab(double _width) => Obx(() => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterToggleTab(
              width: (150 / _width * 100),
              borderRadius: 15,
              selectedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              unSelectedTextStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              labels: _listToggleText,
              icons: _listIconTabToggle,
              selectedIndex: controller.tabAuthIndexSelected.value,
              selectedLabelIndex: (index) {
                controller.tabAuthIndexSelected.value = index;
              },
            ),
          ],
        ),
      ));

  Widget _loginForm(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            CustomEmailFeildInput(
              customController: emailController,
              customHintText: "電郵",
              customIcon: const Icon(Icons.email),
            ),
            CustomPasswordFeildInput(
              customController: passwordController,
              customHintText: "密碼",
              customIcon: const Icon(Icons.password),
            ),
          ],
        ),
      );

  Widget _signUpForm(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFeildInput(
              customController: nameController,
              customHintText: "姓名",
              customIcon: const Icon(Icons.person),
              isRequired: true,
            ),
            CustomEmailFeildInput(
              customController: emailController,
              customHintText: "電郵",
              customIcon: const Icon(Icons.email),
            ),
            CustomPasswordFeildInput(
              customController: passwordController,
              customHintText: "密碼",
              customIcon: const Icon(Icons.password),
            ),
            CustomConfirmedPasswordFeildInput(
              passwordController: passwordController,
              confirmPasswordController: confirmedPasswordController,
              customHintText: "確認密碼",
              customIcon: const Icon(Icons.password),
            ),
          ],
        ),
      );

  Widget _loginButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
//                Map<dynamic, dynamic> data = {
//                  "name": nameController.text.toString(),
//                  "password": passwordController.text.toString(),
//                  "email": emailController.text.toString(),
//                };
//                logger.i(
//                    'data is $data \n controller.tabAuthIndexSelected.value is ${controller.tabAuthIndexSelected.value}');
                //logger.i('login status is ${controller.loginStatus.value}');
                //controller.(data);
                (controller.tabAuthIndexSelected.value == 0)
                    ? _userLogin(context)
                    : _userRegistration(context);
              }
            },
            child: Obx(
              () => (controller.tabAuthIndexSelected.value == 0)
                  ? CustomText(
                      text: '登錄',
                      size: standardTextSize,
                      color: dark,
                      weight: FontWeight.normal)
                  : CustomText(
                      text: '註冊',
                      size: standardTextSize,
                      color: dark,
                      weight: FontWeight.bold),
            )),
      );

  void _userLogin(BuildContext context) {
    int code = 0;
    controller
        .userLogin(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      print("_userLogin value \n${value.toString()}");
      if (value.runtimeType == AppwriteException) {
        print("value type is AppwriteException");
        code = value.code;
        print("ErrorTanslate().findCode(code) is " +
            ErrorTanslate().findValue(code));
        throw Exception(value);
//          throw CustomException(value.toString());
      }
      controller.changeActiveItemTo(profilePageDisplayName);
      controller.navigateTo(profilePageRoute);
    }).catchError((onError) {
      print("catchError((onError)  \n${onError.toString()}");
      _showErrorSnackBar(context, onError, code);
    });
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

  void _userRegistration(BuildContext context) {
    int code = 0;
    controller
        .userRegistration(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text)
        .then((value) {
      print("_userRegistration value \n${value.toString()}");
      if (value.runtimeType == AppwriteException) {
        print("value type is AppwriteException");
        code = value.code;

        throw Exception(value);
//          throw CustomException(value.toString());
      }
      controller.changeActiveItemTo(profilePageDisplayName);
      controller.navigateTo(profilePageRoute);
    }).catchError((onError) {
      _showErrorSnackBar(context, onError, code);
    });
  }
}
