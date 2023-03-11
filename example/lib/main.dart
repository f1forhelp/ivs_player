import 'dart:ffi';

import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
