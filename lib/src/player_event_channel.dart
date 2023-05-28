// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ivs_player/src/Model/native_event_model/native_event_model.dart';

class PlayerEvents {
  static final PlayerEvents _obj = PlayerEvents._internal();
  factory PlayerEvents() {
    return _obj;
  }
  PlayerEvents._internal();

  EventChannel? _playerState;

  void getPlayerStateStream(Function(NativeEventModel) onEvent, int viewId) {
    _playerState = EventChannel("EventChannelPlayerIvs_id=$viewId");
    _playerState?.receiveBroadcastStream().listen((event) {
      onEvent(NativeEventModel.fromJson(jsonDecode(event.toString())));
    });
  }

  void dispose(int viewId) {
    // _playerEventCache.remove(viewId);
  }
}
