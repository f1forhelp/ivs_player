part of 'ivs_player_controls.dart';

class PlaybackSpeedPanel extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;

  const PlaybackSpeedPanel({super.key, required this.ivsPlayerController});
  @override
  State<PlaybackSpeedPanel> createState() => _PlaybackSpeedPanelState();
}

class _PlaybackSpeedPanelState extends State<PlaybackSpeedPanel> {
  double playBackrate = 1;

  List<double> availableSpeed = [
    0.5,
    0.75,
    1,
    1.25,
    1.5,
  ];

  getCurrentSpeed() async {
    var r = await widget.ivsPlayerController.playbackRate();
    playBackrate = r;
    setState(() {});
  }

  setCurrentSpeed(double rate) async {
    widget.ivsPlayerController.playbackRate(v: rate);
  }

  @override
  void initState() {
    getCurrentSpeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      // margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            // height: 100,
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(99),
                right: Radius.circular(99),
              ),
            ),
            width: 44,
            height: 4,
          ),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Playback speed",
            ),
          ),
          SizedBox(
            height: 12,
          ),
          ...availableSpeed.map((e) {
            if (e == 1) {
              return _PlaybackSpeedLabel(
                speed: "Normal",
                onTap: () {
                  setCurrentSpeed(1);
                  Navigator.pop(context);
                },
                isChecked: playBackrate == e ? true : false,
              );
            } else {
              return _PlaybackSpeedLabel(
                speed: e.toString(),
                onTap: () {
                  setCurrentSpeed(e);
                  Navigator.pop(context);
                },
                isChecked: playBackrate == e ? true : false,
              );
            }
          }),
          SizedBox(
            height: 14,
          ),
          Divider(height: 1),
          SizedBox(
            height: 14,
          ),
          InkWell(
            // splashColor: Colors.black,
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.close,
                ),
                SizedBox(
                  width: 12,
                ),
                Text("Cancel"),
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }
}

class _PlaybackSpeedLabel extends StatelessWidget {
  final bool isChecked;
  final String speed;
  final void Function()? onTap;
  const _PlaybackSpeedLabel(
      {super.key, required this.isChecked, required this.speed, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            isChecked
                ? Icon(
                    Icons.check,
                    size: 22,
                  )
                : SizedBox(),
            SizedBox(
              width: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: isChecked ? 0 : 22),
              child: Text(speed),
            ),
          ],
        ),
      ),
    );
  }
}
