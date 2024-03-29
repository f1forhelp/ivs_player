import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:ivs_player/ivs_player.dart';
import 'package:ivs_player_example/widgets.dart';
import 'basic_player_screen.dart';

// import 'package:livekit_client/livekit_client.dart';
void main() {
  Float float = Float();
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
          CustomTextButton(
            label: "Demo timer",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DemoTimer(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DemoTimer extends StatefulWidget {
  const DemoTimer({super.key});

  @override
  State<DemoTimer> createState() => _DemoTimerState();
}

class _DemoTimerState extends State<DemoTimer> {
  DurationListener tempTimer = DurationListener();

  @override
  void initState() {
    tempTimer.totalDuration = Duration(seconds: 30);
    tempTimer.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    tempTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextButton(
            label: "Start",
            ontap: () {
              tempTimer.start();
            },
          ),
          CustomTextButton(
            label: "Stop",
            ontap: () {
              tempTimer.stop();
            },
          ),
          CustomTextButton(
            label: "Pause",
            ontap: () {
              tempTimer.pause();
            },
          ),
          CustomTextButton(
            label: "1.5",
            ontap: () {
              tempTimer.playBackRate(1.5);
            },
          ),
          CustomTextButton(
            label: "0.5",
            ontap: () {
              tempTimer.playBackRate(0.5);
            },
          ),
          CustomTextButton(
            label: "1",
            ontap: () {
              tempTimer.playBackRate(1);
            },
          ),
          CustomTextButton(
            label: "Seek",
            ontap: () {
              tempTimer.seekTo(
                durationToSeek: Duration(seconds: 2),
              );
            },
          ),
          Text(tempTimer.currentDuration.toString()),
        ],
      ),
    );
  }
}

class PausableTimer extends ChangeNotifier {
  Timer? _timer;

  Duration _lastDuration = const Duration();

  Duration _currentDuration = const Duration();

  Duration _totalDuration = const Duration();

  Duration get currentDuration => _currentDuration;

  PausableTimer({required Duration totalDuration}) {
    _totalDuration = totalDuration;
  }

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      if (timer.isActive && _currentDuration < _totalDuration) {
        _currentDuration =
            Duration(milliseconds: 10 * timer.tick) + _lastDuration;
      } else {
        _timer?.cancel();
      }
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
    _currentDuration = Duration.zero;
    _lastDuration = Duration.zero;
    notifyListeners();
  }

  void pause() {
    _timer?.cancel();
    _lastDuration = currentDuration;
    notifyListeners();
  }

  void seekTo({Duration? durationToSeek}) {
    // assert(durationToSeek == null && percentageToSeek == null);
    if (durationToSeek != null) {
      _timer?.cancel();

      _currentDuration = Duration.zero;
      // _lastDuration = Duration.zero;
      _lastDuration = durationToSeek;
      start();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
