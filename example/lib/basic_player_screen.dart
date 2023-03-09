import 'package:flutter/material.dart';
import 'package:ivs_player/ivs_player.dart';
import 'package:ivs_player/pigeon.dart';
import 'package:ivs_player/player_method.dart';
import 'package:ivs_player_example/widgets.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  IvsPlayerController _ivsPlayerController = IvsPlayerController();

  @override
  void initState() {
    super.initState();
    inas();
  }

  inas() async {
    // await _ivsPlayerController.loadUrl(
    //     url:
    //         "https://takapp-media-cdn.s3.ap-south-1.amazonaws.com/production/vod_22_Nov_2022_vdt-1/video.m3u8");
    // await _ivsPlayerController.play();
    // _ivsPlayerController.isPlayerLoaded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseIvsPlayer(
            onPlatformViewCreated: (p0) {
              IvsPlayerApi().load(
                  "https://takapp-media-cdn.s3.ap-south-1.amazonaws.com/production/vod_22_Nov_2022_vdt-1/video.m3u8");
              IvsPlayerApi().play();
            },
            ivsPlayerController: _ivsPlayerController,
          ),
          BaseIvsPlayer(
            onPlatformViewCreated: (p0) {
              IvsPlayerApi().load(
                  "https://www.hlsplayer.net/#type=m3u8&src=https%3A%2F%2Fdemo.unified-streaming.com%2Fk8s%2Ffeatures%2Fstable%2Fvideo%2Ftears-of-steel%2Ftears-of-steel.mp4%2F.m3u8");
              IvsPlayerApi().play();
            },
            ivsPlayerController: _ivsPlayerController,
          ),
          // Row(
          //   children: [
          //     CustomTextButton(
          //       label: "Load",
          //       ontap: () {
          //         IvsPlayerApi().load(
          //             "https://takapp-media-cdn.s3.ap-south-1.amazonaws.com/production/vod_22_Nov_2022_vdt-1/video.m3u8");
          //       },
          //     ),
          //     CustomTextButton(
          //       label: "Play",
          //       ontap: () {
          //         IvsPlayerApi().play();
          //       },
          //     ),
          //     CustomTextButton(
          //       label: "Pause",
          //       ontap: () {
          //         IvsPlayerApi().pause();
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
