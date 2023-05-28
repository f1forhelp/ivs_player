part of 'ivs_player_controls.dart';

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
