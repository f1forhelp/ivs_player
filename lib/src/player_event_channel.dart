// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ivs_player/src/Model/native_event_model/native_event_model.dart';

import 'package:ivs_player/src/player_api.dart';

class PlayerEvents {
  static final PlayerEvents _obj = PlayerEvents._internal();
  factory PlayerEvents() {
    return _obj;
  }
  PlayerEvents._internal();

  // Map<int, IvsPlayerNativeEvent> _playerEventCache = {};

  final EventChannel _playerState = const EventChannel("EventChannelPlayerIvs");

  void getPlayerStateStream(Function(NativeEventModel) onEvent) {
    _playerState.receiveBroadcastStream().listen((event) {
      print("TESTDATA-${jsonDecode(event.toString())}");
      onEvent(NativeEventModel.fromJson(jsonDecode(event.toString())));
    });
  }

  // IvsPlayerNativeEvent _maplayerEvent(dynamic event) {
  //   var str = event.toString();
  //   var data = _getSubString(str: str, start: "#", end: "@");

  //   var viewId = _getSubString(str: str, start: "@", end: "");

  //   if (str.startsWith("ST#")) {
  //     return IvsPlayerNativeEvent(playerState: _mapPlayerStateEnum(data));
  //   } else if (str.startsWith("DU#")) {
  //     double d = double.tryParse(data) ?? 0.0;
  //     return IvsPlayerNativeEvent(duration: Duration(seconds: d.round()));
  //   } else {
  //     return IvsPlayerNativeEvent(error: data);
  //   }
  // }

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

  void dispose(int viewId) {
    // _playerEventCache.remove(viewId);
  }
}
