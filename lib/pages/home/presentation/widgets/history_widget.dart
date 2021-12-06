import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key}) : super(key: key);
  static HomeController menuController = Get.find();

  @override
  Widget build(BuildContext context) {
    return _history(context);
  }

  Widget _history(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: ResponsiveWidget.isiPadScreen(context)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _column1(),
                          const SizedBox(
                            width: 16,
                          ),
                          _column2(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: _column1()),
                          VerticalDivider(
                            color: strongpink,
                            thickness: 10,
                            indent: 20,
                            endIndent: 0,
                            width: 20,
                          ),
                          Expanded(child: _column2()),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );

  Column _column1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menuController.eventHistoryItem1
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: item.name.toString(),
                        size: standardTextSize,
                        weight: FontWeight.bold,
                        color: strongpink,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.events
                            .map<Widget>(
                              (event) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: CustomText(
                                        text: event.year.toString(),
                                        size: standardTextSize,
                                        weight: FontWeight.bold,
                                        color: blackColor,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: CustomText(
                                        text: event.event.toString(),
                                        size: standardTextSize,
                                        weight: FontWeight.bold,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Column _column2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menuController.eventHistoryItem2
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: item.name.toString(),
                        size: standardTextSize,
                        weight: FontWeight.bold,
                        color: strongpink,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.events
                            .map<Widget>(
                              (event) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: CustomText(
                                        text: event.year.toString(),
                                        size: standardTextSize,
                                        weight: FontWeight.bold,
                                        color: blackColor,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: CustomText(
                                        text: event.event.toString(),
                                        size: standardTextSize,
                                        weight: FontWeight.bold,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
