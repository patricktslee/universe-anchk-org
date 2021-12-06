import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';
import 'package:universe/pages/home/presentation/widgets/requirement_widget.dart';

class RequirementPage extends StatelessWidget {
  const RequirementPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('requirement ${MediaQuery.of(context).size.width - 760 - 400}');
    return Padding(
      padding: customMainTitleEdgeInsets(),
      child: Column(
        children: const [
          MainTitle(),
          RequirementWidget(),
//          _requirementWidget(context),
        ],
      ),
    );
  }
}
