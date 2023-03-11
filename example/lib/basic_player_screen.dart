import 'package:flutter/material.dart';
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
  // final IvsPlayerController _ivsPlayerController2 = IvsPlayerController();

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
    await _ivsPlayerController1.load(
        url:
            "https://takapp-media-cdn.s3.ap-south-1.amazonaws.com/production/vod_22_Nov_2022_vdt-1/video.m3u8");
    await _ivsPlayerController1.play();
  }

  // initPlayer2() async {
  //   await _ivsPlayerController2.load(
  //       url:
  //           "https://vod.thelallantop.com/output-videos-transcoded/vod_10_Mar_2023_lallantop_show_1195/video_Ott_Hls_Ts_Avc_Aac_16x9_1280x720p_1Mbps_qvbr.m3u8");
  //   await _ivsPlayerController2.play();
  // }

  // @override
  // void dispose() async {
  //   if (mounted) {
  //     _ivsPlayerController.dispose();
  //   }
  //   super.dispose();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              BaseIvsPlayer(
                ivsPlayerController: _ivsPlayerController1,
              ),
              Positioned.fill(
                child: _ivsPlayerController1.isPlayerLoaded
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: iconColor,
                                  size: iconSize,
                                  shadows: iconShadow,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.skip_previous,
                                  color: iconColor,
                                  size: iconSize * largeIconScale,
                                  shadows: iconShadow,
                                ),
                                Visibility(
                                  visible: false,
                                  replacement: Icon(
                                    Icons.pause,
                                    color: iconColor,
                                    size: iconSize * largeIconScale,
                                    shadows: iconShadow,
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: iconColor,
                                    size: iconSize * largeIconScale,
                                    shadows: iconShadow,
                                  ),
                                ),
                                Icon(
                                  Icons.skip_next,
                                  color: iconColor,
                                  size: iconSize * largeIconScale,
                                  shadows: iconShadow,
                                ),
                              ],
                            ),
                            CustomSlider(width: double.infinity, height: 10),
                            // SizedBox(
                            //   height: 20,
                            //   child: FutureBuilder<double>(
                            //     future: _ivsPlayerController1.videoDuration(),
                            //     builder: (context, future) {
                            //       if (future.connectionState ==
                            //               ConnectionState.done &&
                            //           future.hasData) {
                            //         return Slider(
                            //           value: future.data!,
                            //           max: future.data!,
                            //           min: 0,
                            //           divisions: future.data?.ceil(),
                            //           onChanged: (value) {
                            //             _ivsPlayerController1.seekTo(value);
                            //           },
                            //         );
                            //       }
                            //       return const SizedBox();
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  final double width;
  final double height;
  const CustomSlider({super.key, required this.width, required this.height});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double currentXAlignment = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      width: 300,
      alignment: Alignment(1, 0),
      height: widget.height,
      child: Center(
        child: OverflowBox(
          maxHeight: 40,
          maxWidth: 40,
          minHeight: 40,
          minWidth: 40,
          alignment: Alignment.center,
          child: Container(
            height: 40,
            alignment: Alignment.center,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
