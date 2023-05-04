import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/widgets/custom_text.dart';
//import 'package:flutter/widgets.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:get/get.dart';
import 'package:universe/helpers/responsiveness.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    int current = 0;
    return Obx(() {
      List<dynamic> _youtubeTitle = [];
      _youtubeId =
          controller.videosList.map((element) => element.youtubeId).toList();
      _youtubeImage = controller.videosList
          .map((element) => element.thumbnailImage)
          .toList();
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

      return
          //const SizedBox(
          //  child: CustomText(text: "Test"),
          //);
          Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          controller: _scrollController,
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
              screenWidth < ResponsiveWidget.getMediumScreenSize()
                  ? Column(
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
                                : const SizedBox(),
                          )
                          .toList(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _youtubeId
                              //                              .sublist(1, (_youtubeId.length / 2).ceil())
                              .map(
                                (e) => _youtubeId.indexOf(e) ==
                                            controller.currentVideo.value ||
                                        _youtubeId.indexOf(e) <
                                            _youtubeId.length / 2
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () => _updateCurrent(
                                            _youtubeId.indexOf(e)),
                                        child: VideoCard(
                                            e: e,
                                            youtubeTitle: _youtubeTitle,
                                            youtubeId: _youtubeId,
                                            // screenWidth: screenWidth,
                                            youtubeImage: _youtubeImage),
                                      ),
                              )
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _youtubeId
                              //.sublist((_youtubeId.length / 2).ceil(),
                              //    _youtubeId.length)
                              .map(
                                (e) => _youtubeId.indexOf(e) ==
                                            controller.currentVideo.value ||
                                        _youtubeId.indexOf(e) >=
                                            _youtubeId.length / 2
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () => _updateCurrent(
                                            _youtubeId.indexOf(e)),
                                        child: VideoCard(
                                            e: e,
                                            youtubeTitle: _youtubeTitle,
                                            youtubeId: _youtubeId,
                                            // screenWidth: screenWidth,
                                            youtubeImage: _youtubeImage),
                                      ),
                              )
                              .toList(),
                        )
                      ],
                    ),
            ],
          ),
        ),
      );
    });
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
    double cardWidth = screenWidth < ResponsiveWidget.getMediumScreenSize()
        ? screenWidth
        : screenWidth < ResponsiveWidget.getCustomScreenSize()
            ? (ResponsiveWidget.getMediumScreenSize() * 3 / 4) / 3
            : (ResponsiveWidget.getCustomScreenSize() * 3 / 4) / 3;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4.0,
        color: const Color(0xFFD3D3D3),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: cardWidth,
                child: CustomText(
                  text: _youtubeTitle[_youtubeId.indexOf(_e)],
                  size: standardTextSize,
                  color: blackColor,
                  weight: FontWeight.bold,
                ),
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
                  child: SizedBox(
                    width: cardWidth,
                    child: Image.network(_youtubeImage[_youtubeId.indexOf(_e)]),
                  ),
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
