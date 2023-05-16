part of 'ivs_player_controls.dart';

class _PlayPauseButton extends StatefulWidget {
  const _PlayPauseButton({
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
  State<_PlayPauseButton> createState() => __PlayPauseButtonState();
}

class __PlayPauseButtonState extends State<_PlayPauseButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 160),
        child: widget.isPlaying
            ? Icon(
                Icons.pause,
                key: Key("pause"),
                color: widget.iconColor,
                size: widget.iconSize * widget.largeIconScale,
                shadows: widget.iconShadow,
              )
            : Icon(
                Icons.play_arrow,
                key: Key("play"),
                color: widget.iconColor,
                size: widget.iconSize * widget.largeIconScale,
                shadows: widget.iconShadow,
              ),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
