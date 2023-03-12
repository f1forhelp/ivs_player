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
                                PlayPauseButton(
                                    iconColor: iconColor,
                                    iconSize: iconSize,
                                    largeIconScale: largeIconScale,
                                    iconShadow: iconShadow),
                                Icon(
                                  Icons.skip_next,
                                  color: iconColor,
                                  size: iconSize * largeIconScale,
                                  shadows: iconShadow,
                                ),
                              ],
                            ),
                            CustomSlider(
                              activeTrackColor: Colors.white,
                              bufferedTrackColor: Colors.grey.shade400,
                              inactiveTrackColor: Colors.white30,
                              totalDuration: Duration(seconds: 232),
                              width: 300,
                              trackHeight: 10,
                              thumbRadius: 10,
                            ),
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

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({
    super.key,
    required this.iconColor,
    required this.iconSize,
    required this.largeIconScale,
    required this.iconShadow,
  });

  final Color iconColor;
  final double iconSize;
  final double largeIconScale;
  final List<Shadow> iconShadow;

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      replacement: InkWell(
        onTap: () {},
        child: Icon(
          Icons.pause,
          color: widget.iconColor,
          size: widget.iconSize * widget.largeIconScale,
          shadows: widget.iconShadow,
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: Icon(
          Icons.play_arrow,
          color: widget.iconColor,
          size: widget.iconSize * widget.largeIconScale,
          shadows: widget.iconShadow,
        ),
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  final double width;
  final double trackHeight;
  final double thumbRadius;
  final Duration totalDuration;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color bufferedTrackColor;

  const CustomSlider(
      {super.key,
      required this.width,
      required this.trackHeight,
      required this.thumbRadius,
      required this.totalDuration,
      required this.activeTrackColor,
      required this.inactiveTrackColor,
      required this.bufferedTrackColor});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double currentXAlignment = 0;
  double currentSliderValue = 0;
  double leftPosition = 0;
  double innerLeftPosition = 0;

  // double getLeftPadding({double? leftPadding}) {

  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.thumbRadius * 2,
      width: widget.width,
      child: LayoutBuilder(builder: (context, constraints) {
        // print(constraints.maxWidth);
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            innerLeftPosition = details.localPosition.dx - widget.thumbRadius;
            if (innerLeftPosition >= (-widget.thumbRadius) &&
                innerLeftPosition <=
                    (constraints.minWidth - widget.thumbRadius)) {
              leftPosition = innerLeftPosition;
              setState(() {});
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment(-1, 0),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                width: widget.width,
                height: widget.trackHeight,
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 20),
                left: leftPosition,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  width: widget.thumbRadius * 2,
                  height: widget.thumbRadius * 2,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
