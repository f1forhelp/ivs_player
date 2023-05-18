import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ivs_player/ivs_player.dart';
// import 'package:ivs_player/player_method.dart';
import 'package:ivs_player_example/widgets.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final IvsPlayerController _ivsPlayerController1 = IvsPlayerController();
  final IvsPlayerController _ivsPlayerController2 = IvsPlayerController();

  @override
  void initState() {
    super.initState();
    _ivsPlayerController1.addListener(() {
      setState(() {});
    });
    initPlayer1();
    // initPlayer2();
  }

  initPlayer1() async {
    await _ivsPlayerController1.initialize();
    // await _ivsPlayerController1.load(
    //     url: "http://cdn-fms.rbs.com.br/vod/hls_sample1_manifest.m3u8");
    await _ivsPlayerController1.load(
        url:
            "https://static.crimetak.in/production/output-videos-transcoded/vod_23_Mar_2023_marpit/video.m3u8");
    // await _ivsPlayerController1.play();
    await _ivsPlayerController1.mute(v: true);
  }

  initPlayer2() async {
    await _ivsPlayerController2.initialize();
    await _ivsPlayerController2.load(
        url:
            "https://static.crimetak.in/production/output-videos-transcoded/vod_26_Mar_2023_delhi-jump/video.m3u8");
    await _ivsPlayerController2.play();
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.white;
    double iconSize = 24;
    double largeIconScale = 1.4;
    List<Shadow> iconShadow = const [
      Shadow(color: Colors.black45, blurRadius: 4)
    ];

    return Scaffold(
      // backgroundColor: Colors.,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BaseIvsPlayer(
            controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
            ivsPlayerController: _ivsPlayerController1,
          ),
          CustomTextButton(
            label: "SetState",
            ontap: () {
              setState(() {});
            },
          ),
          // BaseIvsPlayer(
          //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
          //   ivsPlayerController: _ivsPlayerController2,
          // ),
          // Image.network(
          //     "https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg"),
          // TextButton(
          //     onPressed: () {
          //       setState(() {});
          //     },
          //     child: Text("SETSTATE")),
        ],
      ),
    );
  }
}
