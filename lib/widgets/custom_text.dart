import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/constants/style.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final List<Shadow> shadow;
  final bool softWrap;

  const CustomText({
    Key? key,
    required this.text,
    this.size = 14,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.shadow = const [],
    this.softWrap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = ResponsiveWidget.isSmallScreen(context)
        ? screenWidth < 330
            ? size
            : screenWidth >= 300 && screenWidth < 400
                ? size + 2
                : screenWidth >= 400 && screenWidth < 700
                    ? size + 4
                    : size + 5
        : ResponsiveWidget.isMediumScreen(context)
            ? size + 8
            : size + 10;

//    double responsiveFontSize = ResponsiveWidget.isSmallScreen(context)
//        ? size
//        : ResponsiveWidget.isMediumScreen(context)
//            ? size + 2
//            : size + 4;

    return Text(
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      style: TextStyle(
          fontFamily: defaultFont,
          fontSize: responsiveFontSize, // default is 16,
          color: color, // default is Colors.black,
          fontWeight: weight,
          decoration: textDecoration,
          shadows: shadow,
          height: 1.5), // default is FontWeight.normal
    );
  }
}
