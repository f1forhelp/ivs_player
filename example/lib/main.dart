import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:ivs_player/ivs_player.dart';
import 'package:ivs_player_example/widgets.dart';

import 'basic_player_screen.dart';

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
  DurationListener tempTimer =
      DurationListener(totalDuration: Duration(seconds: 5));

  @override
  void initState() {
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
            label: "Seek",
            ontap: () {
              tempTimer.seekTo(
                durationToSeek: Duration(milliseconds: 12),
              );
            },
          ),
          Text(tempTimer.currentDuration.toString()),
        ],
      ),
    );
  }
}
