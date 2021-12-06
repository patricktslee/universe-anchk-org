import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(welcomePhoto)),
                  ),
                ],
              ),
            ),
            ResponsiveWidget.isiPadScreen(context)
                ? _contactColumn()
                : _contactRow(),
          ],
        ),
      ),
    );
  }

  Widget _contactRow() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: controller.contactInfoItem
            .map(
              (item) => _contactInfo(item),
            )
            .toList(),
      );
  Widget _contactColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: controller.contactInfoItem
            .map(
              (item) => _contactInfo(item),
            )
            .toList(),
      );

  Widget _contactInfo(dynamic item) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: item.name.toString(),
                    size: standardTextSize,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.phone, size: 22, color: dark),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch('tel:${item.telephone.toString()}')) {
                        await launch('tel:${item.telephone.toString()}');
                      } else {
                        throw 'Could not launch ${item.email.toString()}';
                      }
                    },
                    child: CustomText(
                      text: item.telephone.toString(),
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.web, size: 22, color: dark),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch(item.url.toString())) {
                        await launch(
                          item.url.toString(),
                          forceSafariVC: true,
                          forceWebView: true,
                        );
                      } else {
                        throw 'Could not launch ${item.url.toString()}';
                      }
                    },
                    child: CustomText(
                      text: item.url.toString(),
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.email_outlined, size: 22, color: dark),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch('mailto:${item.email.toString()}')) {
                        await launch(
                            'mailto:${item.email.toString()}?subject=關於萬國宣道詠團的查詢');
                      } else {
                        throw 'Could not launch ${item.email.toString()}';
                      }
                    },
                    child: CustomText(
                      text: item.email.toString(),
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.facebook, size: 22, color: dark),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch(item.facebook.toString())) {
                        await launch(
                          item.facebook.toString(),
                          forceSafariVC: true,
                          forceWebView: true,
                        );
                      } else {
                        throw 'Could not launch ${item.facebook.toString()}';
                      }
                    },
                    child: CustomText(
                      text: item.name.toString(),
                      size: standardTextSize,
                      weight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _contactPhoto(BuildContext context) => Expanded(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(welcomePhoto)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: MediaQuery.of(context).size.width < 809 ? 1 : 2,
                childAspectRatio:
                    MediaQuery.of(context).size.width < 809 ? 1.4 : 1.1,
                children: controller.contactInfoItem
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: item.name.toString(),
                                    size: standardTextSize,
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.phone, size: 22, color: dark),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      if (await canLaunch(
                                          'tel:${item.telephone.toString()}')) {
                                        await launch(
                                            'tel:${item.telephone.toString()}');
                                      } else {
                                        throw 'Could not launch ${item.email.toString()}';
                                      }
                                    },
                                    child: CustomText(
                                      text: item.telephone.toString(),
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.web, size: 22, color: dark),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      if (await canLaunch(
                                          item.url.toString())) {
                                        await launch(
                                          item.url.toString(),
                                          forceSafariVC: true,
                                          forceWebView: true,
                                        );
                                      } else {
                                        throw 'Could not launch ${item.url.toString()}';
                                      }
                                    },
                                    child: CustomText(
                                      text: item.url.toString(),
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.email_outlined,
                                    size: 22, color: dark),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      if (await canLaunch(
                                          'mailto:${item.email.toString()}')) {
                                        await launch(
                                            'mailto:${item.email.toString()}?subject=關於萬國宣道詠團的查詢');
                                      } else {
                                        throw 'Could not launch ${item.email.toString()}';
                                      }
                                    },
                                    child: CustomText(
                                      text: item.email.toString(),
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.facebook, size: 22, color: dark),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      if (await canLaunch(
                                          item.facebook.toString())) {
                                        await launch(
                                          item.facebook.toString(),
                                          forceSafariVC: true,
                                          forceWebView: true,
                                        );
                                      } else {
                                        throw 'Could not launch ${item.facebook.toString()}';
                                      }
                                    },
                                    child: CustomText(
                                      text: item.name.toString(),
                                      size: standardTextSize,
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ));

  Widget _contactWidget(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(welcomePhoto)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: MediaQuery.of(context).size.width < 809 ? 1 : 2,
              childAspectRatio:
                  MediaQuery.of(context).size.width < 809 ? 1.4 : 1.1,
              children: controller.contactInfoItem
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: item.name.toString(),
                                  size: standardTextSize,
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.phone, size: 22, color: dark),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (await canLaunch(
                                        'tel:${item.telephone.toString()}')) {
                                      await launch(
                                          'tel:${item.telephone.toString()}');
                                    } else {
                                      throw 'Could not launch ${item.email.toString()}';
                                    }
                                  },
                                  child: CustomText(
                                    text: item.telephone.toString(),
                                    size: standardTextSize,
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.web, size: 22, color: dark),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (await canLaunch(item.url.toString())) {
                                      await launch(
                                        item.url.toString(),
                                        forceSafariVC: true,
                                        forceWebView: true,
                                      );
                                    } else {
                                      throw 'Could not launch ${item.url.toString()}';
                                    }
                                  },
                                  child: CustomText(
                                    text: item.url.toString(),
                                    size: standardTextSize,
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.email_outlined, size: 22, color: dark),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (await canLaunch(
                                        'mailto:${item.email.toString()}')) {
                                      await launch(
                                          'mailto:${item.email.toString()}?subject=關於萬國宣道詠團的查詢');
                                    } else {
                                      throw 'Could not launch ${item.email.toString()}';
                                    }
                                  },
                                  child: CustomText(
                                    text: item.email.toString(),
                                    size: standardTextSize,
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.facebook, size: 22, color: dark),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (await canLaunch(
                                        item.facebook.toString())) {
                                      await launch(
                                        item.facebook.toString(),
                                        forceSafariVC: true,
                                        forceWebView: true,
                                      );
                                    } else {
                                      throw 'Could not launch ${item.facebook.toString()}';
                                    }
                                  },
                                  child: CustomText(
                                    text: item.name.toString(),
                                    size: standardTextSize,
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      );
}
