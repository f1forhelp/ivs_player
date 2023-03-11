import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivs_player/src/player_api.dart';

import 'ivs_constants.dart';
part 'ivs_player_controller.dart';

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
    _ivsPlayerController.dispose();
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
          onPlatformViewCreated: (id) {
            _ivsPlayerController._viewId = id;
            if (!_ivsPlayerController._isPlayerViewLoaded.isCompleted) {
              _ivsPlayerController._isPlayerViewLoaded.complete(true);
            }
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
