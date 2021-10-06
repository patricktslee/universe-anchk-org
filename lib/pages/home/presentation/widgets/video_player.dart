import 'package:cached_network_image/cached_network_image.dart';
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

  const YoutubeModel(
      {required this.youtubeTitle, required this.id, required this.youtubeId});
}

class VideoPlayer extends StatefulWidget {
  VideoPlayer({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _ytbPlayerController;
  List<YoutubeModel> videosList = [
    YoutubeModel(id: 1, youtubeId: 'gCwHitVRirI', youtubeTitle: "祝福"),
    YoutubeModel(id: 2, youtubeId: '7pc4rNCmEqo', youtubeTitle: "不動搖的國度"),
    YoutubeModel(
        id: 3, youtubeId: 'UXP9sR0A0vQ', youtubeTitle: "全心全意愛上帝 2014年7月"),
    YoutubeModel(id: 4, youtubeId: 'C2szYJuQymI', youtubeTitle: "敬拜頌歌"),
    YoutubeModel(id: 5, youtubeId: 'CkjbpbRrRYo', youtubeTitle: "靠近我 2014年7月"),
  ];

  @override
  void initState() {
    super.initState();

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
          params: YoutubePlayerParams(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ResponsiveWidget.isSmallScreen(context)
          ? Column(
              children: [
                _buildYtbView(),
                _buildMoreVideoTitle(),
                _buildMoreVideosView(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildYtbView(),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 30,
                          child: _buildMoreVideoTitle(),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: _buildMoreVideosView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _ytbPlayerController != null
          ? YoutubePlayerIFrame(controller: _ytbPlayerController)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  _buildMoreVideoTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 0, horizontal: 8), //EdgeInsets.fromLTRB(14, 10, 182, 10),
      child: CustomText(
        text: "更多影片",
        size: 16,
        weight: FontWeight.bold,
        color: blackColor,
      ),
    );
  }

  _buildMoreVideosView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
            itemCount: videosList.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final _newCode = videosList[index].youtubeId;
                  _ytbPlayerController.load(_newCode);
                  _ytbPlayerController.stop();
                },
                child: AspectRatio(
                  aspectRatio: 16 / 13,
                  child: Column(
                    children: [
                      CustomText(
                        text: videosList[index].youtubeTitle,
                        size: 16,
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
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://img.youtube.com/vi/${videosList[index].youtubeId}/0.jpg",
                                      fit: BoxFit.cover,
                                    ),
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
              );
            }),
      ),
    );
  }
}
