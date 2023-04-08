// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/services.dart';

enum NativePlayerState { ready, idle, playing, buffering, ended, unknown }

class PlayerEvents {
  static final PlayerEvents _obj = PlayerEvents._internal();
  factory PlayerEvents() {
    return _obj;
  }
  PlayerEvents._internal();

  Map<int, IvsPlayerNativeEvent> _playerEventCache = {};

  final EventChannel _playerState = const EventChannel("EventChannelPlayerIvs");

  void getPlayerStateStream(Function(IvsPlayerNativeEvent) onEvent) {
    _playerState.receiveBroadcastStream().listen((event) {
      onEvent(_maplayerEvent(event));
    });
  }

  IvsPlayerNativeEvent _maplayerEvent(dynamic event) {
    var str = event.toString();

    var data = _getSubString(str: str, start: "#", end: "@");

    var viewId = _getSubString(str: str, start: "@", end: "");

    if (str.startsWith("ST#")) {
      return IvsPlayerNativeEvent(playerState: _mapPlayerStateEnum(data));
    } else if (str.startsWith("DU#")) {
      double d = double.tryParse(data) ?? 0.0;
      return IvsPlayerNativeEvent(duration: Duration(seconds: d.round()));
    } else {
      return IvsPlayerNativeEvent(error: data);
    }
  }

  String _getSubString(
      {required String str, required String start, required String end}) {
    final startIndex = str.indexOf(start);
    if (startIndex == -1) {
      return "";
    }
    final endIndex = str.indexOf(end, startIndex + start.length);
    if (endIndex == -1) {
      return "";
    }
    return str.substring(startIndex + start.length, endIndex);
  }

  NativePlayerState _mapPlayerStateEnum(String v) {
    switch (int.tryParse(v)) {
      case 1:
        return NativePlayerState.ready;
      case 2:
        return NativePlayerState.idle;
      case 3:
        return NativePlayerState.playing;
      case 4:
        return NativePlayerState.buffering;
      case 5:
        return NativePlayerState.ended;
      default:
        return NativePlayerState.unknown;
    }
  }

  void dispose(int viewId) {
    _playerEventCache.remove(viewId);
  }
}

class IvsPlayerNativeEvent {
  NativePlayerState? playerState;
  Duration? duration;
  String? error;

  IvsPlayerNativeEvent({this.playerState, this.duration, this.error});

  @override
  String toString() =>
      'IvsPlayerNativeEvent(playerState: $playerState, duration: $duration, error: $error)';
}
