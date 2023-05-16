part of 'ivs_player_controls.dart';

class ContextMenu extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;

  const ContextMenu({super.key, required this.ivsPlayerController});
  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  List<Quality?> quals = [];
  Quality currentQuality = Quality();
  bool isLooping = false;
  double playBackrate = 1;
  bool isAutoQualityMode = true;

  getIsAutoQualityMode() {}

  getQual() async {
    var r = await widget.ivsPlayerController.qualities();

    quals = r
        .map<Quality>(
            (e) => Quality(name: e?.name, height: e?.height, width: e?.width))
        .toList();
    setState(() {});
  }

  getCurrentQuality() async {
    currentQuality = widget.ivsPlayerController.currentQuality;
  }

  getIsLooping() async {
    isLooping = await widget.ivsPlayerController.looping();
    setState(() {});
  }

  getCurrentSpeed() async {
    playBackrate = await widget.ivsPlayerController.playbackRate();
    setState(() {});
  }

  @override
  void initState() {
    getIsLooping();
    getCurrentQuality();
    getCurrentSpeed();
    getQual();
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
          _IconTextButton(
            iconData: Icons.settings_outlined,
            label: "Quality",
            subLabel: currentQuality.name,
            onTap: () {
              Navigator.pop(context);
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
                      bottom: MediaQuery.of(context).viewPadding.bottom + 18,
                    ),
                    child: QualityPanel(
                        ivsPlayerController: widget.ivsPlayerController),
                  );
                },
              );
            },
          ),
          _IconTextButton(
            iconData: Icons.loop_outlined,
            label: "Loop video",
            subLabel: isLooping ? "On" : "Off",
            onTap: () async {
              widget.ivsPlayerController.looping(v: !isLooping);
              await getIsLooping();
              Navigator.pop(context);
              if (isLooping) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("True"),
                  ),
                );
              }
            },
          ),
          _IconTextButton(
            iconData: Icons.speed_outlined,
            label: "Playback speed",
            subLabel: playBackrate == 1 ? "Normal" : "${playBackrate}x",
            onTap: () {
              Navigator.pop(context);
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
                      bottom: MediaQuery.of(context).viewPadding.bottom + 18,
                    ),
                    child: PlaybackSpeedPanel(
                        ivsPlayerController: widget.ivsPlayerController),
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class _IconTextButton extends StatelessWidget {
  final IconData? iconData;
  final String label;
  final String? subLabel;
  final void Function()? onTap;
  const _IconTextButton(
      {super.key,
      this.iconData,
      required this.label,
      this.subLabel,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconData == null
                ? SizedBox()
                : Icon(
                    iconData,
                    // weight: 1,
                    // opticalSize: 20,
                    color: Colors.black54,
                    size: 22,
                  ),
            iconData == null
                ? SizedBox()
                : SizedBox(
                    width: 18,
                  ),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            subLabel != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    width: 2,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      // borderRadius: BorderRadius.circular(2),
                      shape: BoxShape.circle,
                    ))
                : SizedBox(),
            Text(
              subLabel ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
