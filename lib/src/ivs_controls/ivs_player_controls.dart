import 'package:flutter/material.dart';
import 'package:ivs_player/ivs_player.dart';
import 'package:ivs_player/src/Model/native_event_model/quality.dart';

part 'context_menu.dart';
part 'play_pause_button.dart';
part 'quality_panel.dart';
part 'playback_speed_panel.dart';

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

class BasicPlayerControls extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;

  const BasicPlayerControls({super.key, required this.ivsPlayerController});

  @override
  State<BasicPlayerControls> createState() => _BasicPlayerControlsState();
}

class _BasicPlayerControlsState extends State<BasicPlayerControls> {
  @override
  void initState() {
    widget.ivsPlayerController.addListener(() {
      setState(() {});
    });
    super.initState();
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
              Visibility(
                visible: !(widget.ivsPlayerController.currentQuality.name ==
                        "unknown" ||
                    widget.ivsPlayerController.currentQuality.name == null),
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white, width: 1.2),
                  ),
                  child: Text(
                    widget.ivsPlayerController.currentQuality.name ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    constraints: BoxConstraints(maxWidth: 440),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 14,
                          right: 14,
                          bottom:
                              MediaQuery.of(context).viewPadding.bottom + 18,
                        ),
                        child: ContextMenu(
                            ivsPlayerController: widget.ivsPlayerController),
                      );
                    },
                  );
                  // Scaffold.of(context).showBottomSheet((context) => ContextMenu(
                  //     ivsPlayerController: widget.ivsPlayerController));
                },
                child: Icon(
                  Icons.settings,
                  color: iconColor,
                  size: iconSize,
                  shadows: iconShadow,
                ),
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
              _PlayPauseButton(
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
          // IconButton(
          //   onPressed: () {
          //     //   tempTimer.seekTo(
          //     //   durationToSeek: Duration(milliseconds: 12),
          //     // );
          //     widget.ivsPlayerController.seekTo(0);
          //   },
          //   icon: Icon(
          //     Icons.access_alarm,
          //     color: Colors.white,
          //   ),
          // ),
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
                        widget.ivsPlayerController.seekTo(p0 *
                            widget.ivsPlayerController.totalDuration.inSeconds);
                      },
                      getCurrentDurationOnDragStop: (d) {
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
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              double actualPosi = details.localPosition.dx - widget.thumbRadius;
              if (actualPosi >= (-widget.thumbRadius) &&
                  actualPosi <= (constraints.minWidth - widget.thumbRadius)) {
                innerLeftPosition = actualPosi;

                percentage = (innerLeftPosition + widget.thumbRadius) /
                    (constraints.minWidth);
                widget.getCurrentDurationOnDrag(Duration());
                widget.getCurrentPercentageOnDrag(percentage);
              }
              // print(inne);
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
