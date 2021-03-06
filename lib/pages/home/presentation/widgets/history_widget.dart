import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();
  static List _eventHistoryItem = [];
  static List eventHistoryItem1 = [];
  static List eventHistoryItem2 = [];

  @override
  Widget build(BuildContext context) {
    return _history(context);
    //FutureBuilder<Object>(
    //    future: controller
    //        .getAnchkorgEventCategory1()
    //        .then((_eventHistoryItem1) async {
    //      eventHistoryItem1 = _eventHistoryItem1;
    //      await controller.getAnchkorgEventCategory2().then(
    //          (_eventHistoryItem2) => eventHistoryItem2 = _eventHistoryItem2);
    //      return _eventHistoryItem1;
    //    }),
    //    builder: (context, snapshot) {
    //      return (snapshot.hasData)
    //          ? _history(context)
    //          : SizedBox(
    //              width: 300,
    //              child: Image.asset("assets/images/anchk-logo.PNG"));
    //    });
  }

  Widget eventHistoryItemObx(bool item) {
    controller.getAnchkorgEventCategory1();
    controller.getAnchkorgEventCategory2();
    return Obx(() {
      item
          ? _eventHistoryItem = controller.eventHistoryItem1
          : _eventHistoryItem = controller.eventHistoryItem2;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                //   snapshot.data! //              controller.eventHistoryItem1
                _eventHistoryItem
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
    });
  }

  Widget eventHistoryItem(bool item) {
    return FutureBuilder<List>(
      future: item
          ? controller.getAnchkorgEventCategory1().then((_eventHistoryItem1) {
              print("eventHistoryItem $item");
              print(_eventHistoryItem1.toString());
              return _eventHistoryItem1;
            })
          : controller.getAnchkorgEventCategory2().then((_eventHistoryItem2) {
              print("eventHistoryItem $item");
              print(_eventHistoryItem2.toString());
              return _eventHistoryItem2;
            }),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          eventHistoryItem1 = controller.eventHistoryItem1;
          eventHistoryItem2 = controller.eventHistoryItem2;
          item
              ? _eventHistoryItem = eventHistoryItem1
              : _eventHistoryItem = eventHistoryItem2;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    //   snapshot.data! //              controller.eventHistoryItem1
                    _eventHistoryItem
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
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
                          eventHistoryItemObx(true),
//                          _column1(),
                          const SizedBox(
                            width: 16,
                          ),
                          eventHistoryItemObx(false),
//                          _column2(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: eventHistoryItemObx(true)),
// _column1()),
                          VerticalDivider(
                            color: strongpink,
                            thickness: 10,
                            indent: 20,
                            endIndent: 0,
                            width: 20,
                          ),
                          Expanded(child: eventHistoryItemObx(false)),
// _column2()),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );

//  Column _column1() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//        Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children:
//              eventHistoryItem1 //              controller.eventHistoryItem1
//                  .map(
//                    (item) => Padding(
//                      padding: const EdgeInsets.symmetric(vertical: 8),
//                      child: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          CustomText(
//                            text: item.name.toString(),
//                            size: standardTextSize,
//                            weight: FontWeight.bold,
//                            color: strongpink,
//                          ),
//                          Column(
//                            mainAxisSize: MainAxisSize.min,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: item.events
//                                .map<Widget>(
//                                  (event) => Padding(
//                                    padding: const EdgeInsets.all(8.0),
//                                    child: Row(
//                                      children: [
//                                        SizedBox(
//                                          width: 150,
//                                          child: CustomText(
//                                            text: event.year.toString(),
//                                            size: standardTextSize,
//                                            weight: FontWeight.bold,
//                                            color: blackColor,
//                                          ),
//                                        ),
//                                        Expanded(
//                                          flex: 1,
//                                          child: CustomText(
//                                            text: event.event.toString(),
//                                            size: standardTextSize,
//                                            weight: FontWeight.bold,
//                                            color: blackColor,
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                )
//                                .toList(),
//                          ),
//                        ],
//                      ),
//                    ),
//                  )
//                  .toList(),
//        ),
//      ],
//    );
//  }
//
//  Column _column2() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//        Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children:
//              eventHistoryItem2 //              controller.eventHistoryItem2
//                  .map(
//                    (item) => Padding(
//                      padding: const EdgeInsets.symmetric(vertical: 8),
//                      child: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          CustomText(
//                            text: item.name.toString(),
//                            size: standardTextSize,
//                            weight: FontWeight.bold,
//                            color: strongpink,
//                          ),
//                          Column(
//                            mainAxisSize: MainAxisSize.min,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: item.events
//                                .map<Widget>(
//                                  (event) => Padding(
//                                    padding: const EdgeInsets.all(8.0),
//                                    child: Row(
//                                      children: [
//                                        SizedBox(
//                                          width: 150,
//                                          child: CustomText(
//                                            text: event.year.toString(),
//                                            size: standardTextSize,
//                                            weight: FontWeight.bold,
//                                            color: blackColor,
//                                          ),
//                                        ),
//                                        Expanded(
//                                          flex: 1,
//                                          child: CustomText(
//                                            text: event.event.toString(),
//                                            size: standardTextSize,
//                                            weight: FontWeight.bold,
//                                            color: blackColor,
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                )
//                                .toList(),
//                          ),
//                        ],
//                      ),
//                    ),
//                  )
//                  .toList(),
//        ),
//      ],
//    );
//  }
//
}
