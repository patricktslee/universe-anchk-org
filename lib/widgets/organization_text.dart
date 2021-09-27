import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universe/constants/metadata.dart';

class OrganizationText extends StatelessWidget {
  final double size;
  final Color color;
  final FontWeight weight;

  const OrganizationText(
      {Key? key, required this.size, required this.color, required this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      organizationName,
      style: TextStyle(
        fontFamily: 'NotoSans',
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
