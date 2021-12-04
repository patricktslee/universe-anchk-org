//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/widgets/custom_text.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeModel {
  final int id;
  final String youtubeId;
  final String youtubeTitle;
  final String thumbnailImage;

  const YoutubeModel({
    required this.youtubeTitle,
    required this.id,
    required this.youtubeId,
    required this.thumbnailImage,
  });
}

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

//get image from https://img.youtube.com/vi/b53oI2p-UrI/0.jpg
class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController _ytbPlayerController =
      YoutubePlayerController(initialVideoId: 'Hp8P_CXOQ68');
  late ScrollController _scrollController;
  List<YoutubeModel> videosList = const [
    YoutubeModel(
        id: 1,
        youtubeId: 'Hp8P_CXOQ68',
        youtubeTitle: "萬國宣道詠團30周年音樂會招募",
        thumbnailImage: "Hp8P_CXOQ68.jpg"),
    YoutubeModel(
        id: 2,
        youtubeId: 'b53oI2p-UrI',
        youtubeTitle: "朋友請聽 2019",
        thumbnailImage: "b53oI2p-UrI.jpg"),
    YoutubeModel(
        id: 3,
        youtubeId: 'ArJj0pMqJls',
        youtubeTitle: "同來讚美救主",
        thumbnailImage: "ArJj0pMqJls.jpg"),
    YoutubeModel(
        id: 4,
        youtubeId: 'UXP9sR0A0vQ',
        youtubeTitle: "全心全意愛上帝 2014年7月",
        thumbnailImage: "UXP9sR0A0vQ.jpg"),
    YoutubeModel(
        id: 5,
        youtubeId: 'C2szYJuQymI',
        youtubeTitle: "敬拜頌歌",
        thumbnailImage: "C2szYJuQymI.jpg"),
    YoutubeModel(
        id: 6,
        youtubeId: 'CkjbpbRrRYo',
        youtubeTitle: "靠近我 2014年7月",
        thumbnailImage: "CkjbpbRrRYo.jpg"),
    YoutubeModel(
        id: 7,
        youtubeId: 'gCwHitVRirI',
        youtubeTitle: "祝福",
        thumbnailImage: "gCwHitVRirI.jpg"),
    YoutubeModel(
        id: 8,
        youtubeId: '7pc4rNCmEqo',
        youtubeTitle: "不動搖的國度",
        thumbnailImage: "7pc4rNCmEqo.jpg"),
  ];

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

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _ytbPlayerController = YoutubePlayerController(
          initialVideoId: videosList[0].youtubeId,
          params: const YoutubePlayerParams(
            showFullscreenButton: true,
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return
        //Scaffold(
        //  backgroundColor: Colors.transparent,
        //  body:
        ResponsiveWidget.isiPadScreen(context) ||
                ResponsiveWidget.isSmallMediumScreen(context)
            ? SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // const Text("data"),
                    _buildYtbView(),
                    _buildMoreVideoTitle(),
                    _buildMoreVideosNewView(),
                  ],
                ),
              )

            //Column(
            //    children: [
            //      _buildYtbView(),
            //      _buildMoreVideoTitle(),
            //      _buildMoreVideosView(),
            //    ],
            //  )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: _buildYtbView(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 50,
                            child: _buildMoreVideoTitle(),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: _buildMoreVideosNewView(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
    // );
  }

  _buildYtbView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child:
            //_ytbPlayerController != null
            //    ? YoutubePlayerIFrame(controller: _ytbPlayerController)
            //    : const Center(child: CircularProgressIndicator()),
            YoutubePlayerIFrame(controller: _ytbPlayerController),
      ),
    );
  }

  _buildMoreVideoTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 0, horizontal: 8), //EdgeInsets.fromLTRB(14, 10, 182, 10),
      child: CustomText(
        text: "更多影片",
        size: standardTextSize,
        weight: FontWeight.bold,
        color: blackColor,
      ),
    );
  }

  _buildMoreVideosNewView() {
    return Column(
      children: <Widget>[
        ...videosList.map((e) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: AspectRatio(
              aspectRatio: 16 / 13,
              child: GestureDetector(
                onTap: () {
                  _scrollToTop();
                  final _newCode = e.youtubeId;
                  _ytbPlayerController.load(_newCode);
                  _ytbPlayerController.stop();
                  _ytbPlayerController.play();
                },
                child: AspectRatio(
                  aspectRatio: 16 / 13,
                  child: Column(
                    children: [
                      CustomText(
                        text: e.youtubeTitle,
                        size: standardTextSize,
                        weight: FontWeight.bold,
                        color: blackColor,
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Positioned(
                                      child: Image.asset(
                                    'assets/images/${e.thumbnailImage}',
                                    fit: BoxFit.cover,
                                  )
                                      //CachedNetworkImage(
                                      //  imageUrl:
                                      //      "https://img.youtube.com/vi/${videosList[index].youtubeId}/0.jpg",
                                      //  fit: BoxFit.cover,
                                      //),
                                      ),
                                  Positioned(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/images/ytbPlayBotton.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
