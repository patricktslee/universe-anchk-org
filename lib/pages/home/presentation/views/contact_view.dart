import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/widgets/contact_widget.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);
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
//    logger.i(        'MediaQuery.of(context).size.width in contactview is ${MediaQuery.of(context).size.width.toString()}');
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: const [
          MainTitle(),
          ContactWidget(),
        ],
      ),
    );
  }
}
