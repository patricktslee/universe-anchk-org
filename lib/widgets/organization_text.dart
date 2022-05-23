import 'package:flutter/material.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/widgets/custom_text.dart';

class OrganizationText extends StatelessWidget {
  final double size;
  final Color color;
  final FontWeight weight;

  const OrganizationText(
      {Key? key, required this.size, required this.color, required this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    //double responsiveFontSize = ResponsiveWidget.isSmallScreen(context)
    //    ? screenWidth < 330
    //        ? size
    //        : screenWidth >= 300 && screenWidth < 400
    //            ? size + 2
    //            : screenWidth >= 400 && screenWidth < 700
    //                ? size + 4
    //                : size + 5
    //    : ResponsiveWidget.isMediumScreen(context)
    //        ? size + 8
    //        : size + 10;
    return CustomText(
      text: organizationName,
      size: size,
      color: color,
      weight: weight,
    );
    //Text(
    //  organizationName,
    //  style: TextStyle(
    //    fontFamily: 'NotoSans',
    //    fontSize: responsiveFontSize, // default is 16,
    //    color: color,
    //    fontWeight: weight,
    //  ),
    //);
  }
}
