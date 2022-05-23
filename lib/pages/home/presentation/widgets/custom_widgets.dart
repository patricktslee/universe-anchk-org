import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.screen,
    required this.text,
    required this.mobileStyle,
    required this.desktopStyle,
  }) : super(key: key);

  final ResponsiveScreen screen;
  final String text;
  final TextStyle mobileStyle;
  final TextStyle desktopStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomAppBarText(
        text: text,
        screen: screen,
        mobileStyle: mobileStyle,
        desktopStyle: desktopStyle,
      ),
      backgroundColor: screen.isPhone ? Colors.white10 : Colors.black87,
      elevation: 0,
      centerTitle: true,
    );
  }
}

class DesktopFittedBox extends StatelessWidget {
  final String imageurl;
  const DesktopFittedBox({
    Key? key,
    this.imageurl = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageurl), fit: BoxFit.cover)),
    );
  }
}

class Custom1OutlinedButton extends StatelessWidget {
  final TextStyle textStyle;
  final String text;
  final String path;
  final Function function;
  Custom1OutlinedButton({
    Key? key,
    required this.mobileTextStyle,
    required this.textStyle,
    required this.text,
    required this.path,
    required this.function,
  }) : super(key: key);

  final TextStyle mobileTextStyle;
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
    logger.i('Starting customOutlineButton');
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        textStyle: textStyle,
        side: const BorderSide(
          color: Colors.deepPurple,
          width: 3,
        ),
        shape: const StadiumBorder(),
      ),
      onPressed: () => function, // Get.toNamed(path),
      child: CustomTextWidget(
        text: text,
        textStyle: mobileTextStyle,
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final TextStyle textStyle;
  final String text;
  final String path;
  final Function() function;
  CustomOutlinedButton({
    Key? key,
    required this.mobileTextStyle,
    required this.textStyle,
    required this.text,
    required this.path,
    required this.function,
  }) : super(key: key);
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  final TextStyle mobileTextStyle;

  @override
  Widget build(BuildContext context) {
    logger.i('Starting customOutlineButton');
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        textStyle: textStyle,
        side: const BorderSide(
          color: Colors.deepPurple,
          width: 3,
        ),
        shape: const StadiumBorder(),
      ),
      onPressed: () => function() ?? Get.toNamed(path),
      child: CustomTextWidget(
        text: text,
        textStyle: mobileTextStyle,
      ),
    );
  }
}

class CustomAppBarText extends StatelessWidget {
  const CustomAppBarText({
    Key? key,
    required this.screen,
    required this.text,
    required this.mobileStyle,
    required this.desktopStyle,
  }) : super(key: key);

  final ResponsiveScreen screen;
  final String text;
  final TextStyle mobileStyle;
  final TextStyle desktopStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: screen.isPhone ? mobileStyle : desktopStyle,
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  const CustomTextWidget({
    Key? key,
    required this.textStyle,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: textStyle,
    );
  }
}
