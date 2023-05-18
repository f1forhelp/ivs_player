import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:ivs_player/src/Model/native_event_model/native_event_model.dart';
import 'package:ivs_player/src/Model/native_event_model/quality.dart';
import 'package:ivs_player/src/player_api.dart';
import 'package:ivs_player/src/player_event_channel.dart';
import 'package:pausable_timer/pausable_timer.dart';

import 'Model/native_event_model/state.dart' hide State;
import 'ivs_constants.dart';
part 'ivs_player_controller.dart';
part 'duration_listener.dart';

class BaseIvsPlayer extends StatefulWidget {
  final IvsPlayerController ivsPlayerController;
  final bool useHybridCompisation;
  final Widget Function(IvsPlayerController) controls;

  const BaseIvsPlayer(
      {super.key,
      required this.ivsPlayerController,
      required this.controls,
      this.useHybridCompisation = false});

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
    print("SetState Is Called");
    bool v = false;
    // This is used in the platform side to register the view.
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
              color: Colors.pink,
              child: Builder(
                builder: (context) {
                  if (Platform.isIOS) {
                    return UiKitView(
                      onPlatformViewCreated: (id) {
                        _ivsPlayerController._viewId = id;
                        if (!_ivsPlayerController
                            ._isPlayerViewLoaded.isCompleted) {
                          _ivsPlayerController._isPlayerViewLoaded
                              .complete(true);
                        }
                      },
                      viewType: IvsConstants.viewTypeIvsPlayer,
                      layoutDirection: TextDirection.ltr,
                      creationParams: creationParams,
                      creationParamsCodec: const StandardMessageCodec(),
                    );
                  } else if (widget.useHybridCompisation) {
                    return PlatformViewLink(
                      viewType: IvsConstants.viewTypeIvsPlayer,
                      surfaceFactory: (
                        BuildContext context,
                        PlatformViewController controller,
                      ) {
                        return AndroidViewSurface(
                          controller: controller as AndroidViewController,
                          gestureRecognizers: const <Factory<
                              OneSequenceGestureRecognizer>>{},
                          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                        );
                      },
                      onCreatePlatformView:
                          (PlatformViewCreationParams params) {
                        ExpensiveAndroidViewController controller =
                            PlatformViewsService.initExpensiveAndroidView(
                          id: params.id,
                          viewType: IvsConstants.viewTypeIvsPlayer,
                          layoutDirection: TextDirection.ltr,
                          creationParams: creationParams,
                          creationParamsCodec: const StandardMessageCodec(),
                          onFocus: () => params.onFocusChanged(true),
                        );
                        controller.addOnPlatformViewCreatedListener(
                          (id) {
                            params.onPlatformViewCreated(id);
                            // _ivsPlayerController._viewId = id;
                            // if (!_ivsPlayerController
                            //     ._isPlayerViewLoaded.isCompleted) {
                            //   _ivsPlayerController._isPlayerViewLoaded
                            //       .complete(true);
                            // }
                          },
                        );
                        return controller;
                      },
                    );
                  } else {
                    return AndroidView(
                      viewType: IvsConstants.viewTypeIvsPlayer,
                      layoutDirection: TextDirection.ltr,
                      creationParams: creationParams,
                      onPlatformViewCreated: (id) {
                        _ivsPlayerController._viewId = id;
                        if (!_ivsPlayerController
                            ._isPlayerViewLoaded.isCompleted) {
                          _ivsPlayerController._isPlayerViewLoaded
                              .complete(true);
                        }
                      },
                      creationParamsCodec: const StandardMessageCodec(),
                    );
                  }
                },
              )),
        ),
        Positioned.fill(child: widget.controls(_ivsPlayerController)),
      ],
    );
  }
}
