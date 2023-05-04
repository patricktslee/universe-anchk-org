//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:universe/constants/metadata.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
//import 'package:universe/shared/app_constants.dart';
import 'package:universe/widgets/custom_text.dart';

import 'package:logger/logger.dart';
//import 'package:flutter/widgets.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoList2 extends StatefulWidget {
  const VideoList2({Key? key}) : super(key: key);

  @override
  State<VideoList2> createState() => _VideoList2State();
}

class _VideoList2State extends State<VideoList2> {
  static HomeController controller = Get.find();
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  List<dynamic> _youtubeId = [
    'Hp8P_CXOQ68',
    'b53oI2p-UrI',
    'ArJj0pMqJls',
    'UXP9sR0A0vQ',
    'C2szYJuQymI',
    'CkjbpbRrRYo',
    'gCwHitVRirI',
    '7pc4rNCmEqo',
  ];
  List<dynamic> _youtubeImage = [
    'https://appwrite.anchk.org/v1/storage/files/61fa03501566e7c7e9f5/view?project=61b0428203f09&mode=admin',
    'https://appwrite.anchk.org/v1/storage/files/61fa03b010bb5b1a9e37/view?project=61b0428203f09&mode=admin',
    'https://appwrite.anchk.org/v1/storage/files/61fa0413da27c99de0e2/view?project=61b0428203f09&mode=admin',
    'https://appwrite.anchk.org/v1/storage/files/61fa044fabb08c9ad763/view?project=61b0428203f09&mode=admin',
    'https://appwrite.anchk.org/v1/storage/files/61fa049502e56e485502/view?project=61b0428203f09&mode=admin',
    'https://appwrite.anchk.org/v1/storage/files/61fa04d454a878685a54/view?project=61b0428203f09&mode=admin',
    'https://appwrite.anchk.org/v1/storage/files/61fa05204108db2edb40/view?project=61b0428203f09&mode=admin',
    'https://appwrite.anchk.org/v1/storage/files/61fa0587498cdb051b57/view?project=61b0428203f09&mode=admin',
  ];
  late ScrollController _scrollController;
  //YoutubePlayerController _ytbPlayerController =
  //    YoutubePlayerController(initialVideoId: 'Hp8P_CXOQ68');

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
// show the back-to-top button
          } else {
// hide the back-to-top button
          }
        });
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = ResponsiveWidget.isSmallScreen(context)
        ? 400
        : ResponsiveWidget.isLargeScreen(context)
            ? 650
            : 500;

    double bannerWidth = ResponsiveWidget.isSmallScreen(context)
        ? 460
        : ResponsiveWidget.isLargeScreen(context)
            ? 690
            : 575;
    double bannerHeight = ResponsiveWidget.isSmallScreen(context)
        ? 48
        : ResponsiveWidget.isLargeScreen(context)
            ? 72
            : 60;
    double screenWidth = MediaQuery.of(context).size.width;
    int current = 0;

    return getWhatNews(
        cardWidth, bannerWidth, bannerHeight, screenWidth, current);
  }

  Widget getWhatNews(double cardWidth, double bannerWidth, double bannerHeight,
      double screenWidth, int current) {
//    HomeController controller = Get.find();
//    controller.getWhatNews();
//    List<Shadow> shadow = const [
//      Shadow(
//        blurRadius: 10.0,
////        color: Colors.teal,
//        color: Colors.white,
//        offset: Offset(5, 5),
//      )
//    ];
    List<dynamic> _youtubeTitle = [];
    _youtubeId =
        controller.videosList.map((element) => element.youtubeId).toList();
    _youtubeImage =
        controller.videosList.map((element) => element.thumbnailImage).toList();
    _youtubeTitle =
        controller.videosList.map((element) => element.youtubeTitle).toList();
    final List<YoutubePlayerController> _controllers = _youtubeId
        .map<YoutubePlayerController>(
          (videoId) => YoutubePlayerController.fromVideoId(
            videoId: videoId,
            //YoutubePlayerController(
            // initialVideoId: videoId,
            //flags: const YoutubePlayerFlags(
            //  autoPlay: false,
            //),
            params: const YoutubePlayerParams(
              showFullscreenButton: true,
            ),
          ),
        )
        .toList();
//      _ytbPlayerController = _controllers[current];
    void _debug(String value) {
      value = "At HomeController class - " + value;
      print(value);
      logger.i(value);
    }

    void _scrollToTop() {
      _scrollController.animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    }

    _updateCurrent(int value) {
      setState(() {
        current = value;
        controller.updateCurrentVideo(value);
        _debug("current is $current,");
        _scrollToTop();
      });
    }

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Obx(() {
            //int indexOfDivided = 0;
            //for (var whatNew in controller.whatNews) {
            //  if (whatNew.isCompleted != true) {
            //    indexOfDivided++;
            //  }
            //}
            return
                // (controller.whatNews.isEmpty)
                //    ? const CustomText(
                //        text: "數據加載中....",
                //        color: AppConstants.defaultTextColor,
                //        size: 30,
                //        weight: FontWeight.bold,
                //        textAlign: TextAlign.center,
                //      )
                //    :
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blue,
                                Colors.red,
                              ],
                            )),
                        child: Text(
                            controller.videosList[controller.currentVideo.value]
                                .youtubeTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Column(
                        children: _controllers
                            .map((e) => _controllers.indexOf(e) ==
                                    controller.currentVideo.value
                                ? YoutubePlayer(
                                    key: ObjectKey(e),
                                    aspectRatio: 16 / 9,
                                    controller: e,
                                  )
                                : const SizedBox(
                                    width: 0,
                                    height: 0,
                                  ))
                            .toList(),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _youtubeId
                        .map(
                          (e) => _youtubeId.indexOf(e) !=
                                  controller.currentVideo.value
                              ? InkWell(
                                  onTap: () =>
                                      _updateCurrent(_youtubeId.indexOf(e)),
                                  child: VideoCard(
                                      e: e,
                                      youtubeTitle: _youtubeTitle,
                                      youtubeId: _youtubeId,
                                      // screenWidth: screenWidth,
                                      youtubeImage: _youtubeImage),
                                )
                              : const SizedBox(
                                  width: 0,
                                  height: 0,
                                ),
                        )
                        .toList(),
                  ),
                  //screenWidth < ResponsiveWidget.getMediumScreenSize()
                  //    ? Column(
                  //        mainAxisAlignment: MainAxisAlignment.start,
                  //        crossAxisAlignment: CrossAxisAlignment.start,
                  //        children: _youtubeId
                  //            .map(
                  //              (e) => _youtubeId.indexOf(e) !=
                  //                      controller.currentVideo.value
                  //                  ? InkWell(
                  //                      onTap: () => _updateCurrent(
                  //                          _youtubeId.indexOf(e)),
                  //                      child: VideoCard(
                  //                          e: e,
                  //                          youtubeTitle: _youtubeTitle,
                  //                          youtubeId: _youtubeId,
                  //                          // screenWidth: screenWidth,
                  //                          youtubeImage: _youtubeImage),
                  //                    )
                  //                  : const SizedBox(),
                  //            )
                  //            .toList(),
                  //      )
                  //    : Row(
                  //        mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //        crossAxisAlignment: CrossAxisAlignment.start,
                  //        children: [
                  //          Column(
                  //            mainAxisAlignment: MainAxisAlignment.start,
                  //            crossAxisAlignment: CrossAxisAlignment.start,
                  //            children: _youtubeId
                  //                //                              .sublist(1, (_youtubeId.length / 2).ceil())
                  //                .map(
                  //                  (e) => _youtubeId.indexOf(e) ==
                  //                              controller.currentVideo.value ||
                  //                          _youtubeId.indexOf(e) <
                  //                              _youtubeId.length / 2
                  //                      ? const SizedBox()
                  //                      : InkWell(
                  //                          onTap: () => _updateCurrent(
                  //                              _youtubeId.indexOf(e)),
                  //                          child: VideoCard(
                  //                              e: e,
                  //                              youtubeTitle: _youtubeTitle,
                  //                              youtubeId: _youtubeId,
                  //                              // screenWidth: screenWidth,
                  //                              youtubeImage: _youtubeImage),
                  //                        ),
                  //                )
                  //                .toList(),
                  //          ),
                  //          Expanded(
                  //            child: Column(
                  //              mainAxisAlignment: MainAxisAlignment.start,
                  //              crossAxisAlignment: CrossAxisAlignment.start,
                  //              children: _youtubeId
                  //                  //.sublist((_youtubeId.length / 2).ceil(),
                  //                  //    _youtubeId.length)
                  //                  .map(
                  //                    (e) => _youtubeId.indexOf(e) ==
                  //                                controller
                  //                                    .currentVideo.value ||
                  //                            _youtubeId.indexOf(e) >=
                  //                                _youtubeId.length / 2
                  //                        ? const SizedBox()
                  //                        : InkWell(
                  //                            onTap: () => _updateCurrent(
                  //                                _youtubeId.indexOf(e)),
                  //                            child: VideoCard(
                  //                                e: e,
                  //                                youtubeTitle: _youtubeTitle,
                  //                                youtubeId: _youtubeId,
                  //                                // screenWidth: screenWidth,
                  //                                youtubeImage: _youtubeImage),
                  //                          ),
                  //                  )
                  //                  .toList(),
                  //            ),
                  //          )
                  //        ],
                  //      ),
                ],
              ),
              //Column(
              //  children: controller.whatNews
              //      .map(
              //        (item) => Padding(
              //          padding: const EdgeInsets.all(8.0),
              //          child: Column(
              //            children: [
              //              Padding(
              //                padding: const EdgeInsets.all(8.0),
              //                child: SizedBox(
              //                  width: cardWidth,
              //                  height: 9 / 16 * cardWidth,
              //                  child: Container(
              //                    decoration: BoxDecoration(
              //                        boxShadow: item.isCompleted!
              //                            ? const [
              //                                BoxShadow(
              //                                  color: Color.fromRGBO(
              //                                      253, 253, 150, 1),
              //                                  blurRadius: 20.0,
              //                                ),
              //                              ]
              //                            : const [
              //                                BoxShadow(
              //                                  color: Colors.white,
              //                                  blurRadius: 20.0,
              //                                ),
              //                              ],
              //                        image: DecorationImage(
              //                            image: MemoryImage(item
              //                                .bgPhotoFile as Uint8List),
              //                            fit: BoxFit.cover)),
              //                    child: Stack(
              //                      alignment: Alignment.center,
              //                      children: [
              //                        Positioned(
              //                          top: 5 + (cardWidth / 15.5) / 2,
              //                          child: SizedBox(
              //                            width: cardWidth * (1 / 2),
              //                            height: 10 /
              //                                16 *
              //                                (cardWidth * (1 / 2)),
              //                            child: Container(
              //                              decoration: BoxDecoration(
              //                                  image: DecorationImage(
              //                                      image: MemoryImage(
              //                                          item.photoFile
              //                                              as Uint8List),
              //                                      fit: BoxFit.cover)),
              //                            ),
              //                          ),
              //                        ),
              //                        Positioned(
              //                          bottom: (9 / 16 * cardWidth) / 5,
              //                          child: Padding(
              //                            padding:
              //                                const EdgeInsets.all(8.0),
              //                            child: Container(
              //                              width: cardWidth * (1 / 2),
              //                              color: Colors.white10
              //                                  .withOpacity(0.5),
              //                              child: CustomText(
              //                                text: item.event.toString(),
              //                                textAlign: TextAlign.center,
              //                                size: standardTextSize,
              //                                weight: FontWeight.bold,
              //                                color: Colors.black,
              //                                shadow: shadow,
              //                              ),
              //                            ),
              //                          ),
              //                        ),
              //                        Positioned(
              //                          bottom:
              //                              ((9 / 16 * cardWidth) / 5) -
              //                                  30,
              //                          child: Padding(
              //                            padding:
              //                                const EdgeInsets.all(8.0),
              //                            child: Container(
              //                              width: cardWidth * (1 / 2),
              //                              color: Colors.white10
              //                                  .withOpacity(0.5),
              //                              child: CustomText(
              //                                text: item.place.toString(),
              //                                textAlign: TextAlign.center,
              //                                size: standardTextSize,
              //                                weight: FontWeight.normal,
              //                                color: Colors.black,
              //                                shadow: shadow,
              //                              ),
              //                            ),
              //                          ),
              //                        ),
              //                        Positioned(
              //                          top: 5,
              //                          right: 5,
              //                          child: item.isCompleted!
              //                              ? const Icon(
              //                                  Icons.done_outline,
              //                                  color: Colors.green,
              //                                  size: 60,
              //                                )
              //                              : const Icon(
              //                                  Icons.run_circle,
              //                                  color: Colors.yellow,
              //                                  size: 50,
              //                                ),
              //                        ),
              //                        Positioned(
              //                          top: 5,
              //                          left: 5,
              //                          child: SizedBox(
              //                            width: cardWidth / 7,
              //                            height: (cardWidth / 15.5) * 2,
              //                            child: Container(
              //                              decoration: BoxDecoration(
              //                                border: Border.all(
              //                                    color: Colors.blue),
              //                                gradient:
              //                                    const LinearGradient(
              //                                  begin:
              //                                      Alignment.topCenter,
              //                                  end: Alignment
              //                                      .bottomCenter,
              //                                  colors: [
              //                                    Color.fromRGBO(
              //                                        61, 61, 61, 1),
              //                                    Colors.white,
              //                                  ],
              //                                ),
              //                              ),
              //                              child: Center(
              //                                child: CustomText(
              //                                  text:
              //                                      item.year.toString() +
              //                                          "年",
              //                                  textAlign:
              //                                      TextAlign.center,
              //                                  size: smallTextSize,
              //                                  weight: FontWeight.bold,
              //                                  color: blackColor,
              //                                ),
              //                              ),
              //                            ),
              //                          ),
              //                        ),
              //                        Positioned(
              //                          top: 5,
              //                          left: 5 + (cardWidth / 7),
              //                          child: SizedBox(
              //                            width: cardWidth / 11,
              //                            height: (cardWidth / 15.5),
              //                            child: Container(
              //                              decoration: BoxDecoration(
              //                                border: Border.all(
              //                                    color: Colors.blue),
              //                                color: blackColor,
              //                              ),
              //                              child: Center(
              //                                child: CustomText(
              //                                  text: item.day! < 10
              //                                      ? "0" +
              //                                          item.day
              //                                              .toString()
              //                                      : item.day.toString(),
              //                                  textAlign:
              //                                      TextAlign.center,
              //                                  size: smallTextSize,
              //                                  weight: FontWeight.bold,
              //                                  color: Colors.white,
              //                                ),
              //                              ),
              //                            ),
              //                          ),
              //                        ),
              //                        Positioned(
              //                          top: 5 + (cardWidth / 15.5),
              //                          left: 5 + (cardWidth / 7),
              //                          child: SizedBox(
              //                            width: cardWidth / 11,
              //                            height: (cardWidth / 15.5),
              //                            child: Container(
              //                              decoration: BoxDecoration(
              //                                border: Border.all(
              //                                    color: Colors.blue),
              //                                color: Colors.white,
              //                              ),
              //                              child: Center(
              //                                child: CustomText(
              //                                  text: item.month
              //                                          .toString() +
              //                                      "月",
              //                                  textAlign:
              //                                      TextAlign.center,
              //                                  size: smallTextSize,
              //                                  weight: FontWeight.bold,
              //                                  color: blackColor,
              //                                ),
              //                              ),
              //                            ),
              //                          ),
              //                        ),
              //                      ],
              //                    ),
              //                  ),
              //                ),
              //              ),
              //              const SizedBox(
              //                height: 50,
              //              ),
              //              (controller.whatNews.indexOf(item) ==
              //                      indexOfDivided - 1)
              //                  ? Padding(
              //                      padding: const EdgeInsets.only(
              //                        top: 8,
              //                        bottom: 32,
              //                      ),
              //                      child: Container(
              //                        height: bannerHeight,
              //                        width: bannerWidth,
              //                        decoration: BoxDecoration(
              //                          image: DecorationImage(
              //                              image: AssetImage(
              //                                  anchkorgBanner),
              //                              fit: BoxFit.cover),
              //                        ),
              //                      ),
              //                    )
              //                  : const SizedBox(),
              //            ],
              //          ),
              //        ),
              //      )
              //      .toList(),
            );
          }),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
    required dynamic e,
    required List youtubeTitle,
    required List youtubeId,
//    required this.screenWidth,
    required List youtubeImage,
  })  : _e = e,
        _youtubeTitle = youtubeTitle,
        _youtubeId = youtubeId,
        _youtubeImage = youtubeImage,
        super(key: key);

  final dynamic _e;
  final List _youtubeTitle;
  final List _youtubeId;
//  final double screenWidth;
  final List _youtubeImage;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth;
    //double cardWidth = screenWidth < ResponsiveWidget.getMediumScreenSize()
    //    ? screenWidth
    //    : screenWidth < ResponsiveWidget.getCustomScreenSize()
    //        ? (ResponsiveWidget.getMediumScreenSize() * 3 / 4) / 3
    //        : (ResponsiveWidget.getCustomScreenSize() * 3 / 4) / 3;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: cardWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: _youtubeTitle[_youtubeId.indexOf(_e)],
                size: standardTextSize,
                color: blackColor,
                weight: FontWeight.bold,
              ),
              _space,
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF696969),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(_youtubeImage[_youtubeId.indexOf(_e)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget get _space => const SizedBox(height: 10);
