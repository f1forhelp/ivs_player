part of 'ivs_player_controls.dart';

class QualityPanel extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;

  const QualityPanel({super.key, required this.ivsPlayerController});
  @override
  State<QualityPanel> createState() => _QualityPanelState();
}

class _QualityPanelState extends State<QualityPanel> {
  List<Quality?> quals = [];
  Quality currentQuality = Quality();
  bool isLooping = false;
  double playBackrate = 1;

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

  @override
  void initState() {
    getCurrentQuality();
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
              label: "Quality of current video",
              subLabel: "${currentQuality.name}"),
          SizedBox(
            height: 12,
          ),
          ...quals.map(
            (e) => Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  widget.ivsPlayerController.setQuality(e?.name ?? "");
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.maxFinite, child: Text(e?.name ?? "")),
                ),
              ),
            ),
          ),
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
