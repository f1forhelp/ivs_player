import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivs_player/ivs_constants.dart';

import 'ivs_player_platform_interface.dart';
part 'ivs_player_controller.dart';

class IvsPlayer {
  Future<String?> getPlatformVersion() {
    return IvsPlayerPlatform.instance.getPlatformVersion();
  }
}

class BaseIvsPlayer extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;

  const BaseIvsPlayer({super.key, required this.ivsPlayerController});

  @override
  State<BaseIvsPlayer> createState() => _BaseIvsPlayerState();
}

class _BaseIvsPlayerState extends State<BaseIvsPlayer> {
  late IvsPlayerController _ivsPlayerController;

  @override
  void initState() {
    _ivsPlayerController = widget.ivsPlayerController;
    super.initState();
  }

  // bool isViewReady = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.pink,
        child: UiKitView(
          onPlatformViewCreated: (id) async {
            _ivsPlayerController._methodChannel =
                MethodChannel("${IvsConstants.viewTypeIvsPlayer}_$id");
            _ivsPlayerController._isPlayerViewLoaded.complete(true);
            // widget.getPlayerController(_ivsPlayerController);
            // _ivsPlayerController.playerState = PlayerState.playerViewLoaded;
            // _ivsPlayerController.setState();
            // _ivsPlayerController._methodChannel =
            //     MethodChannel("${IvsConstants.viewTypeIvsPlayer}_$id");
            // // isViewReady = true;
            // await _ivsPlayerController.loadUrl(
            //     url:
            //         "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8");
            // _ivsPlayerController.play();
            // _ivsPlayerController.isPlayerLoaded = true;
            // _ivsPlayerController._playerLoaded = true;
            // _ivsPlayerController.notifyListeners();
            // setState(() {});
          },
          viewType: IvsConstants.viewTypeIvsPlayer,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }
}
