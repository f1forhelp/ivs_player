import 'package:flutter/material.dart';
import 'package:ivs_player/ivs_player.dart';
import 'package:ivs_player/src/Model/native_event_model/quality.dart';

part 'context_menu.dart';
part 'play_pause_button.dart';
part 'quality_menu.dart';
part 'playback_speed_panel.dart';
part 'full_screen_button.dart';
part 'custom_slider.dart';

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

Future _showCommonModalSheet(BuildContext context, Widget child) async {
  await showModalBottomSheet(
    useSafeArea: true,
    context: context,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(maxWidth: 440),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: MediaQuery.of(context).viewPadding.bottom + 18,
        ),
        child: child,
      );
    },
  );
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
              InkWell(
                onTap: () {
                  _showCommonModalSheet(
                    context,
                    ContextMenu(
                        ivsPlayerController: widget.ivsPlayerController),
                  );
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
                          shadows: iconShadow,
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedBuilder(
                        animation: widget.ivsPlayerController.durationListener,
                        builder: (context, child) {
                          return CustomSlider(
                            currentValueInPercentage: widget.ivsPlayerController
                                .durationListener.currentDurationInPercentage,
                            getCurrentDurationOnDrag: (p0) {},
                            getCurrentPercentageOnDrag: (p0) {},
                            getCurrentPercentageOnDragStop: (p0) {
                              widget.ivsPlayerController.seekTo(p0 *
                                  widget.ivsPlayerController.totalDuration
                                      .inSeconds);
                            },
                            getCurrentDurationOnDragStop: (d) {},
                            activeTrackColor: Colors.white,
                            bufferedTrackColor: Colors.grey.shade400,
                            inactiveTrackColor: Colors.white30,
                            totalDuration:
                                widget.ivsPlayerController.totalDuration,
                            width: double.infinity,
                            trackHeight: 3,
                            thumbRadius: 10,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: FullScreenButton(
                          ivsPlayerController: widget.ivsPlayerController),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
