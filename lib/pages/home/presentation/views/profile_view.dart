import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
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
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: [
          const MainTitle(),
          ProfileWidget(),
        ],
      ),
    );
  }
}
