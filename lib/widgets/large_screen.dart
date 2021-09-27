import 'package:flutter/material.dart';
import 'package:universe/helpers/local_navigator.dart';
import 'package:universe/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: SideMenu()),
        Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: localNavigator(),
            ))
      ],
    );
  }
}
