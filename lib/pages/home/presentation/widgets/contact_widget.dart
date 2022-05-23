import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
//import 'package:universe/helpers/appwrite_image_memory.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key}) : super(key: key);
  static HomeController controller = Get.find();
  static String bgPhoto = "";
  static List contactInfoItem = [];

  @override
  Widget build(BuildContext context) {
    return getContact(context);
  }

  Widget getContact(BuildContext context) {
    controller.getContactList();
    return Obx(() {
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: SizedBox(
                  width: 750,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.memory(
                      controller.contact.value.photoFile as Uint8List,
//                      controller.contactListFile.value,
//                  controller.preachersMessagePhotoFile.value,
                      fit: BoxFit.cover,
                    ),
                    //AppwriteImageMemory(
                    //  fileId: controller.contactPhoto.value,
                    //),
                    //Container(
                    //  decoration: BoxDecoration(
                    //      image: DecorationImage(
                    //          //                                  image: AssetImage(item.photo.toString()),
                    //          image: NetworkImage(bgPhoto),
                    //          fit: BoxFit.cover)),
                    //),
                  ),
                ),
              ),
              ResponsiveWidget.isiPadScreen(context)
                  ? _contactColumn()
                  : _contactRow(),
            ],
          ),
        ),
      );
    });
  }

  Future<FutureBuilder<Object>> newMethod() async {
    return FutureBuilder<Object>(
        future: controller.getPhoto("contactList").then((value) async {
          bgPhoto = value;
          await controller
              .getContactList()
              .then((value) => contactInfoItem = value);
          return value;
        }),
        builder: (context, snapshot) {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: SizedBox(
                      width: 750,
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  //                                  image: AssetImage(item.photo.toString()),
                                  image: NetworkImage(bgPhoto),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                  ResponsiveWidget.isiPadScreen(context)
                      ? _contactColumn()
                      : _contactRow(),
                ],
              ),
            ),
          );
        });
  }

  Widget _contactRow() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: //contactInfoItem //
//            controller.contactInfoItem
            controller.contact.value.organizationInfo!
                .map(
                  (item) => _contactInfo(item),
                )
                .toList(),
      );
  Widget _contactColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: //contactInfoItem //
            controller.contact.value.organizationInfo!
                //controller.contactInfoItem
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
}
