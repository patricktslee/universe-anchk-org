import 'package:flutter/material.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/constants/style.dart';

class SelectedCustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;

  const SelectedCustomText(
      {Key? key,
      required this.text,
      this.size = 14,
      this.color = Colors.black,
      this.weight = FontWeight.normal,
      this.textAlign = TextAlign.left,
      this.textDecoration = TextDecoration.none})
      : super(key: key);

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
    return SelectionArea(
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            fontFamily: defaultFont,
            fontSize: responsiveFontSize, // default is 16,
            color: color, // default is Colors.black,
            fontWeight: weight,
            decoration: textDecoration,
            height: 1.5), // default is FontWeight.normal
      ),
    );
  }
}
