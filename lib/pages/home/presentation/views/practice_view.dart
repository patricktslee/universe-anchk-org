import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/practice_widget.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: const [
          MainTitle(),
          Expanded(
            child: SingleChildScrollView(
              child: PracticeWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
