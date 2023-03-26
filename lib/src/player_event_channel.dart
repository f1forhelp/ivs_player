import 'package:flutter/services.dart';

class PlayerEvents {
  static final PlayerEvents _obj = PlayerEvents._internal();
  factory PlayerEvents() {
    return _obj;
  }
  PlayerEvents._internal();

  final EventChannel playerState = EventChannel("EventChannelPlayerIvs");
}
