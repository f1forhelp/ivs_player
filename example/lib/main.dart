import 'package:flutter/material.dart';
import 'package:ivs_player/ivs_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BaseScreen(),
    );
  }
}

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: [
          CustomTextButton(
            label: "Player Screen",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayerScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function()? ontap;

  const CustomTextButton({super.key, required this.label, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.pink,
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  IvsPlayerController _ivsPlayerController = IvsPlayerController();

  @override
  void initState() {
    super.initState();
    inas();
  }

  inas() async {
    await _ivsPlayerController.loadUrl(
        url:
            "https://takapp-media-cdn.s3.ap-south-1.amazonaws.com/production/vod_22_Nov_2022_vdt-1/video.m3u8");
    await _ivsPlayerController.play();
    _ivsPlayerController.isPlayerLoaded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BaseIvsPlayer(
              ivsPlayerController: _ivsPlayerController,
            ),
          ),
          InkWell(
            onTap: () {
              _ivsPlayerController.startPip();
            },
            child: Text("PIP"),
          )
        ],
      ),
    );
  }
}
