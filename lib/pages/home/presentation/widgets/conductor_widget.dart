import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';

class ConductorWidget extends StatelessWidget {
  const ConductorWidget({
    Key? key,
    required this.menuController,
    required this.responsiveFontSize,
    required this.width,
  }) : super(key: key);

  final HomeController menuController;
  final double responsiveFontSize;
  final double width;

  @override
  Widget build(BuildContext context) {
    print("ConductorWidget width is " + width.toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.6),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: DropCapText(
            menuController.conductorMessagetext.value,
            dropCapPosition: DropCapPosition.end,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontFamily: 'NotoSans',
                fontSize: responsiveFontSize,
                color: dark,
                height: 1.5,
                fontWeight: FontWeight.bold),
            dropCap: DropCap(
              width: width / 2.5,
              height: width / 2.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 4,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    mrIPPhoto,
                    fit: BoxFit.cover,
//                  width: width / 3,
//                  height: width / 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
