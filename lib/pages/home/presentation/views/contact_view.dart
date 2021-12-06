import 'package:universe/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:universe/pages/home/presentation/widgets/contact_widget.dart';
import 'package:universe/pages/home/presentation/widgets/main_title.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(
        'MediaQuery.of(context).size.width in contactview is ${MediaQuery.of(context).size.width.toString()}');
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
