import 'package:better_player/better_player.dart';
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
  final IvsPlayerController _ivsPlayerController3 = IvsPlayerController();
  final IvsPlayerController _ivsPlayerController4 = IvsPlayerController();

  String ivsQuestionLivePortrait =
      "https://4c62a87c1810.us-west-2.playback.live-video.net/api/video/v1/us-west-2.049054135175.channel.GHRwjPylmdXm.m3u8?allow_source=true";

  String ivsLiveVideo =
      "https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.DmumNckWFTqz.m3u8";
  String shortCtVideo =
      "https://static.crimetak.in/production/output-videos-transcoded/vod_23_Mar_2023_marpit/video.m3u8";

  String ctSample1 =
      "https://vodlallantop.akamaized.net/output-videos-transcoded/vod_01_Nov_2022_unlist-link-for-check/video.m3u8";
  String ctSample2 =
      "https://vodlallantop.akamaized.net/output-videos-transcoded/vod_07_Nov_2022_Quiz-0711/video.m3u8";

  String ctSample3 =
      "https://static.crimetak.in/production/output-videos-transcoded/vod_05_Apr_2023_Bataulebazi-5/video.m3u8";

  @override
  void initState() {
    super.initState();
    initPlayer1();
    // initPlayer2();
    // initPlayer3();
  }

  @override
  void dispose() {
    _ivsPlayerController1.dispose();
    // _ivsPlayerController2.dispose();
    // _ivsPlayerController3.dispose();
    super.dispose();
  }

  initPlayer1() async {
    await _ivsPlayerController1.initialize();
    await _ivsPlayerController1.load(url: ctSample1);
  }

  initPlayer2() async {
    await _ivsPlayerController2.initialize();
    await _ivsPlayerController2.load(url: ctSample2);
  }

  initPlayer3() async {
    await _ivsPlayerController3.initialize();
    await _ivsPlayerController3.load(url: ivsQuestionLivePortrait);
  }

  // initPlayer2() async {
  //   await _ivsPlayerController2.initialize();
  //   await _ivsPlayerController2.load(url: ivsQuizzSample);
  //   // await _ivsPlayerController2.play();
  // }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseIvsPlayer(
                controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
                ivsPlayerController: _ivsPlayerController1,
              ),
              // BaseIvsPlayer(
              //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
              //   ivsPlayerController: _ivsPlayerController2,
              // ),
              // BaseIvsPlayer(
              //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
              //   ivsPlayerController: _ivsPlayerController3,
              // ),
              // BaseIvsPlayer(
              //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
              //   ivsPlayerController: _ivsPlayerController2,
              // ),
              // BaseIvsPlayer(
              //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
              //   ivsPlayerController: _ivsPlayerController2,
              // ),
              // BaseIvsPlayer(
              //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
              //   ivsPlayerController: _ivsPlayerController3,
              // ),
              // BaseIvsPlayer(
              //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
              //   ivsPlayerController: _ivsPlayerController4,
              // ),
              // BetterPlayer(controller: betterPlayerController),
              // BetterPlayer.network(
              //     "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8"),
              // CustomTextButton(
              //   label: "SetState",
              //   ontap: () {
              //     setState(() {});
              //   },
              // ),
              // BaseIvsPlayer(
              //   controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
              //   ivsPlayerController: _ivsPlayerController2,
              // ),
              // Image.network(
              //     "https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg"),
              TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("SETSTATE")),
            ],
          ),
        ),
      ),
    );
  }
}
