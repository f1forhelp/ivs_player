import 'package:flutter/material.dart';
import 'package:ivs_player/ivs_player.dart';

class BasicPlayerControls extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;

  const BasicPlayerControls({super.key, required this.ivsPlayerController});

  @override
  State<BasicPlayerControls> createState() => _BasicPlayerControlsState();
}

class _BasicPlayerControlsState extends State<BasicPlayerControls> {
  @override
  void initState() {
    widget.ivsPlayerController.durationListener.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  String _getDurationFormatted(Duration du) {
    var sec = du.inSeconds % 60;
    var min = du.inMinutes % 60;

    var secondPadding = sec < 10 ? "0" : "";
    var minutePadding = min < 10 && du.inHours > 0 ? "0" : "";

    if (du.inHours > 0) {
      return "${du.inHours.toString()}:${minutePadding + min.toString()}:${secondPadding + sec.toString()}";
    } else {
      return "${minutePadding + min.toString()}:${secondPadding + sec.toString()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.white;
    double iconSize = 24;
    double largeIconScale = 1.4;
    List<Shadow> iconShadow = const [
      Shadow(color: Colors.black45, blurRadius: 4)
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  onTap: () async {
                    if (widget.ivsPlayerController.isPlaying) {
                      await widget.ivsPlayerController.pause();
                    } else {
                      await widget.ivsPlayerController.play();
                    }
                  },
                  isPlaying: widget.ivsPlayerController.isPlaying,
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
          IconButton(
            onPressed: () {
              //   tempTimer.seekTo(
              //   durationToSeek: Duration(milliseconds: 12),
              // );
              widget.ivsPlayerController.seekTo(0);
            },
            icon: Icon(
              Icons.access_alarm,
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedBuilder(
                    animation: widget.ivsPlayerController.durationListener,
                    builder: (ontext, child) {
                      return Text(
                        "${_getDurationFormatted(widget.ivsPlayerController.durationListener.currentDuration)} / ${_getDurationFormatted(widget.ivsPlayerController.totalDuration)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AnimatedBuilder(
                  animation: widget.ivsPlayerController.durationListener,
                  builder: (context, child) {
                    print(widget
                        .ivsPlayerController.durationListener.currentDuration);
                    return CustomSlider(
                      currentValueInPercentage: widget.ivsPlayerController
                          .durationListener.currentDurationInPercentage,
                      getCurrentDurationOnDrag: (p0) {
                        // widget.ivsPlayerController
                        //     .seekTo(p0.inMilliseconds / 1000);
                      },
                      getCurrentPercentageOnDrag: (p0) {
                        // widget.ivsPlayerController.seekController.value = p0 / 100;
                      },
                      // currentValueInPercentage:
                      //     widget.ivsPlayerController.seekController.value,
                      getCurrentPercentageOnDragStop: (p0) {
                        print(p0);
                        widget.ivsPlayerController.seekTo(p0 *
                            widget.ivsPlayerController.totalDuration.inSeconds);
                      },
                      getCurrentDurationOnDragStop: (d) {
                        print("DUR-$d");
                        // widget.ivsPlayerController
                        //     .seekTo(d.inMilliseconds / 1000);
                      },
                      // key: Key(
                      //     widget.ivsPlayerController.totalDuration.toString()),
                      activeTrackColor: Colors.white,
                      bufferedTrackColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.white30,
                      totalDuration: widget.ivsPlayerController.totalDuration,
                      width: double.infinity,
                      trackHeight: 3,
                      thumbRadius: 10,
                    );
                  },
                ),
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
  final double trackHeight;
  final double thumbRadius;
  final Duration totalDuration;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color bufferedTrackColor;
  final void Function(Duration) getCurrentDurationOnDragStop;
  final void Function(double) getCurrentPercentageOnDragStop;
  final void Function(Duration) getCurrentDurationOnDrag;
  final void Function(double) getCurrentPercentageOnDrag;
  final double currentValueInPercentage;

  const CustomSlider({
    super.key,
    required this.width,
    required this.trackHeight,
    required this.thumbRadius,
    required this.totalDuration,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.bufferedTrackColor,
    required this.getCurrentDurationOnDragStop,
    required this.getCurrentPercentageOnDragStop,
    required this.currentValueInPercentage,
    required this.getCurrentDurationOnDrag,
    required this.getCurrentPercentageOnDrag,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  double innerLeftPosition = 0;
  double percentage = 0;

  String duration = "";
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // double getLeftPadding({double? leftPadding}) {

  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.thumbRadius * 2,
      width: widget.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // print(constraints.maxWidth);
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              innerLeftPosition = details.localPosition.dx - widget.thumbRadius;
              if (innerLeftPosition >= (-widget.thumbRadius) &&
                  innerLeftPosition <=
                      (constraints.minWidth - widget.thumbRadius)) {
                percentage = (innerLeftPosition + widget.thumbRadius) /
                    (constraints.minWidth);
                widget.getCurrentDurationOnDrag(Duration());
                widget.getCurrentPercentageOnDrag(percentage);
              }
              print("START");
              isDragging = true;
              setState(() {});
            },
            onHorizontalDragEnd: (details) {
              isDragging = false;
              widget.getCurrentDurationOnDragStop(Duration());
              widget.getCurrentPercentageOnDragStop(percentage);
              setState(() {});
            },
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment(-1, 0),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                  width: widget.width,
                  height: widget.trackHeight,
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 20),
                  left: isDragging
                      ? innerLeftPosition
                      : widget.currentValueInPercentage *
                              (constraints.minWidth) -
                          widget.thumbRadius,
                  // left:
                  // widget.currentValueInPercentage * (constraints.minWidth) -
                  //     widget.thumbRadius,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    width: widget.thumbRadius * 2,
                    height: widget.thumbRadius * 2,
                  ),
                ),
              ],
            ),
          );
        },
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
    required this.isPlaying,
    this.onTap,
  });

  final void Function()? onTap;
  final bool isPlaying;
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
    return InkWell(
      onTap: widget.onTap,
      child: Visibility(
        visible: !widget.isPlaying,
        replacement: Icon(
          Icons.pause,
          color: widget.iconColor,
          size: widget.iconSize * widget.largeIconScale,
          shadows: widget.iconShadow,
        ),
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
