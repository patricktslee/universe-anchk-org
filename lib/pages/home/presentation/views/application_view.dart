import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/pages/home/presentation/widgets/application_widget.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:get/get.dart';

class ApplicationPage extends StatelessWidget {
  static HomeController controller = Get.find();

  const ApplicationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _applicationWidget(context);
  }

  Widget _applicationWidget(BuildContext context) => Padding(
        padding: customMainTitleEdgeInsets(),
        child: Column(
          children: [
            const MainTitle(),
            ApplicationWidget(),
          ],
        ),
      );
}
