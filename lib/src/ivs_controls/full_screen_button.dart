part of 'ivs_player_controls.dart';

class FullScreenButton extends StatelessWidget {
  const FullScreenButton({
    super.key,
    required this.ivsPlayerController,
  });

  final IvsPlayerController ivsPlayerController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenVideo(
                ivsPlayerController: ivsPlayerController,
              ),
            ),
          );
        },
        child: Icon(Icons.fullscreen));
  }
}

class FullScreenVideo extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;
  const FullScreenVideo({super.key, required this.ivsPlayerController});

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IvsPlayerWithcControls(
        ivsPlayerController: widget.ivsPlayerController,
        controls: (p0) => BasicPlayerControls(ivsPlayerController: p0),
      ),
    );
  }
}
