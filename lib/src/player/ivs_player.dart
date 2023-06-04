import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivs_player/src/Model/native_event_model/native_event_model.dart';
import 'package:ivs_player/src/Model/native_event_model/quality.dart';
import 'package:ivs_player/src/player_api.dart';
import 'package:ivs_player/src/player_event_channel.dart';
import '../Model/native_event_model/state.dart' hide State;
import '../ivs_constants.dart';
part '../controller/ivs_player_controller.dart';
part '../duration_listener.dart';

class BaseIvsPlayer extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;

  const BaseIvsPlayer({
    super.key,
    required this.ivsPlayerController,
  });

  @override
  State<BaseIvsPlayer> createState() => _BaseIvsPlayerState();
}

class _BaseIvsPlayerState extends State<BaseIvsPlayer> {
  late IvsPlayerController _ivsPlayerController;

  @override
  void initState() {
    _ivsPlayerController = widget.ivsPlayerController;
    _ivsPlayerController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    return Builder(
      builder: (context) {
        if (Platform.isIOS) {
          return UiKitView(
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
          );
        } else {
          return Texture(
            filterQuality: FilterQuality.none,
            textureId: _ivsPlayerController._viewId,
            freeze: false,
          );
        }
      },
    );
  }
}

class IvsPlayerWithcControls extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;
  final Widget Function(IvsPlayerController) controls;
  const IvsPlayerWithcControls(
      {super.key, required this.ivsPlayerController, required this.controls});

  @override
  State<IvsPlayerWithcControls> createState() => _IvsPlayerWithcControlsState();
}

class _IvsPlayerWithcControlsState extends State<IvsPlayerWithcControls> {
  late IvsPlayerController _ivsPlayerController;

  @override
  void initState() {
    _ivsPlayerController = widget.ivsPlayerController;
    _ivsPlayerController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.pink,
            child: BaseIvsPlayer(
              ivsPlayerController: _ivsPlayerController,
            ),
          ),
        ),
        Positioned.fill(child: widget.controls(_ivsPlayerController)),
      ],
    );
  }
}
